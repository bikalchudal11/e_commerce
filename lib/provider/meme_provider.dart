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
      throw (decodedResponse['message']);
    }
    notifyListeners();
  }

  Future<void> toggleLike(String memeId) async {
    String token = AuthProvider.authId;
    var response = await http.post(
      Uri.parse("$baseApi" "memes/" "$memeId" "/toggle-like"),
      headers: {'Authorization': 'Bearer $token'},
    );
    var decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (int i = 0; i < memesList.length; i++) {
        if (memesList[i]["_id"] == memeId) {
          memesList[i]['likes'] = decodedResponse['likes'];
        }
      }
      notifyListeners();
    } else {
      throw (decodedResponse['message']);
    }
    notifyListeners();
  }

  Future<void> editCaption(String memeId, String newCaption, context) async {
    // print(newCaption);
    String token = AuthProvider.authId;
    var response = await http.patch(Uri.parse("$baseApi" "memes/" "$memeId"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({"caption": newCaption}));
    var decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (int i = 0; i < memesList.length; i++) {
        if (memesList[i]["_id"] == memeId) {
          memesList[i] = decodedResponse["meme"];
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text("Caption updated!")));
          notifyListeners();
        }
      }
    } else {
      throw (decodedResponse['message']);
    }
    notifyListeners();
  }

  Future<void> deleteMeme(String memeId, context) async {
    String token = AuthProvider.authId;

    var response = await http.delete(
      Uri.parse("$baseApi" "memes" "/$memeId"),
      headers: {'Authorization': 'Bearer $token'},
    );
    var decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (int i = 0; i < memesList.length; i++) {
        if (memesList[i]["_id"] == memeId) {
          memesList.removeAt(i);
          notifyListeners();
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(decodedResponse['message'])));
    }
    notifyListeners();
  }
}
