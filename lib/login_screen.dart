import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff1f005c),
            Color(0xff5b0060),
            Color(0xff870160),
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
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
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
                    counterStyle: TextStyle(backgroundColor: Colors.teal),
                    labelText: 'Password',
                  ),
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
                      "Login",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        print(userNameController.text);
                        print(passwordController.text);
                      }
                    },
                  )),
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
                        //signup screen
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  // String? _validateUserName(String? value){
  //
  // }
}
// import 'package:flutter/material.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xff7f7fd5),
//               Color(0xff86a8e7),
//               Color(0xff91eae4),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               "Login",
//               style: TextStyle(
//                 fontSize: 40.0,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 50.0),
//             SizedBox(
//               width: 300.0,
//               child: TextField(
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   hintText: "Username",
//                   hintStyle: TextStyle(color: Colors.grey[800]),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                     borderSide: BorderSide.none,
//                   ),
//                   prefixIcon: Icon(
//                     Icons.person,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20.0),
//             SizedBox(
//               width: 300.0,
//               child: TextField(
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   hintText: "Password",
//                   hintStyle: TextStyle(color: Colors.grey[800]),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                     borderSide: BorderSide.none,
//                   ),
//                   prefixIcon: Icon(
//                     Icons.lock,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//                 obscureText: true,
//               ),
//             ),
//             const SizedBox(height: 20.0),
//             SizedBox(
//               width: 300.0,
//               height: 50.0,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 // color: Colors.blue[800],
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.blue[800],
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//
//                 child: const Text(
//                   "Login",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18.0,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
