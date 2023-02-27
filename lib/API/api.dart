import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';


Future<Map<dynamic,dynamic>> validateLogin(String useremail, String password) async {
  final http.Response response = await http.get(
      Uri.parse(
          'https://63f2fce7fe3b595e2ed824bf.mockapi.io/api_implementation?userEmail=$useremail'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      });
  Map<dynamic,dynamic> responseData = jsonDecode(response.body)[0];
  if (kDebugMode) {
    print(response.statusCode);
    print(useremail);
    print(password);
    print(json.decode(response.body));
  }

  if (response.statusCode == 200) {
    return responseData;
  } else {
    throw Exception("Login Failed");
  }
}
