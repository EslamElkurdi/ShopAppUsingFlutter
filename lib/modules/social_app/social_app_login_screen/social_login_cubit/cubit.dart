import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/models/shop_app/login_model.dart';
import 'package:loginscreen/modules/shop_app/login/login_cubit/states.dart';
import 'package:loginscreen/modules/social_app/social_app_login_screen/social_login_cubit/states.dart';
import 'package:loginscreen/shared/network/remote/dio_helper.dart';
import 'package:loginscreen/shared/network/remote/end_point.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

   //late ShopLoginModel loginModel;

  void userLogin({
    required String email,
    required String password
})
  {
    emit(SocialLoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password)
        .then((value){

          print(value.user?.uid);
          print(value.user?.email);
          emit(SocialLoginSuccessState(value.user!.uid));


    })
        .catchError((error){
          emit(SocialLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {

    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;

    emit(SocialChangePasswordVisibility());
  }
}