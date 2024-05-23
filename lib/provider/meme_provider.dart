import 'dart:convert';

import 'package:e_commerce/provider/auth_provider.dart';
import 'package:e_commerce/resources/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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
      // print(decodedResponse['message']);
      notifyListeners();
    }
  }

  Future<void> toggleLike(String memeId) async {
    // print(memeId);
    String token = AuthProvider.authId;
    var response = await http.post(
      Uri.parse("$baseApi" "memes/" "$memeId" "/toggle-like"),
      headers: {'Authorization': 'Bearer $token'},
    );
    // print("$baseApi" + "memes/" + "$memeId" + "/toggle-like");
    var decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // print(decodedResponse);
      for (int i = 0; i < memesList.length; i++) {
        if (memesList[i]["_id"] == memeId) {
          memesList[i]['likes'] = decodedResponse['likes'];
          // print(memesList[i]['likes']);
        }
      }
      decodedResponse["likes"];
      notifyListeners();
    } else {
      throw (decodedResponse['message']);
    }
    notifyListeners();
  }
}
