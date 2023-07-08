import 'package:loginscreen/models/shop_app/login_model.dart';

abstract class SocialRegisterStates{}

class SocialRegisterInitialState extends SocialRegisterStates{}

class SocialRegisterLoadingState extends SocialRegisterStates{}

class SocialRegisterSuccessState extends SocialRegisterStates
{
  //final SocialLoginModel model;

 // SocialRegisterSuccessState(this.model);
}

class SocialRegisterErrorState extends SocialRegisterStates
{
  final String error;

  SocialRegisterErrorState(this.error);
}

class SocialRegisterChangePasswordVisibility extends SocialRegisterStates {}

class SocialCreateSuccessState extends SocialRegisterStates
{
  //final SocialLoginModel model;
  // SocialRegisterSuccessState(this.model);
}

class SocialCreateErrorState extends SocialRegisterStates
{
  final String error;

  SocialCreateErrorState(this.error);
}