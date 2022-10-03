
import 'dart:convert';

import 'package:shop/models/shop_app/details_product.dart';
import 'package:shop/models/shop_app/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_app/states_shop.dart';
import 'package:shop/models/shop_app/categories_model.dart';
import 'package:shop/models/shop_app/favourite_model.dart';
import 'package:shop/models/shop_app/get_fav_model.dart';
import 'package:shop/models/shop_app/get_fav_model.dart';
import 'package:shop/models/shop_app/home_model.dart';
import 'package:shop/models/shop_app/profile_model.dart';
import 'package:shop/models/shop_app/search_model.dart';
import 'package:shop/modules/shop_app/categories/categories_screen.dart';
import 'package:shop/modules/shop_app/favourits/favourite_screen.dart';
import 'package:shop/modules/shop_app/products/product_screen.dart';
import 'package:shop/modules/shop_app/setting/settings.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

class CubitShop extends Cubit<ShopStates> {
  CubitShop() : super(InitialState());

  static CubitShop get(context) => BlocProvider.of(context);

  int current = 0;
  List<Widget> BottomScreens = [
    ProductScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];

  void ChangeCurrent(int value) {
    if(value == 2)
      getFavourite();
    current = value;
    emit(ChangeCurrentState());
  }

  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  Map<int, bool>? favourite = {};
  AddFavourites? addFavourites;
  GetFavouriteModel? favouriteModel;
  Products? info;
  void getHomeData() {
    emit(ShopLadingHomeData());
    DioHelper.getData(
      path: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data.products.forEach((element) {
        favourite!.addAll({
          element.id: element.in_favorites,
        });
      });
      emit(ShopSuccessHomeData());
    }).catchError((error) {
      print('error is ${error.toString()}');
      emit(ShopErrorHomeData());
    });
  }

  void getCategoriesModel() {
    DioHelper.getData(
      path: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data) ;
      emit(ShopSuccessCategoriesModel());
    }).catchError((error) {
      emit(ShopErrorCategoriesModel());
    });
  }

  void postFavouriteModel(int idFav) {
    favourite![idFav] = !favourite![idFav]!;
    emit(ShopChangeFavouritesModel());
      DioHelper.postData(
        path: FAVOURITES,
        data: {
          'product_id': idFav
        },
        token: token,
      ).then((value){
        addFavourites = AddFavourites.fromJson(value.data);
        if(!addFavourites!.status!){
          favourite![idFav] = !favourite![idFav]!;
          print(0);
        }
        else {
          getFavourite();
          print(111);
        }

        emit(ShopSuccessFavouritesModel(addFavourites));
      }).catchError((error) {
        if(!addFavourites!.status!){
          favourite![idFav] = !favourite![idFav]!;
        }
        emit(ShopErrorFavouritesModel());
      });

  }

  void getFavourite() {
    emit(ShopLoadingGetFavouriteModel());
    DioHelper.getData(
      path: FAVOURITES,
      token: token,
    ).then((value) {
      favouriteModel = GetFavouriteModel.fromJson(value.data);
      emit(ShopSuccessGetFavouriteModel());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavouriteModel());
    });
  }

  ShopLoginModel? userProfile;

  void getProfile()
  {
    DioHelper.getData(
      path: PROFILE,
      token: token,
    ).then((value) {
      userProfile = ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessGetProfile());
    }).catchError((error){
      print('error is ${error.toString()}');
      emit(ShopErrorGetProfile());
    });
  }

  void updateProfile({
    required String name,
    required String phone,
    required String email,
  })
  {
    emit(ShopLoadingUpdateProfile());
    DioHelper.putData(
      path: UPDATE,
      token: token,
      data: {
        'name':name,
        'phone':phone,
        'email':email,
      },
    ).then((value) {
      userProfile = ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessUpdateProfile());
    }).catchError((error){
      print('error is ${error.toString()}');
      emit(ShopErrorUpdateProfile());
    });
  }


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
    emit(ChangePassLoginState());
  }

  void userLogin({
  required String email,
  required String password,
})
  {
    emit(LoadingLoginState());
    DioHelper.postData(
        path: LOGIN,
        data: {
          'email': email,
          'password': password,
        }).then((value) {
      userProfile = ShopLoginModel.fromJson(value.data);

          emit(SuccessLoginState(userProfile!));
    }).catchError((error){
      emit(ErrorLoginState(error.toString()));
      print('error is ${error.toString()}');
    });
  }

  GetDetailsProduct? getDetailsProduct;
  Details? details;

  void DetailsProduct(){
    emit(ShopLoadingGetProductDetails());
    DioHelper.getData(
        path: PRODUCT_DETAILS,
      token: token,
    ).then((value) {
      getDetailsProduct = GetDetailsProduct.fromJson(value.data);
      emit(ShopSuccessGetProductDetails());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetProductDetails());
    });
  }






  bool isDark = true;
    ChangeMode({bool? fromShared}) {
      if (fromShared != null) {
        isDark = fromShared;
        emit(ChangeModeState());
      }
      else {
        isDark = !isDark;
        CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
          emit(ChangeModeState());
        });
      }
    }
  }

