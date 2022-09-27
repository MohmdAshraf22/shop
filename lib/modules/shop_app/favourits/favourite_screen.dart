import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_app/cubit_shop.dart';
import 'package:shop/layout/shop_app/states_shop.dart';
import 'package:shop/models/shop_app/get_fav_model.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/styles/colors.dart';

class FavouriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitShop,ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavouriteModel,
          builder: (context) =>  ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildListProduct(CubitShop.get(context).favouriteModel!.data!.data![index].product,context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: CubitShop.get(context).favouriteModel!.data!.data!.length
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

}