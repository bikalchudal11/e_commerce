// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:e_commerce/provider/auth_provider.dart';
import 'package:e_commerce/resources/components/meme_container.dart';
import 'package:e_commerce/resources/constant.dart';
import 'package:e_commerce/views/home/add_meme.dart';
import 'package:e_commerce/views/home/drawer_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    showUserDetails();
    super.initState();
  }

  Future<void> showUserDetails() async {
    var prov = Provider.of<AuthProvider>(context, listen: false);
    // print(prov.authId);
  }

  @override
  Widget build(BuildContext context) {
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
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.person,
              size: 25,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.keyboard_arrow_down,
              size: 25,
            ),
          )
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
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return MemeContainer();
            }),
      ),
    );
  }
}
