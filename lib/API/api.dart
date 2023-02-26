import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';


Future<Map<dynamic,dynamic>> createLoginState(String useremail, String password) async {
  final http.Response response = await http.get(
      Uri.parse(
          'https://63f2fce7fe3b595e2ed824bf.mockapi.io/api_implementation?userEmail=$useremail'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      });
  var data = jsonDecode(response.body);
  Map<dynamic,dynamic> responseData = data[0];
  if (kDebugMode) {
    print(response.statusCode);
    print(useremail);
    print(password);
    print(json.decode(response.body));
  }

  if (response.statusCode == 200) {
    return responseData;

  } else {
    if (kDebugMode) {
      print('Login Failed.');
    }
    throw Exception("Login Failed");
  }
}
