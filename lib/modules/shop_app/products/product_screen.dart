import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_app/cubit_shop.dart';
import 'package:shop/layout/shop_app/states_shop.dart';
import 'package:shop/models/shop_app/categories_model.dart';
import 'package:shop/models/shop_app/home_model.dart';
import 'package:shop/modules/shop_app/details_product_screen/details_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/styles/colors.dart';

class ProductScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitShop,ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessFavouritesModel)
          {
            if(!state.model!.status!){
              showToast(text: state.model!.message!, state: ToastColor.ERROR);
            }
          }
      },
      builder: (context, state) {
        var cubit =CubitShop.get(context);
        return ConditionalBuilder(
            condition: CubitShop.get(context).homeModel != null && CubitShop.get(context).categoriesModel != null,
            builder: (context) => ProductBuilder(CubitShop.get(context).homeModel,CubitShop.get(context).categoriesModel,context),
            fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget ProductBuilder(HomeModel? model, CategoriesModel? categoriesModel,context) =>
 SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          CarouselSlider(
            items: model!.data.banners.map((e) => Image(
                image: NetworkImage('${e.image}'))).toList(),
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
          SizedBox(height: 15,),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categories',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20
                ),),
                SizedBox(height: 15,),
                Container(
                  height: 110,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => CategoriesGrid(categoriesModel!.data.datamodel[index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                      itemCount: categoriesModel!.data.datamodel.length,
                  ),
                ),
                SizedBox(height: 15,),
                Text('New Products',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20
                  ),),
                SizedBox(height: 15,),
              ],
            ),
          ),
          Container(
            // color: Colors.grey[300],
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
              childAspectRatio: 1/2 ,
              children: List.generate(
                model.data.products.length,
                    (index) => buildGridProducts(model.data.products[index],context),
              ),
            ),
          ),
    ],
  ),
        );

  Widget buildGridProducts(Products model, context) =>
      Container(
        color: Colors.grey[300],
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Card(
              elevation: 10,
              child: Container(
                height: 200,
                width: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  color: Colors.white
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image(
                    image: NetworkImage(model.image),
                  height: 180,
                  width: 100,
                ),
              ),
            ),
            if(model.discount != 0)
              Container(
              width: 60,
              color: Colors.red,
              child: Text('DISCOUNT'
                ,style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(model.name,
              overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text('\$${model.price.round()}',
                  overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.green
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if(model.discount != 0)
                  Text('\$${model.old_price.round()}',
                  overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: (){
                      CubitShop.get(context).postFavouriteModel(model.id);
                    },
                    icon: CircleAvatar(
                      backgroundColor: CubitShop.get(context).favourite![model.id]== true? defaultColor : Colors.grey ,
                      radius: 14,
                      child: Icon(
                          Icons.favorite_border,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(30)
                ),
                width: double.infinity,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: ElevatedButton.icon(
                    onPressed: (){
                      CubitShop.get(context).info = model;
                      navigateTo(context, DetailsScreen(
                      ));
                    },
                    icon: Icon(Icons.add),
                    label: Text('Show Product'),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );

  Widget CategoriesGrid(DataModel model) => Stack(
    alignment: AlignmentDirectional.bottomStart,
    children: [
      Image(
        image: NetworkImage(model.image),
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      Container(
        width: 110,
        color: Colors.black54,
        child: Text(model.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w600
          ),),
      ),
    ],
  );

}
