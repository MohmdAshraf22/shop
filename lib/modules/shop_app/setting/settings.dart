import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_app/cubit_shop.dart';
import 'package:shop/layout/shop_app/states_shop.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  var nameCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var phoneCtrl = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitShop,ShopStates>(
      listener: (context, state) {
      },
      builder:(context, state) {
        var model = CubitShop.get(context).userProfile;
        nameCtrl.text = model!.data!.name;
        emailCtrl.text = model.data!.email;
        phoneCtrl.text = model.data!.phone;
        return ConditionalBuilder(
          condition: CubitShop.get(context).userProfile != null ,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if(state is ShopLoadingUpdateProfile)
                        LinearProgressIndicator(),
                      SizedBox(height: 20,),
                      defaultformfield(
                          controle: nameCtrl,
                          label: 'Name',
                          prefix: Icons.person,
                          validate: (value){
                            if (value == null)
                              {
                                return 'Name must not be emtpy';
                              }
                          }),
                      SizedBox(height: 20,),
                      defaultformfield(
                          controle: emailCtrl,
                          label: 'Email Address',
                          prefix: Icons.email,
                          validate: (value){
                            if(value == null)
                            {
                              return 'Email must not be emtpy';
                            }
                            return null;
                          }),
                      SizedBox(height: 20,),
                      defaultformfield(
                          controle: phoneCtrl,
                          label: 'Phone',
                          prefix: Icons.phone,
                          validate: (value){
                            if(value == null)
                            {
                              return 'Phone must not be emtpy';
                            }
                            return null;
                          }),
                      SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: (){
                            if(formKey.currentState!.validate())
                           {
                             CubitShop.get(context).updateProfile(
                               name : nameCtrl.text,
                               email : emailCtrl.text,
                               phone : phoneCtrl.text,
                             );
                           }
                            else
                              {
                                print(00000);
                              }
                          },
                          color: defaultColor,
                          child: Text('UPDATE',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17
                            ),),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: (){
                            signOut(context);
                          },
                          color: defaultColor,
                          child: Text('Logout',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17
                            ),),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
           fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
