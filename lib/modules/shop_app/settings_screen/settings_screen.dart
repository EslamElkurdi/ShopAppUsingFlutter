import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/layout/shop_app/cubit/cubit.dart';
import 'package:loginscreen/layout/shop_app/cubit/states.dart';
import 'package:loginscreen/shared/components/components.dart';
import 'package:loginscreen/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        var shopModel = ShopCubit.get(context).userModel;

        nameController.text = shopModel?.data?.name??'';
        phoneController.text = shopModel?.data?.phone??'';
        emailController.text = shopModel?.data?.email??'';

        return ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            builder: (context)=>Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children:
                  [
                    if(state is ShopPutDataLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'name must not be empty';
                          }

                          return null;
                        },
                        label: 'name',
                        prefIcon: Icons.person
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'email must not be empty';
                          }

                          return null;
                        },
                        label: 'email',
                        prefIcon: Icons.email
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'phone must not be empty';
                          }

                          return null;
                        },
                        label: 'phone',
                        prefIcon: Icons.phone
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        function: ()
                        {
                          if(formKey.currentState!.validate())
                          {
                            ShopCubit.get(context).putUserData(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text
                            );
                          }

                        },
                        buttonName: 'update'
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        function: ()
                        {
                            signOut(context);
                        },
                        buttonName: 'Logout'
                    ),

                  ],
                ),
              ),
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator())
        );
      },
    );
  }
}