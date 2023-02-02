import 'package:flutter/material.dart';

import 'views/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Digital Diary';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text(_title)),
          backgroundColor: Colors.tealAccent,
          foregroundColor: Colors.black,
        ),
        body: const LoginScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}