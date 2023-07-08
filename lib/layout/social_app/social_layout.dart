import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/layout/social_app/cubit/cubit.dart';
import 'package:loginscreen/layout/social_app/cubit/states.dart';
import 'package:loginscreen/shared/components/components.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text('News Feed'),
            ),
            body: ConditionalBuilder(
                condition: SocialAppCubit.get(context).model != null,
                builder: (context) {
                  var model = SocialAppCubit.get(context).model;

                  return Column(
                    children: [
                      if (model?.isEmailVerified == false || true)
                        Container(
                          height: 50.0,
                          color: Colors.amber.withOpacity(0.5),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Text('Please verify your email'),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Spacer(),
                                defaultTextButton(
                                    function: () {
                                      FirebaseAuth.instance.currentUser
                                          ?.sendEmailVerification()
                                          .then((value) {
                                        showToast(
                                            text: 'check your mail',
                                            state: ToastStata.SUCCESS);
                                      }).catchError((error) {
                                        print("Error done");
                                      });
                                    },
                                    text: 'send')
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                },
                fallback: (context) =>
                    Center(child: CircularProgressIndicator())));
      },
    );
  }
}
