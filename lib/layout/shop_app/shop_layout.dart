import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_app/cubit_shop.dart';
import 'package:shop/layout/shop_app/states_shop.dart';
import 'package:shop/modules/shop_app/login/shop_login.dart';
import 'package:shop/modules/shop_app/search/search_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/styles/colors.dart';

class ShopLayout extends StatelessWidget {

   @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitShop,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CubitShop.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Conan'),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, ShopSearchScreen());
                  },
                  icon: Icon(
                      Icons.search
                  ),
              ),
            ],
          ),
          body: cubit.BottomScreens[cubit.current],
          bottomNavigationBar : ConvexAppBar(
            onTap: (value){
              cubit.ChangeCurrent(value);
            },
              backgroundColor: defaultColor,
              items: [
                TabItem(icon: Icons.home, title: 'Home'),
                TabItem(icon: Icons.apps, title: 'Categories'),
                TabItem(icon: Icons.favorite, title: 'Favorite'),
                TabItem(icon: Icons.settings, title: 'Settings'),
              ]),
        );
      },
    );
  }
}
