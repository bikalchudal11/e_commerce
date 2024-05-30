// ignore_for_file: unnecessary_string_interpolations, avoid_print

import 'dart:convert';

import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/resources/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  static String authId = '';

  setAuthId(String? id) {
    if (id == null) {
      id = "";
      authId = id;
    } else {
      authId = id;
    }
    notifyListeners();
  }

  User? userDetails;

  AuthProvider() {
    checkToken();
  }

  Future<void> checkToken() async {
    var prefs = await SharedPreferences.getInstance();

    String? tokenId = prefs.getString("tokens");

    if (tokenId == null) {
      authId = "";
    } else {
      authId = tokenId;
    }

    if (authId.isNotEmpty) {
      var response = await http.get(
        Uri.parse("$baseApi" "users/me"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authId'
        },
      );
      var decodedResponse = jsonDecode(response.body);
      userDetails = User.parseFromJson(decodedResponse);
      // print(authId);

      notifyListeners();
    } else {
      print("Auth id empty");
    }
    notifyListeners();
  }

  Future<void> updateProfile(
      String name, String phone, String imgPath, context) async {
    var response = await http.put(Uri.parse("$baseApi" "users/me"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authId'
        },
        body: jsonEncode({
          'name': name,
          'phone': phone,
        }));
    var decodedResponse = jsonDecode(response.body);
    userDetails = decodedResponse;
    print(decodedResponse);
  }
}
