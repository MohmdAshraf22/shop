import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_app/cubit_shop.dart';
import 'package:shop/layout/shop_app/states_shop.dart';
import 'package:shop/models/shop_app/categories_model.dart';
import 'package:shop/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitShop,ShopStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition:  CubitShop.get(context).categoriesModel != null,
          builder: (context) => buildCategory(CubitShop.get(context).categoriesModel),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );;
      },
    );
  }
  Widget buildCategory(CategoriesModel? model) => Padding(
    padding:  EdgeInsets.all(20.0),
    // child: Row(
    //   children: [
    //     Image(image: NetworkImage(model.image),
    //       height: 120,
    //       width: 120,),
    //     SizedBox(width: 15,),
    //     Text(model.name,
    //       overflow: TextOverflow.ellipsis,
    //       maxLines: 1,
    //       style: TextStyle(
    //         fontSize: 15,
    //         fontWeight: FontWeight.w500,
    //       ),),
    //     Spacer(),
    //     IconButton(
    //       onPressed: (){},
    //       icon: Icon(
    //           Icons.arrow_forward_ios_outlined
    //       ),
    //     ),
    //   ],
    // ),
    child:GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 1/1.2 ,
      children: List.generate(model!.data.datamodel.length,
              (index) =>buildCategories(model.data.datamodel[index])
      )
    ),
  );
  Widget buildCategories(DataModel model) => Column(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Card(
            elevation: 10,
            child: Image(
              image: NetworkImage(model.image),
              height: 145,
              width: 130,
            ),
          ),
          Container(
            width: 130,
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
      ),
    ],
  );
}
