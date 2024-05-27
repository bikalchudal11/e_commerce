// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables

import 'package:e_commerce/provider/auth_provider.dart';
import 'package:e_commerce/resources/constant.dart';
import 'package:e_commerce/views/home/profile/edit_profile.dart';
import 'package:e_commerce/views/home/profile/view_page/liked_memes.dart';
import 'package:e_commerce/views/home/profile/view_page/posted_memes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isPosted = true;

  bool isLiked = false;

  showView() {
    if (isPosted == true) {
      return PostedMemes();
    } else {
      return LikedMemes();
    }
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<AuthProvider>(context, listen: false);
    var user = prov.userDetails;
    // print(user);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: secondaryColor,
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(secondaryColor),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(user: user),
                  ),
                );
              },
              child: Text("Edit"),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                user["imageURL"] != null
                    ? Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(user["imageURL"])),
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 216, 204, 239)),
                      )
                    : Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(255, 206, 185, 243)),
                        // backgroundImage: FileImage(File(profilePic!.path)),
                        child: Center(
                          child: Icon(Icons.person),
                        )),
                SizedBox(
                  height: 30,
                ),
                UserInfoRow(
                  user: user,
                  title: "Name",
                  value: 'name',
                ),
                UserInfoRow(
                  user: user,
                  title: "Email",
                  value: 'email',
                ),
                UserInfoRow(
                  user: user,
                  title: "Phone",
                  value: 'phone',
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isLiked = false;
                          isPosted = true;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 170,
                        decoration: BoxDecoration(
                          color: isPosted ? primaryColor : secondaryColor,
                          border: Border.all(
                            color:
                                !isPosted ? primaryColor : Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Posted",
                            style: TextStyle(
                              color: !isPosted ? primaryColor : secondaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isLiked = true;
                          isPosted = false;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 170,
                        decoration: BoxDecoration(
                            color: isLiked ? primaryColor : secondaryColor,
                            border: Border.all(
                              color:
                                  !isLiked ? primaryColor : Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(
                              10,
                            )),
                        child: Center(
                          child: Text(
                            "Liked",
                            style: TextStyle(
                              color: !isLiked ? primaryColor : secondaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                showView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserInfoRow extends StatelessWidget {
  String title, value;
  UserInfoRow({
    super.key,
    required this.user,
    required this.title,
    required this.value,
  });

  final Map<String, dynamic> user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title :",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            user[value],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
