// ignore_for_file: prefer_const_literals_to_create_immutables, use_build_context_synchronously, must_be_immutable

import 'dart:io';

import 'package:e_commerce/provider/auth_provider.dart';
import 'package:e_commerce/resources/constant.dart';
import 'package:e_commerce/resources/custom_button.dart';
import 'package:e_commerce/views/home/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

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
  bool isProfileSaved = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> saveProfile() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      try {
        setState(() {
          isProfileSaved = true;
        });
        String token = AuthProvider.authId;
        String updatedName = nameController.text;
        String updatedPhone = phoneController.text;

        //creating headers
        Map<String, String> headers = {
          "Authorization": "Bearer $token",
        };

        //creating request
        var request =
            http.MultipartRequest("PUT", Uri.parse("$baseApi" "users/me"));

        //setting headers
        request.headers.addAll(headers);

        // adding text props to request
        request.fields.addAll({
          "phone": updatedPhone,
          "name": updatedName,
        });

        //adding files to the request
        request.files.add(await http.MultipartFile.fromPath(
          "image",
          profilePic!.path,
          contentType: MediaType.parse(
            lookupMimeType(profilePic!.path)!,
          ),
        ));

        var response = await request.send();
        var responseBody = await response.stream.bytesToString();
        if (response.statusCode != 201) {
          throw Exception("Failed to update profile: $responseBody");
        } else {
          await Provider.of<AuthProvider>(context, listen: false).checkToken();

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ProfilePage()));
        }
        // print(responseBody);
        // print(request);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.yellow.shade900,
            content: Text("Change something to be updated!")));
      } finally {
        setState(() {
          isProfileSaved = false;
        });
      }
    }
  }

  @override
  void initState() {
    nameController.text = widget.user["name"];
    emailController.text = widget.user["email"];
    phoneController.text = widget.user["phone"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<AuthProvider>(context, listen: false);
    var user = prov.userDetails;
    // print(user);

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
            Form(
              key: _formKey,
              child: Column(
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
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(user["imageURL"])),
                                  shape: BoxShape.circle,
                                  color:
                                      const Color.fromARGB(255, 206, 185, 243)),
                              child: user["imageURL"] == null
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    )
                                  : SizedBox(),
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
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value == "" || value!.length < 8) {
                        return "Username must be greater or equal to 8 characters!";
                      } else {
                        return null;
                      }
                    },
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
                  TextFormField(
                    controller: phoneController,
                    validator: (value) {
                      if (value == "") {
                        return 'Please enter your phone number';
                      }
                      // Regular expression for phone number validation
                      final phoneRegex = RegExp(r'^\d{10}$');
                      if (!phoneRegex.hasMatch(value!)) {
                        return 'Please enter a valid 10-digit phone number';
                      }
                      return null;
                    },
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
                child: InkWell(
                    onTap: () {
                      saveProfile();
                    },
                    child: isProfileSaved
                        ? CircularProgressIndicator()
                        : CustomButton(buttonName: "Save Profile")))
          ],
        ),
      ),
    );
  }
}
