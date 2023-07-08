
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/layout/shop_app/cubit/states.dart';
import 'package:loginscreen/layout/social_app/cubit/states.dart';
import 'package:loginscreen/models/social_app/create_user_model.dart';
import 'package:loginscreen/modules/social_app/social_app_login_screen/social_login_cubit/states.dart';
import 'package:loginscreen/shared/components/constants.dart';

class SocialAppCubit extends Cubit<SocialAppStates>{
  SocialAppCubit() : super(InitialAppState());

  static SocialAppCubit get(context) => BlocProvider.of(context);

  CreateUserModel? model;

  void getUserData()

  {
    emit(SocialGetUserLoadingState());
    print('UID : $uId');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value){

          print(value.data());
          model = CreateUserModel.fromJson(value.data() as Map<String, dynamic>) ;
          emit(SocialGetUserSuccessState());
    }).catchError((error)
    {
      print("Error BIG: ${error.toString()}");
      emit(SocialGetUserErrorState(error.toString()));
    });



  }



}