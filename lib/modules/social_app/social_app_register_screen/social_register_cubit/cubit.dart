import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/models/shop_app/login_model.dart';
import 'package:loginscreen/models/social_app/create_user_model.dart';

import 'package:loginscreen/modules/shop_app/register/register_cubit/states.dart';
import 'package:loginscreen/modules/social_app/social_app_register_screen/social_register_cubit/states.dart';
import 'package:loginscreen/shared/network/remote/dio_helper.dart';
import 'package:loginscreen/shared/network/remote/end_point.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

   //late SocialLoginModel loginModel;

  void createUser({
    required String email,
    required String name,
    required String phone,
    required String? uId,
}){
    CreateUserModel model = CreateUserModel(
      phone: phone,
      email: email,
      name: name,
      uId: uId,
      isEmailVerified: false
    );


      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .set(model.toMap())
          .then((value){

            emit(SocialCreateSuccessState());
      })
          .catchError((error){
        emit(SocialCreateErrorState(error.toString()));
      });
  }

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
})
  {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){

      print('i am here');
      print(value.user?.email);
      print(value.user?.uid);

      createUser(
          email: email,
          name: name,
          phone: phone,
          uId: value.user?.uid,

      );
      //emit(SocialRegisterSuccessState());
    }).catchError((error){

      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {

    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;

    emit(SocialRegisterChangePasswordVisibility());
  }
}