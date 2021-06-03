import 'package:shop_app/models/shop_app/change_favorites_model.dart';
import 'package:shop_app/models/shop_app/login_model.dart';

abstract class ShopStates{}

class ShopInitialStates extends ShopStates{}

class ShopChangeBottomNavStates extends ShopStates{}

class ShopLoadingHomeDataStates extends ShopStates{}

class ShopSuccessHomeDataStates extends ShopStates{}

class ShopErrorHomeDataStates extends ShopStates{}

class ShopSuccessCategoriesStates extends ShopStates{}

class ShopErrorCategoriesStates extends ShopStates{}

class ShopSuccessChangeFavoritesStates extends ShopStates{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesStates(this.model);
}

class ShopChangeFavoritesStates extends ShopStates{}

class ShopErrorChangeFavoritesStates extends ShopStates{}

class ShopLoadingGetFavoritesStates extends ShopStates{}

class ShopSuccessGetFavoritesStates extends ShopStates{}

class ShopErrorGetFavoritesStates extends ShopStates{}

class ShopLoadingUserDataStates extends ShopStates{}

class ShopSuccessGetUserDataStates extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessGetUserDataStates(this.loginModel);
}

class ShopErrorGetUserDataStates extends ShopStates{}

class ShopLoadingUpdateUserStates extends ShopStates{}

class ShopSuccessUpdateUserStates extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserStates(this.loginModel);
}

class ShopErrorUpdateUserStates extends ShopStates{}