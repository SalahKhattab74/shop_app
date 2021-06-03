import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/moduels/shop_app/login/cubit/login_cubit.dart';
import 'package:shop_app/moduels/shop_app/login/cubit/login_state.dart';
import 'package:shop_app/moduels/shop_app/register/shop_register_screen.dart';
import 'package:shop_app/network/local/cahce_helper.dart';
import 'package:shop_app/shared/components.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/constants.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context )=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
       listener: (context,state){
         if(state is ShopLoginSuccessState){
           if(state.loginModel.status){
             print(state.loginModel.data.token);
             print(state.loginModel.message);
             CacheHelper.saveData(key: 'token',
                 value: state.loginModel.data.token).then((value) => {
                   token = state.loginModel.data.token,
              navigateAndFinish(context,ShopLayout()),
             });
           }
           else{
             print(state.loginModel.message);
             showToast(
               text: state.loginModel.message,
               state: ToastStates.ERROR,
             );
           }
         }
       },
        builder: (context,state){
         return Scaffold(
           appBar: AppBar(),
           body: Center(
             child: SingleChildScrollView(
               child: Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Form(
                   key: formKey,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text('LOGIN',
                           style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.black)),
                       Text('Login Now And Get Best Offers',
                           style: Theme.of(context).
                           textTheme.bodyText1.copyWith(color: Colors.grey)),
                       SizedBox(height: 30.0,),
                       defaultFormField(
                           controller: emailController,
                           type: TextInputType.emailAddress,
                           validate: (String value){
                             if(value.isEmpty){
                               return 'Please Enter Your Email Address';
                             }
                           },
                           label: 'Email Address',
                           prefix: Icons.email),
                       SizedBox(height: 15.0,),
                       defaultFormField(
                           controller: passwordController,
                           type: TextInputType.visiblePassword,
                           suffix:  ShopLoginCubit.get(context).suffix,
                            isPass:  ShopLoginCubit.get(context).isPassword,
                            onSubmit: (value){
                         if(formKey.currentState.validate()){
                        ShopLoginCubit.get(context).userLogin(
                            email: emailController.text,
                         password: passwordController.text);
                           }},
                           suffixPressed: (){
                             ShopLoginCubit.get(context).changePasswordVisibility();
                           },
                           validate: (String value){
                             if(value.isEmpty){
                               return 'Password is to Short';
                             }
                           },
                           label: 'Password',
                           prefix: Icons.lock_outline),
                       SizedBox(height: 25.0,),
                       ConditionalBuilder(
                         condition: state is! ShopLoginLoadingState,
                         builder: (context)=>defaultButton(
                           function: (){
                             if(formKey.currentState.validate()){
                               ShopLoginCubit.get(context).userLogin(
                                   email: emailController.text,
                                   password: passwordController.text);
                             }
                           },
                           text: 'LOGIN',
                           isUpperCase : true,
                         ),
                         fallback: (context)=>Center(child: CircularProgressIndicator()),
                       ),
                       SizedBox(height: 15.0,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text('Don\'t Have An Account?'),
                           defaultTextButton(function:(){
                             navigateTo(context, ShopRegisterScreen());
                           } , text: 'Register Now')
                         ],
                       ),
                     ],
                   ),
                 ),
               ),
             ),
           ),
         );
        },
      ),
    );
  }
}
