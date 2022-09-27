// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:myapp/models/shop_app/login_model.dart';
// import 'package:myapp/modules/shop_app/login/states.dart';
// import 'package:myapp/shared/components/constants.dart';
// import 'package:myapp/shared/network/end_points.dart';
// import 'package:myapp/shared/network/remote/dio_helper.dart';
//
//
// class ShopCubitLogin extends Cubit<LoginStates>
// {
//   ShopCubitLogin() : super(InitialState());
//
//   static ShopCubitLogin get(context) => BlocProvider.of(context);
//   ShopLoginModel? loginModel;
//
//   bool ispass = true;
//   IconData icon = Icons.visibility;
//
//   void changePass() {
//     if (ispass == false) {
//       ispass = true;
//       icon = Icons.visibility;
//     }
//     else {
//       ispass = false;
//       icon = Icons.visibility_off;
//     }
//     emit(ChangePassState());
//   }
//
//   void userLogin({
//   required String email,
//   required String password,
// })
//   {
//     emit(LoadingState());
//     DioHelper.postData(
//         path: LOGIN,
//         data: {
//           'email': email,
//           'password': password,
//         }).then((value) {
//           loginModel = ShopLoginModel.fromJson(value.data);
//
//           emit(SuccessState(loginModel!));
//     }).catchError((error){
//       emit(ErrorState(error.toString()));
//       print('error is ${error.toString()}');
//     });
//   }
// }