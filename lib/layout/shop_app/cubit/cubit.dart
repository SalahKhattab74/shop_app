import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_app/categories_model.dart';
import 'package:shop_app/models/shop_app/change_favorites_model.dart';
import 'package:shop_app/models/shop_app/favorites_model.dart';
import 'package:shop_app/models/shop_app/home_model.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/moduels/shop_app/categories/categories_screen.dart';
import 'package:shop_app/moduels/shop_app/favourites/favourite_screen.dart';
import 'package:shop_app/moduels/shop_app/products/products_screen.dart';
import 'package:shop_app/moduels/shop_app/settings/settings_screen.dart';
import 'package:shop_app/network/endPoints/endPoints.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/constants.dart';

class ShopCubit extends Cubit<ShopStates>{

  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;

  List<Widget> bottomScreen =[
    ProductsScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];
  void changeBottom(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavStates());
  }
  HomeModel homeModel;
  Map<int,bool> favourites = {};
  void getHomeData(){
    emit(ShopLoadingHomeDataStates());
    DioHelper.getData(
        url: HOME,
        token: token,
    ).then((value) {
      print("got here");
     homeModel = HomeModel.fromJson(value.data);
      print(homeModel.status);
     homeModel.data.products.forEach((element){
        favourites.addAll({
          element.id : element.inFavourite,
        });
      });
      print(favourites.toString());
      emit(ShopSuccessHomeDataStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataStates());
    });
  }
  CategoriesModel categoriesModel;
  void getCategoriesData(){
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      print("got here");
      categoriesModel = CategoriesModel.fromJson(value.data);
      print('hot here 2 ');
      print(homeModel.status);
      printFullText(homeModel.data.banners.toString ());
      emit(ShopSuccessCategoriesStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesStates());
    });
  }
  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId)
  {
    favourites[productId] = !favourites[productId];
    emit(ShopChangeFavoritesStates());
    DioHelper.postDat(
        url: FAVORITES,
        data: {
          'product_id':productId,
        },
      token: token,
    ).then((value) => {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data),
      print(value.data),
      if(!changeFavoritesModel.status){
        favourites[productId] = !favourites[productId],
    }else{
        getFavorites(),
      },

      emit(ShopSuccessChangeFavoritesStates(changeFavoritesModel)),
    })
        .catchError((error){
      favourites[productId] = !favourites[productId];
      emit(ShopErrorChangeFavoritesStates());
    });
  }
  FavoritesModel favoritesModel;
  void getFavorites(){
    emit(ShopLoadingGetFavoritesStates());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      print("got here");
      favoritesModel = FavoritesModel.fromJson(value.data);
      printFullText(value.data.toString());
      emit(ShopSuccessGetFavoritesStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesStates());
    });
  }
  ShopLoginModel userModel;
  void getUserData()
  {
    emit(ShopLoadingUserDataStates());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      print("got here");
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(userModel.data.name);
      emit(ShopSuccessGetUserDataStates(userModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetUserDataStates());
    });
  }
  void updateUserData({
      @required String name,
      @required String email,
      @required String phone,}
      )
  {
    emit(ShopLoadingUpdateUserStates());
    DioHelper.putData(
      url: UPDATE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,

      }
    ).then((value) {
      print("got here");
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(userModel.data.name);
      emit(ShopSuccessUpdateUserStates(userModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserStates());
    });
  }

}
