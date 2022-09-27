import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_app/cubit_shop.dart';
import 'package:shop/layout/shop_app/states_shop.dart';
import 'package:shop/models/shop_app/details_product.dart';
import 'package:shop/models/shop_app/details_product.dart';
import 'package:shop/models/shop_app/get_fav_model.dart';


class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitShop,ShopStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
       var cubit =  CubitShop.get(context);
        return Scaffold(
          appBar: AppBar(),
           body: SingleChildScrollView(
             physics: BouncingScrollPhysics(),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 CarouselSlider(
                   items: cubit.info!.images.map((e) =>
                       Center(
                     child: Image(image: NetworkImage(e),
                       height: 180,
                       width: 180,
                       //fit: BoxFit.cover
                     ),
                   ),).toList(),
                   options: CarouselOptions(
                     height: 200,
                     reverse: false,
                     initialPage: 0,
                     autoPlay: true,
                     viewportFraction: 1,
                     autoPlayInterval: Duration(seconds: 2),
                     autoPlayAnimationDuration: Duration(seconds: 1),
                     autoPlayCurve: Curves.easeInOutCubicEmphasized,
                     scrollDirection: Axis.horizontal,
                     // enableInfiniteScroll: true,
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Text('${cubit.info!.description}',
                       style: TextStyle(
                           fontSize: 16,
                           fontWeight: FontWeight.w500
                       )),
                 ),
               ],
             ),
           ),
        );
      },
    );
  }
   // Widget Details(Product model) => SingleChildScrollView(
   //   child: Padding(
   //     padding: const EdgeInsets.all(20.0),
   //     child: Text('${model.description}',
   //         style: TextStyle(
   //             fontSize: 16,
   //             fontWeight: FontWeight.w500
   //         )),
   //   ),
   // );
}
