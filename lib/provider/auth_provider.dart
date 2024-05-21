// ignore_for_file: unnecessary_string_interpolations, avoid_print

import 'dart:convert';

import 'package:e_commerce/resources/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  static String authId = '';

  setAuthId(String id) {
    authId = id;
    notifyListeners();
  }

  Map<String, dynamic> userDetails = {};

  AuthProvider() {
    checkToken();
  }

  Future<void> checkToken() async {
    var prefs = await SharedPreferences.getInstance();

    String tokenId = prefs.getString("tokens")!;

    authId = tokenId;

    if (authId.isNotEmpty) {
      var response = await http.get(
        Uri.parse("$baseApi" + "users/me"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authId'
        },
      );
      var decodedResponse = jsonDecode(response.body);
      userDetails = decodedResponse;
      // print(authId);

      notifyListeners();
    } else {
      print("Auth id empty");
    }
    notifyListeners();
  }
}
