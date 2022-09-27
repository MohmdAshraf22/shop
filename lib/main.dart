import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_app/cubit_shop.dart';
import 'package:shop/layout/shop_app/shop_layout.dart';
import 'package:shop/layout/shop_app/states_shop.dart';
import 'package:shop/modules/shop_app/login/shop_login.dart';
import 'package:shop/modules/shop_app/on_boarding/on_boardin_screen.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/styles/themes.dart';
import 'shared/bloc_observer.dart';
import 'shared/components/constants.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();

  Widget? widget;

  token = CacheHelper.getData(key: 'token');
 bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
 if(onBoarding == true)
 {
  if(token != null ) widget = ShopLayout();
  else widget = ShopLogin();
 }
 else widget = onBoardingScreen();

  BlocOverrides.runZoned(
        () {
      runApp(MyApp(
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}
class MyApp extends StatelessWidget
{
//// c r u d
  final bool? isDark;
  final Widget? startWidget ;
  MyApp({
    this.isDark,
    this.startWidget
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CubitShop()
        ),
      ],
      child: BlocConsumer<CubitShop,ShopStates>(
          listener: (context, state) {
          },
          builder:(context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: CubitShop.get(context).isDark ? ThemeMode.light : ThemeMode.dark ,
              home: startWidget,
            );
          }
      ),
    );
  }
}

