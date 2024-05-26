// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:e_commerce/provider/auth_provider.dart';
import 'package:e_commerce/resources/constant.dart';
import 'package:e_commerce/resources/custom_button.dart';
import 'package:e_commerce/views/home/profile/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  Map<String, dynamic> user;
  EditProfile({super.key, required this.user});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  XFile? profilePic;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    nameController.text = widget.user["name"];
    emailController.text = widget.user["email"];
    phoneController.text = widget.user["phone"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.user);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: secondaryColor,
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () async {
                      profilePic =
                          await picker.pickImage(source: ImageSource.gallery);
                      setState(() {});
                    },
                    child: profilePic != null
                        ? Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(File(profilePic!.path))),
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 216, 204, 239)),
                          )
                        : Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    const Color.fromARGB(255, 206, 185, 243)),
                            // backgroundImage: FileImage(File(profilePic!.path)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 55,
                                ),
                                Icon(
                                  Icons.add,
                                  size: 25,
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Center(
                  child: Text(
                    "Click above to upload or change profile!",
                    style: TextStyle(
                      fontSize: 13,
                      color: primaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Name:"),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    fillColor: textFieldBgColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Phone:"),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    fillColor: textFieldBgColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
                onTap: () {
                  var prov = Provider.of<AuthProvider>(context, listen: false);

                  prov.userDetails['name'] = nameController.text;
                  prov.userDetails['phone'] = phoneController.text;

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Profile Updated!")));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                },
                child: CustomButton(buttonName: "Save Profile"))
          ],
        ),
      ),
    );
  }
}
