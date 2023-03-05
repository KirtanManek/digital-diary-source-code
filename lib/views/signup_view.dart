import 'package:digitaldiary/database/database_helper.dart';
import 'package:digitaldiary/views/models/user.dart';
import 'package:digitaldiary/views/tasks_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'login_view.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreen();
}

class _SignupScreen extends State<SignupScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  bool validatePassword(String pass) {
    String password = pass.trim();
    if (passValid.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  RegExp emailValid = RegExp(r"\S+@\S+\.\S+");
  bool validateEmail(String mail) {
    String email = mail.trim();
    if (emailValid.hasMatch(email)) {
      return true;
    } else {
      return false;
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
                  padding: EdgeInsets.all(60),
                  child: Center(
                    child: Text(
                      "Digital Diary",
                      style: TextStyle(
                          fontSize: 45,
                          fontFamily: 'ShadowsIntoLight',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: userNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                        labelStyle: TextStyle(color: Colors.black)),
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
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: userEmailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black)),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email cannot be empty';
                      } else if (value.length < 3) {
                        return 'UserName is too short';
                      } else {
                        bool result = validateEmail(value);
                        if (result) {
                          return null;
                        } else {
                          return "Please enter correct form of email";
                        }
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
                        bool result = validatePassword(value);
                        if (result) {
                          return null;
                        } else {
                          return "Password should contain at least \none Capital, \none small letter, \none Number & \none Special Character";
                        }
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
                      "Create Account",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Below if statement is used for debugging
                        if (kDebugMode) {
                          print(userNameController.text);
                          print(userEmailController.text);
                          print(passwordController.text);
                        }

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Please Confirm"),
                              content: const Text(
                                  "Are you sure you want to continue?"),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    // Remove the box
                                    var data = <String, dynamic>{};
                                    data["UserName"] = userNameController.text;
                                    data["UserEmail"] =
                                        userEmailController.text;
                                    data["UserPassword"] =
                                        passwordController.text;
                                    int? id = await MyDatabase()
                                        .insertDataIntoDatabase(data);

                                    // Close the dialog
                                    if (context.mounted) {
                                      if (id!.isFinite) {
                                        Navigator.of(context).pop();
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return Tasks(
                                                User(
                                                        id,
                                                        userNameController.text,
                                                        userEmailController.text,
                                                        passwordController.text)
                                                    .toMap(),
                                              );
                                            },
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  child: const Text('Yes'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Close the dialog
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('No'),
                                )
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Already have an account?',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                      child: TextButton(
                        child: const Text(
                          'Sign in',
                          style:
                              TextStyle(fontSize: 20, color: Colors.tealAccent),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
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
