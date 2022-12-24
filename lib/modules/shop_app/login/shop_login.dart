import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/layout/shop_app/cubit_shop.dart';
import 'package:shop/layout/shop_app/shop_layout.dart';
import 'package:shop/layout/shop_app/states_shop.dart';
import 'package:shop/modules/shop_app/login/cubit.dart';
import 'package:shop/modules/shop_app/login/states.dart';
import 'package:shop/modules/shop_app/regiser_screen/register_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/styles/colors.dart';


class ShopLogin extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var pass = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<CubitShop,ShopStates>(
      listener: (context, state) {
        if(state is SuccessLoginState)
          {
            if(state.loginModel.status)
              {
                CacheHelper.saveData(
                    key: 'token',
                    value: state.loginModel.data!.token
                ).then((value) {
                   token = state.loginModel.data!.token;

                   CubitShop.get(context).getProfile();

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
        var cubit = CubitShop.get(context);
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
                      Text('LOGIN'
                        , style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                        ),),
                      SizedBox(
                        height: 20 ,
                      ),
                      Text('Login now to browse our hot offers',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey
                        ),),
                      SizedBox(height: 30,),
                      TextFormField(
                        validator: (value){
                          if(value!.isEmpty)
                          {
                            return'email is empty';
                          }
                        } ,
                        controller: email ,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          labelText: 'Enter Your Email',
                          prefixIcon: Icon(
                              Icons.email
                          ),
                        ),
                      ),
                      SizedBox(height: 15 ,),
                      TextFormField(
                        onFieldSubmitted: (value){
                          cubit.userLogin(
                              email: email.text,
                              password: pass.text
                          );
                        },
                        validator: (value){
                          if(value!.isEmpty)
                          {
                            return'pass is empty';
                          }
                        } ,
                        controller: pass,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: cubit.ispass ,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular (30),
                          ),
                          labelText: 'Enter Your Password',
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
                      ),
                      SizedBox(height: 15 ,),
                      ConditionalBuilder(
                        condition: state is! LoadingLoginState ,
                        builder: (context) => Container(
                          height: 35,
                          width: double.infinity,
                          color: defaultColor,
                          child: MaterialButton(
                            onPressed: (){
                              if(formKey.currentState!.validate()){
                                cubit.userLogin(
                                    email: email.text,
                                    password: pass.text
                                );
                               }
                            },
                            child: Text('LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17
                              ),),
                          ),
                        ) ,
                        fallback:(context) => Center(child: CircularProgressIndicator()) ,
                      ),
                      SizedBox(height: 10 ,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t Have Account ?',
                            style: TextStyle(
                              fontSize: 17 ,
                              fontWeight: FontWeight.w600,
                            ),),
                          TextButton(
                              onPressed: (){
                                navigateTo(context, ShopRegister());
                              },
                              child: Text('Register Now',
                                style: TextStyle(
                                  color: defaultColor,
                                ),)),

                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
