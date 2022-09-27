import 'package:shop/models/shop_app/login_model.dart';

abstract class RegisterStates{}
class InitialRegisterState extends RegisterStates{}
class ChangePassRegisterState extends RegisterStates{}
class LoadingRegisterState extends RegisterStates{}
class SuccessRegisterState extends RegisterStates{
 late final ShopLoginModel loginModel;
 SuccessRegisterState(this.loginModel);
}
class ErrorRegisterState extends RegisterStates{
 late final String error;
 ErrorRegisterState(this.error);
}