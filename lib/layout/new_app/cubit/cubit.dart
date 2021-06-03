import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/new_app/cubit/states.dart';
import 'package:shop_app/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business,), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports,), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science_rounded,), label: 'Science'),
  ];
  List<Widget> screens =[
    // BusinessScreen(),
    // SportsScreen(),
    // ScienceScreen(),
  ];
  void changeBottomNavBar(int index){
    currentIndex = index;
    // if(index ==1){
    //   getSports();
    // }
    // if(index ==2){
    //   getScience();
    // }
    emit(NewsBottomNavState());
  }
  List <dynamic> business = [];
  void getBusiness (){
    emit(NewsGetBusinessLoadingState());
    if(business.length == 0)
      {
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country':'eg',
              'category':'business',
              'apiKey':'f7105ec7682a402e91ff7282144f31a7',
            }).then((value) => {
          //  print(value.data.toString()),
          business = value.data['articles'],
          print(business[0]['title']),
          emit(NewsGetBusinessSuccessState()),
        }).catchError((error){
          emit(NewsGetBusinessErrorState(error.toString()));
          print(error.toString());
        });
      }else{
      emit(NewsGetBusinessSuccessState());

  }

  }

  List <dynamic> sports = [];
  void getSports (){
    emit(NewsGetSportsLoadingState());
    if(sports.length == 0)
      {
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country':'eg',
              'category':'sports',
              'apiKey':'f7105ec7682a402e91ff7282144f31a7',
            }).then((value) => {
          //  print(value.data.toString()),
          sports = value.data['articles'],
          print(sports[0]['title']),
          emit(NewsGetSportsSuccessState()),
        }).catchError((error){
          emit(NewsGetSportsErrorState(error.toString()));
          print(error.toString());
        });
      }
    else{
      emit(NewsGetSportsSuccessState());

  }
  }

  List <dynamic> science = [];
  void getScience(){
    emit(NewsGetScienceLoadingState());
    if(science.length==0)
      { DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apiKey':'f7105ec7682a402e91ff7282144f31a7',
          }).then((value) => {
        //  print(value.data.toString()),
        science = value.data['articles'],
        print(science[0]['title']),
        emit(NewsGetScienceSuccessState()),
      }).catchError((error){
        emit(NewsGetScienceErrorState(error.toString()));
        print(error.toString());
      });
      }
    else{
      emit(NewsGetScienceSuccessState());

  }

  }

  List <dynamic> search = [];
  void getSearch(String value){
    emit(NewsGetSearchLoadingState());
    search = [];

    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'$value',
          'apiKey':'f7105ec7682a402e91ff7282144f31a7',
        }).then((value) => {
      //  print(value.data.toString()),
      search = value.data['articles'],
      print(search[0]['title']),
      emit(NewsGetSearchSuccessState()),
    }).catchError((error){
      emit(NewsGetSearchErrorState(error.toString()));
      print(error.toString());
    });
  }
}