import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc_observer.dart';
import 'package:shop_app/layout/new_app/cubit/app_cubit.dart';
import 'package:shop_app/layout/new_app/cubit/app_states.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/moduels/shop_app/login/shop_login_screen.dart';
import 'package:shop_app/moduels/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/network/local/cahce_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'layout/new_app/cubit/cubit.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool isDark = CacheHelper.getData(key: 'isDark');
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  if(onBoarding!=null){
    if(token!=null) widget = ShopLayout();
      else widget = ShopLoginScreen();
  }else{
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       BlocProvider(create: (context) => NewsCubit()..getBusiness()..getSports()..getScience()),
        BlocProvider(create: (BuildContext context)
        =>AppCubit()..changeAppMode(
          fromShared: isDark,
        ),),
        BlocProvider(create: (BuildContext context) =>ShopCubit()
          ..getHomeData()..getCategoriesData()..getFavorites()..getUserData()),
      ],
      child:BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,

          );
        },
      ),

    );
  }
}
