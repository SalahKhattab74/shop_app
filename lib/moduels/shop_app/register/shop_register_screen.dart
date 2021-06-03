import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/moduels/shop_app/login/cubit/login_cubit.dart';
import 'package:shop_app/moduels/shop_app/login/cubit/login_state.dart';
import 'package:shop_app/moduels/shop_app/login/shop_login_screen.dart';
import 'package:shop_app/moduels/shop_app/register/cubit/register_cubit.dart';
import 'package:shop_app/moduels/shop_app/register/cubit/register_states.dart';
import 'package:shop_app/network/local/cahce_helper.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/constants.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state){
          if(state is ShopRegisterSuccessState){
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
                        Text('REGISTER',
                            style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.black)),
                        Text('Register Now And Get Best Offers',
                            style: Theme.of(context).
                            textTheme.bodyText1.copyWith(color: Colors.grey)),
                        SizedBox(height: 30.0,),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Please Enter Your Name';
                              }
                            },
                            label: 'User Name',
                            prefix: Icons.person),
                        SizedBox(height: 15.0,),
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
                            suffix:  ShopRegisterCubit.get(context).suffix,
                            isPass:  ShopRegisterCubit.get(context).isPassword,
                            onSubmit: (value){
                              },
                            suffixPressed: (){
                              ShopRegisterCubit.get(context).changePasswordVisibility();
                            },
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Password is to Short';
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock_outline),
                        SizedBox(height: 15.0,),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Please Enter Your Phone';
                              }
                            },
                            label: 'Phone',
                            prefix: Icons.phone),
                        SizedBox(height: 25.0,),
                        ConditionalBuilder(
                          condition: state is !ShopRegisterLoadingState,
                          builder: (context)=>defaultButton(
                            function: (){
                              if(formKey.currentState.validate()){
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text);
                              }
                            },
                            text: 'register',
                            isUpperCase : true,
                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 15.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Have An Account?'),
                            defaultTextButton(function:(){
                              navigateTo(context, ShopLoginScreen());
                            } , text: 'Login Now')
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
