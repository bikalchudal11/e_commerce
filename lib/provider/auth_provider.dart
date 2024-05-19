// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';

import 'package:e_commerce/resources/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  AuthProvider() {
    print("Auth provider created");
    // fetchData();
  }

  // Future<void> fetchData() async {
  //   var response = http.post(
  //     Uri.parse("$baseApi" + "login"),
  //   );
  //   print(response);
  //   // var decodedResponse = jsonDecode(response);
  // }
}
