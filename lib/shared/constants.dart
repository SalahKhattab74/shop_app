
import 'package:shop_app/moduels/shop_app/login/shop_login_screen.dart';
import 'package:shop_app/network/local/cahce_helper.dart';
import 'package:shop_app/shared/components.dart';

void signOut (context){
  CacheHelper.removeData(key: 'token').then((value) => {
    if(value){
      navigateAndFinish(context,ShopLoginScreen()),
    }
  });
}
void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
String token = '';