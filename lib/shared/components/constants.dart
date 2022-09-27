import 'package:shop/modules/shop_app/login/shop_login.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

String? token ='';
String? uId ='';
void signOut(context)
{
  CacheHelper.removeData(
      key: 'token',
  ).then((value) {
    if(value) {
      navigateAndFinish(context, ShopLogin());
    }
  });
}