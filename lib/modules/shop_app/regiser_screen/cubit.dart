import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/shop_app/login_model.dart';
import 'package:shop/modules/shop_app/login/states.dart';
import 'package:shop/modules/shop_app/regiser_screen/states.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';


class ShopCubitRegister extends Cubit<RegisterStates>
{
  ShopCubitRegister() : super(InitialRegisterState());

  static ShopCubitRegister get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  bool ispass = true;
  IconData icon = Icons.visibility;

  void changePass() {
    if (ispass == false) {
      ispass = true;
      icon = Icons.visibility;
    }
    else {
      ispass = false;
      icon = Icons.visibility_off;
    }
    emit(ChangePassRegisterState());
  }

  void userRegister({
  required String email,
  required String password,
  required String name,
  required String phone,
})
  {
    emit(LoadingRegisterState());
    DioHelper.postData(
        path: REGISTER,
        data: {
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
        }).then((value) {
          loginModel = ShopLoginModel.fromJson(value.data);

          emit(SuccessRegisterState(loginModel!));
    }).catchError((error){
      emit(ErrorRegisterState(error.toString()));
      print('error is ${error.toString()}');
    });
  }
}