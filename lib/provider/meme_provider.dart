import 'dart:convert';

import 'package:e_commerce/provider/auth_provider.dart';
import 'package:e_commerce/resources/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MemeProvider with ChangeNotifier {
  List<Map<String, dynamic>> memesList = [];
  bool isFetchingDone = false;
  MemeProvider() {
    fetchMemes();
  }

  Future<void> fetchMemes() async {
    String token = AuthProvider.authId;
    var response = await http.get(
      Uri.parse("$baseApi" "memes"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    var decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      memesList = (decodedResponse as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList();
      isFetchingDone = true;
      notifyListeners();
    } else {
      print(decodedResponse['message']);
      notifyListeners();
    }
  }
}
