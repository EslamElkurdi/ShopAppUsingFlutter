
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loginscreen/layout/news_app/cubit/cubit.dart';
import 'package:loginscreen/layout/news_app/cubit/states.dart';
import 'package:loginscreen/layout/news_app/news_layout.dart';
import 'package:loginscreen/layout/shop_app/shop_layout.dart';
import 'package:loginscreen/layout/social_app/cubit/cubit.dart';
import 'package:loginscreen/layout/social_app/social_layout.dart';
import 'package:loginscreen/layout/todo_app/todo_layout.dart';
import 'package:loginscreen/modules/shop_app/login/shop_login_screen.dart';
import 'package:loginscreen/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:loginscreen/modules/social_app/social_app_login_screen/social_login_screen.dart';
import 'package:loginscreen/shared/bloc_observer.dart';
import 'package:loginscreen/shared/components/constants.dart';
import 'package:loginscreen/shared/network/remote/cach_helper.dart';
import 'package:loginscreen/shared/network/remote/dio_helper.dart';
import 'package:loginscreen/shared/styles/themes.dart';

import 'layout/shop_app/cubit/cubit.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');

  Widget widget;

  // bool onBoarding = CacheHelper.getData(key: 'onBoarding');
 // token = CacheHelper.getData(key: 'token');

  uId = CacheHelper.getData(key: 'uId');

  if(uId != null)
  {
    widget = SocialLayout();
  }else {
    widget = SocialLoginScreen();
  }

  // if(onBoarding != null) {
  //   if (token != null)
  //     widget = ShopLayout();
  //   else
  //     widget = ShopLoginScreen();
  // }else
  //   widget = OnBoardingScreen();
  //
  // print(onBoarding);

  runApp(MyApp(isDark, widget));
}

class MyApp extends StatelessWidget {

  final bool? isDark;

  final Widget? startWidget;

  MyApp(this.isDark, this.startWidget);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //var cubitTheme = AppNewsCubit.get(context).darkTheme;

    return MultiBlocProvider(
        providers: [
          BlocProvider(
        create: (BuildContext context) => AppNewsCubit()
      ..toggleMode(former: isDark)
      ..getBusiness(),
        ),
          BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()
              ..getUserData(),
          ),
          BlocProvider(
            create: (BuildContext context) => SocialAppCubit()..getUserData(),
          ),
        ],
        child: BlocConsumer<AppNewsCubit, NewsAppStates>(
          listener: (context, state){},
          builder:  (context, state){
            var themeCubit = AppNewsCubit.get(context).darkTheme;

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode:  ThemeMode.light ,
              // themeCubit ? ThemeMode.dark : ThemeMode.light
              home: startWidget,
            );
          },
        ),
    );
  }
}
