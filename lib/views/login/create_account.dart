// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:e_commerce/views/login/login.dart';
import 'package:e_commerce/resources/constant.dart';
import 'package:e_commerce/resources/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  bool _obsecureText = true;
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isCreated = false;

  verify() {
    final isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      setState(() {
        isCreated = true;
      });
      Future.delayed(Duration(seconds: 2), () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => VerifyPhone(
        //               number: phoneController.text.trim(),
        //             )));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/bg.jpg'),
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.07),
                    BlendMode.dstATop,
                  ),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        Icons.arrow_back,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Create Account",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                  Text("Create a new account"),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                    ),
                    child: TextFormField(
                      cursorColor: primaryColor,
                      controller: userNameController,
                      validator: (value) {
                        if (value == "" || value!.length < 8) {
                          return "Username must be greater or equal to 8 characters!";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: primaryColor,
                        ),
                        labelText: "Username",
                        labelStyle: TextStyle(color: primaryColor),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor, // Border color when focused
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                    ),
                    child: TextFormField(
                      cursorColor: primaryColor,
                      controller: emailController,
                      validator: (value) {
                        if (value == "") {
                          return 'Please enter your email';
                        }
                        // Regular expression for email validation
                        final emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value!)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: primaryColor,
                        ),
                        labelText: "Email",
                        labelStyle: TextStyle(color: primaryColor),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                    ),
                    child: TextFormField(
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.number,
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
                        prefixIcon: Icon(
                          Icons.phone_android_rounded,
                          color: primaryColor,
                        ),
                        labelText: "Phone",
                        labelStyle: TextStyle(color: primaryColor),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor, // Border color when focused
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                    ),
                    child: TextFormField(
                      cursorColor: primaryColor,
                      controller: passwordController,
                      obscureText: _obsecureText,
                      validator: (value) {
                        if (value == "" || value!.length < 8) {
                          return "Password must be greater or equal to 8 characters!";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: primaryColor,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              _obsecureText = !_obsecureText;
                            });
                          },
                          child: Icon(
                            _obsecureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: primaryColor,
                          ),
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(color: primaryColor),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: primaryColor,
                        )),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor, // Border color when focused
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                    ),
                    child: TextFormField(
                      cursorColor: primaryColor,
                      controller: cPasswordController,
                      obscureText: _obsecureText,
                      validator: (value) {
                        if (value != passwordController.text) {
                          return "Password did not match";
                        }
                        if (value == "") {
                          return "Password must be greater or equal to 8 characters!";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: primaryColor,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              _obsecureText = !_obsecureText;
                            });
                          },
                          child: Icon(
                            _obsecureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: primaryColor,
                          ),
                        ),
                        labelText: "Confirm Password",
                        labelStyle: TextStyle(color: primaryColor),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: primaryColor,
                        )),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor, // Border color when focused
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => VerifyPhone(
                        //               number: phoneController.text.trim(),
                        //             )));
                        // // verify();
                      },
                      child: !isCreated
                          ? CustomButton(
                              buttonName: "CREATE ACCOUNT",
                            )
                          : CircularProgressIndicator(
                              color: primaryColor,
                            )),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have a account? "),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LogInScreen()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
