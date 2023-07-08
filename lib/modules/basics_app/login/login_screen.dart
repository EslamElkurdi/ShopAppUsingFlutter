import 'package:flutter/material.dart';
import 'package:loginscreen/shared/components/components.dart';

// reusable component

// 1. timing
// 2. refactor
// 3. quality

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var keyForm = GlobalKey<FormState>();

  bool visibleOrNot = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      label: "Email Address",
                      prefIcon: Icons.email,

                      ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      label: "Password",
                      prefIcon: Icons.lock,
                      sufx: Icons.remove_red_eye,
                      secureText: visibleOrNot,
                      onTapSuff: () {
                        setState(() {
                          visibleOrNot = !visibleOrNot;
                        });
                  }
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultButton(
                      function: () {
                        if (keyForm.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          print(emailController.text);
                          print(passwordController.text);
                        }
                      },
                      buttonName: "login",
                      isUpperCase: false,
                      radius: 10.0),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don\'t have account?"),
                      TextButton(onPressed: () {}, child: Text("Register Now"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
