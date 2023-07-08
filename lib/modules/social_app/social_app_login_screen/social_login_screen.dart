import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/layout/social_app/social_layout.dart';

import 'package:loginscreen/modules/social_app/social_app_login_screen/social_login_cubit/cubit.dart';
import 'package:loginscreen/modules/social_app/social_app_login_screen/social_login_cubit/states.dart';
import 'package:loginscreen/modules/social_app/social_app_register_screen/social_register_screen.dart';
import 'package:loginscreen/shared/components/components.dart';

import '../../../shared/network/remote/cach_helper.dart';

class SocialLoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state)
        {
          if(state is SocialLoginErrorState){
            showToast(
                text: state.error,
                state: ToastStata.ERROR
            );
          }

          if(state is SocialLoginSuccessState)
          {
            CacheHelper.saveData(
                key: 'uId',
                value: state.uId
            ).then((value){
              navigateAndFinish(
                  context,
                  SocialLayout()
              );
            });

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
                            "login now to communicate with friends",
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
                          secureText: SocialLoginCubit.get(context).isPassword,
                          onSubmit: (value)
                          {
                            if(formKey.currentState!.validate())
                            {
                              // SocialLoginCubit.get(context).userLogin(
                              //     email: emailController.text,
                              //     password: passwordController.text
                              // );
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
                          sufx: SocialLoginCubit.get(context).suffix,
                          onTapSuff: ()
                          {
                            SocialLoginCubit.get(context).changePasswordVisibility();
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => defaultButton(
                              function: (){
                                if(formKey.currentState!.validate())
                                {
                                  SocialLoginCubit.get(context).userLogin(
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
                                    SocialRegisterScreen(),
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
}
