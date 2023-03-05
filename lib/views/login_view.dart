import 'package:digitaldiary/API/api.dart';
import 'package:digitaldiary/database/database_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'signup_view.dart';
import 'tasks_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    MyDatabase().copyPasteAssetFileToRoot().then(
      (value) {
        if (kDebugMode) {
          print('DataBase Initialized Successfully');
        }
      },
    );
  }

  login() async {
    String uid = userEmailController.text;
    String passwd = passwordController.text;

    await MyDatabase().validatePassword(uid, passwd).then(
      (user) {
        if (passwd.compareTo(user.password!) == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Tasks(user.toMap());
              },
            ),
          );
        } else {
          if (kDebugMode) {
            print("false");
          }
        }
      },
    );
  }

  loginUsingApi() async {
    Map<dynamic, dynamic> data = await validateLogin(
        userEmailController.text.toString(),
        passwordController.text.toString());
    if (data['userEmail']
                .toString()
                .compareTo(userEmailController.text.toString()) ==
            0 &&
        data['userPassword']
                .toString()
                .compareTo(passwordController.text.toString()) ==
            0) {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Tasks();
            },
          ),
        );
      }
    } else {
      if (kDebugMode) {
        print("Login failed");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffac255e),
              Color(0xffca485c),
              Color(0xffe16b5c),
              Color(0xfff39060),
              Color(0xffffb56b),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 00, 10, 10),
            child: ListView(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(75),
                  child: Center(
                    child: Text(
                      "Digital Diary",
                      style: TextStyle(
                          fontSize: 44,
                          fontFamily: 'ShadowsIntoLight',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: userEmailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Email',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'User Name cannot be empty';
                      } else if (value.length < 3) {
                        return 'UserName is too short';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password cannot be empty';
                      } else if (value.length < 5) {
                        return 'Password is too short';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // below function is used for login using api
                        // loginUsingApi();

                        // below function is used for login using database
                        login();
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Does not have account?',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                      child: TextButton(
                        child: const Text(
                          'Sign up',
                          style:
                              TextStyle(fontSize: 20, color: Colors.tealAccent),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen()),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
