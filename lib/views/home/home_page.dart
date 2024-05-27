// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:e_commerce/provider/auth_provider.dart';
import 'package:e_commerce/provider/meme_provider.dart';
import 'package:e_commerce/resources/components/meme_container.dart';
import 'package:e_commerce/resources/components/memes.dart';
import 'package:e_commerce/resources/constant.dart';
import 'package:e_commerce/views/home/add_meme.dart';
import 'package:e_commerce/views/home/drawer_content.dart';
import 'package:e_commerce/views/home/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? accessToken;
  @override
  void initState() {
    showUserDetails();
    super.initState();
  }

  Future<void> showUserDetails() async {
    Provider.of<AuthProvider>(context, listen: false);
    accessToken = AuthProvider.authId;
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MemeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: secondaryColor,
        title: Text(
          "Memes App",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              icon: Icon(
                Icons.person,
                size: 25,
              ),
            ),
          ),
        ],
      ),
      drawer: DrawerContent(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        foregroundColor: secondaryColor,
        tooltip: "Add new post",
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddMeme()));
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<MemeProvider>(
            builder: (context, value, child) {
              return value.isFetchingDone
                  ? MemeList(memes: value.memesList)
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ),
      ),
    );
  }
}
