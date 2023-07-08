import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginscreen/layout/shop_app/shop_layout.dart';
import 'package:loginscreen/layout/social_app/social_layout.dart';
//import 'package:loginscreen/modules/shop_app/login/login_cubit/cubit.dart';
// import 'package:loginscreen/modules/shop_app/register/register_cubit/cubit.dart';
// import 'package:loginscreen/modules/shop_app/register/register_cubit/states.dart';
import 'package:loginscreen/modules/social_app/social_app_register_screen/social_register_cubit/cubit.dart';
import 'package:loginscreen/modules/social_app/social_app_register_screen/social_register_cubit/states.dart';
import 'package:loginscreen/shared/components/components.dart';
import 'package:loginscreen/shared/components/constants.dart';
import 'package:loginscreen/shared/network/remote/cach_helper.dart';

class SocialRegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  // controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state)
        {
          if(state is SocialCreateSuccessState)
          {
            navigateAndFinish(
                context,
                SocialLayout()
            );
          }

          // if(state is SocialRegisterSuccessState)
          // {
          //   if(state.model.status)
          //   {
          //     print(state.model.message);
          //     // showToastMessage(state.model.message);
          //     //print(state.model.data!.token);
          //
          //     Fluttertoast.showToast(
          //         msg: state.model.message,
          //         toastLength: Toast.LENGTH_SHORT,
          //         gravity: ToastGravity.BOTTOM,
          //         timeInSecForIosWeb: 5,
          //         backgroundColor: Colors.green,
          //         textColor: Colors.white,
          //         fontSize: 16.0
          //     );
          //     CacheHelper.saveData(
          //         key: 'token',
          //         value: state.model.data!.token
          //     ).then((value){
          //
          //       token = state.model.data!.token;
          //
          //       navigateAndFinish(
          //           context,
          //           ShopLayout());
          //     });
          //
          //   } else
          //   {
          //     print(state.model.message);
          //     print("Second");
          //     showToastMessage(state.model.message);
          //
          //     showToast(
          //         text: state.model.message,
          //         state: ToastStata.ERROR
          //     );
          //   }
          // }
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
                          "REGISTER",
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                            "register now to browse our hot offers",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.grey
                            )
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.text,
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            label: 'User Name',
                            prefIcon: Icons.person
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          secureText: SocialRegisterCubit.get(context).isPassword,
                          onSubmit: (value)
                          {
                            // if(formKey.currentState!.validate())
                            // {
                            //   ShopLoginCubit.get(context).userLogin(
                            //       email: emailController.text,
                            //       password: passwordController.text
                            //   );
                            // }
                          },

                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'please enter your password';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefIcon: Icons.lock_outlined,
                          sufx: SocialRegisterCubit.get(context).suffix,
                          onTapSuff: ()
                          {
                            SocialRegisterCubit.get(context).changePasswordVisibility();
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'please enter your email';
                              }
                              return null;
                            },
                            label: 'Email Address',
                            prefIcon: Icons.email
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Please enter your phone';
                              }
                              return null;
                            },
                            label: 'Phone',
                            prefIcon: Icons.phone
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) => defaultButton(
                              function: (){
                                if(formKey.currentState!.validate())
                                {
                                  SocialRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text
                                  );
                                }
                              },
                              buttonName: 'Register',
                              isUpperCase: true
                          ),
                          fallback: (context)=> Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
