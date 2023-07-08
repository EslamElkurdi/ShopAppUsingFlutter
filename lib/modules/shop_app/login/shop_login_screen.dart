import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginscreen/layout/shop_app/shop_layout.dart';
import 'package:loginscreen/modules/shop_app/login/login_cubit/cubit.dart';
import 'package:loginscreen/modules/shop_app/login/login_cubit/states.dart';
import 'package:loginscreen/modules/shop_app/register/shop_register_screen.dart';
import 'package:loginscreen/modules/social_app/social_app_register_screen/social_register_screen.dart';
import 'package:loginscreen/shared/components/components.dart';
import 'package:loginscreen/shared/components/constants.dart';
import 'package:loginscreen/shared/network/remote/cach_helper.dart';

class ShopLoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state)
        {
          if(state is ShopLoginSuccessState)
          {
            if(state.model.status)
            {
              print(state.model.message);
             // showToastMessage(state.model.message);
             //print(state.model.data!.token);

              Fluttertoast.showToast(
                  msg: state.model.message,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              CacheHelper.saveData(
                  key: 'token',
                  value: state.model.data!.token
              ).then((value){

                token = state.model.data!.token;

                navigateAndFinish(context, ShopLayout());
              });

            } else
              {
              print(state.model.message);
              print("Second");
              showToastMessage(state.model.message);

              showToast(
                  text: state.model.message,
                  state: ToastStata.ERROR
              );
            }
          }
        },
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                            "login now to browse our hot offers",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.grey
                            )
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'must not be empty';
                              }
                              return null;
                            },
                            label: 'Email Address',
                            prefIcon: Icons.email_outlined
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          secureText: ShopLoginCubit.get(context).isPassword,
                          onSubmit: (value)
                          {
                            if(formKey.currentState!.validate())
                            {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }
                          },

                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'password is too short';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefIcon: Icons.lock_outlined,
                          sufx: ShopLoginCubit.get(context).suffix,
                          onTapSuff: ()
                          {
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                              function: (){
                                if(formKey.currentState!.validate())
                                {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }
                              },
                              buttonName: 'Login',
                              isUpperCase: true
                          ),
                          fallback: (context)=> Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'Don`t have an account?'
                            ),
                            defaultTextButton(
                                function: ()
                                {
                                  navigateTo(
                                    context,
                                    ShopRegisterScreen(),
                                  );
                                },
                                text: 'register'
                            )
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

      ),
    );
  }


  //create this function, so that, you needn't to configure toast every time


}

