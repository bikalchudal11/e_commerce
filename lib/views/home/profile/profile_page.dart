// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables

import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/provider/auth_provider.dart';
import 'package:e_commerce/resources/constant.dart';
import 'package:e_commerce/views/home/profile/edit_profile.dart';
import 'package:e_commerce/views/home/profile/view_page/liked_memes.dart';
import 'package:e_commerce/views/home/profile/view_page/posted_memes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  User user;
  ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isPostedSelected = true;

  showView() {
    if (isPostedSelected == true) {
      return PostedMemes(
        id: widget.user.id,
      );
    } else {
      return LikedMemes(
        id: widget.user.id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<AuthProvider>(context, listen: false);
    // print(widget.user.imageURL);
    // print(prov.userDetails!.imageURL);
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
          widget.user.id == prov.userDetails!.id
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfile(
                            name: widget.user.name,
                            phone: widget.user.phone,
                            imageUrl: widget.user.imageURL,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Edit",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                widget.user.imageURL != null
                    ? Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(widget.user.imageURL!)),
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
                          child: Icon(
                            Icons.person,
                            size: 50,
                          ),
                        )),
                SizedBox(
                  height: 30,
                ),
                UserInfoRow(
                  title: "Name",
                  value: widget.user.name,
                ),
                UserInfoRow(
                  title: "Email",
                  value: widget.user.email,
                ),
                UserInfoRow(
                  title: "Phone",
                  value: widget.user.phone,
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
                          if (!isPostedSelected) {
                            isPostedSelected = true;
                          }
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color:
                              isPostedSelected ? primaryColor : secondaryColor,
                          border: Border.all(
                            color: !isPostedSelected
                                ? primaryColor
                                : Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Posted",
                            style: TextStyle(
                              color: !isPostedSelected
                                  ? primaryColor
                                  : secondaryColor,
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
                          if (isPostedSelected) {
                            isPostedSelected = false;
                          }
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                            color: !isPostedSelected
                                ? primaryColor
                                : secondaryColor,
                            border: Border.all(
                              color: isPostedSelected
                                  ? primaryColor
                                  : Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(
                              10,
                            )),
                        child: Center(
                          child: Text(
                            "Liked",
                            style: TextStyle(
                              color: isPostedSelected
                                  ? primaryColor
                                  : secondaryColor,
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
    required this.title,
    required this.value,
  });

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
            value,
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
