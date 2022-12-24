import 'package:flutter/material.dart';
import 'package:shop/modules/shop_app/search/cubit_search.dart';
import 'package:shop/modules/shop_app/search/state_search.dart';
import 'package:shop/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopSearchScreen extends StatelessWidget {
  const ShopSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultformfield(
                     onChange: (text){
                        SearchCubit.get(context).search(text);
                      } ,
                        controle: searchController,
                        label: 'Search',
                        prefix: Icons.search,
                      validate: (value){
                          if(value == null)
                            {
                              return 'search is emtpy';
                            }
                          return null;
                      }
                    ),
                    SizedBox(height: 20,),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(height: 20,),
                    if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context,index)=>
                              buildListProduct(SearchCubit.get(context).model!.data!.data![index],context,isOldPrice: false),
                          separatorBuilder: (context,index)=>
                              myDivider(),
                          itemCount: SearchCubit.get(context).model!.data!.data!.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}