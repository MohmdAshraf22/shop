import 'package:shop/models/shop_app/favourite_model.dart';
import 'package:shop/models/shop_app/login_model.dart';
import 'package:shop/models/shop_app/profile_model.dart';

abstract class ShopStates{}
class InitialState extends ShopStates{}
class ChangeModeState extends ShopStates{}
class ChangeCurrentState extends ShopStates{}

class ShopLadingHomeData extends ShopStates{}
class ShopSuccessHomeData extends ShopStates{}
class ShopErrorHomeData extends ShopStates{}

class ShopLadingCategoriesModel extends ShopStates{}
class ShopSuccessCategoriesModel extends ShopStates{}
class ShopErrorCategoriesModel extends ShopStates{}

class ShopSuccessFavouritesModel extends ShopStates{
  late AddFavourites? model;
  ShopSuccessFavouritesModel(this.model);
}
class ShopErrorFavouritesModel extends ShopStates{}
class ShopChangeFavouritesModel extends ShopStates{}

class ShopSuccessGetFavouriteModel extends ShopStates{}
class ShopErrorGetFavouriteModel extends ShopStates{}
class ShopLoadingGetFavouriteModel extends ShopStates{}

class ShopSuccessGetProfile extends ShopStates{}
class ShopErrorGetProfile extends ShopStates{}

class ShopSuccessUpdateProfile extends ShopStates{
  //
}
class ShopErrorUpdateProfile extends ShopStates{}
class ShopLoadingUpdateProfile extends ShopStates{}

class ChangePassLoginState extends ShopStates{}
class LoadingLoginState extends ShopStates{}
class SuccessLoginState extends ShopStates{
  late final ShopLoginModel loginModel;
  SuccessLoginState(this.loginModel);
}
class ErrorLoginState extends ShopStates{
  late final String error;
  ErrorLoginState(this.error);
}

// class ShopSuccessGetSearchModel extends ShopStates{}
// class ShopErrorGetSearchModel extends ShopStates{}
// class ShopLoadingGetSearchModel extends ShopStates{}

class ShopSuccessGetProductDetails extends ShopStates{}
class ShopErrorGetProductDetails extends ShopStates{}
class ShopLoadingGetProductDetails extends ShopStates{}
