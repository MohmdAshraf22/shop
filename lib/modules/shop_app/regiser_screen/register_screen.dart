import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/layout/shop_app/shop_layout.dart';
import 'package:shop/modules/shop_app/login/cubit.dart';
import 'package:shop/modules/shop_app/login/states.dart';
import 'package:shop/modules/shop_app/regiser_screen/cubit.dart';
import 'package:shop/modules/shop_app/regiser_screen/states.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/styles/colors.dart';


class ShopRegister extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailctrl = TextEditingController();
  var passctrl= TextEditingController();
  var namectrl= TextEditingController();
  var phonectrl= TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => ShopCubitRegister(),
      child: BlocConsumer<ShopCubitRegister,RegisterStates>(
        listener: (context, state) {
          if(state is SuccessRegisterState)
          {
            if(state.loginModel.status)
            {

              CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data!.token
              ).then((value) {
                token = state.loginModel.data!.token;
                showToast(
                  state: ToastColor.SUCCESS,
                  text: state.loginModel.message.toString(),
                );
                navigateAndFinish(context, ShopLayout());
              });
            }
            else
            {
              showToast(
                state: ToastColor.ERROR,
                text: state.loginModel.message.toString(),
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopCubitRegister.get(context);
          return Scaffold(
            appBar: AppBar(),
            body : Padding(
              padding: const EdgeInsets.all(20.6),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('REGISTER'
                          , style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                          ),),
                        SizedBox(
                          height: 20 ,
                        ),
                        Text('Register now to browse our hot offers',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey
                          ),),
                        SizedBox(height: 30,),
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty)
                            {
                              return'Name is empty';
                            }
                          } ,
                          controller: namectrl ,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            labelText: 'User Name',
                            prefixIcon: Icon(
                                Icons.person
                            ),
                          ),
                        ),//// name
                        SizedBox(height: 15 ,),
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty)
                            {
                              return'Email is empty';
                            }
                          } ,
                          controller: emailctrl,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular (30),
                            ),
                            labelText: 'Your Email Address',
                            prefixIcon: Icon(
                                Icons.email
                            ),
                          ),
                        ),//// email
                        SizedBox(height: 15 ,),
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty)
                            {
                              return'Phone is empty';
                            }
                          } ,
                          controller: phonectrl,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular (30),
                            ),
                            labelText: 'Your Phone',
                            prefixIcon: Icon(
                                Icons.phone
                            ),
                          ),
                        ),//// phone
                        SizedBox(height: 15 ,),
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty)
                            {
                              return'Pass is empty';
                            }
                          } ,
                          controller: passctrl,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: cubit.ispass ,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular (30),
                            ),
                            labelText: 'Your Password Now',
                            prefixIcon: Icon(
                                Icons.lock
                            ),
                            suffixIcon:IconButton(
                              icon : Icon(
                                cubit.icon,
                              ),
                              onPressed: (){
                                cubit.changePass();
                              },
                            ),
                          ),
                        ),//// pass
                        SizedBox(height: 15 ,),
                        ConditionalBuilder(
                          condition: state is! LoadingRegisterState,
                          builder: (context) => Container(
                            height: 35,
                            width: double.infinity,
                            color: defaultColor,
                            child: MaterialButton(
                              onPressed: (){
                                if(formKey.currentState!.validate()){
                                  cubit.userRegister(
                                      email: emailctrl.text,
                                      password: passctrl.text,
                                      name: namectrl.text,
                                      phone: phonectrl.text,
                                  );
                                }
                              },
                              child: Text('REGISTER',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17
                                ),),
                            ),
                          ) ,
                          fallback:(context) => Center(child: CircularProgressIndicator()) ,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
