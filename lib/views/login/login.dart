// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:e_commerce/provider/auth_provider.dart';
import 'package:e_commerce/resources/constant.dart';
import 'package:e_commerce/resources/custom_button.dart';
import 'package:e_commerce/views/home/home_page.dart';
import 'package:e_commerce/views/login/create_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool _obsecureText = true;
  bool isRemember = true;
  final _formKey = GlobalKey<FormState>();
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> login() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      var response = await http.post(Uri.parse("$baseApi" + "auth/login"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': emailController.text,
            'password': passController.text,
          }));

      var decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          isLogin = true;
        });
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        });
        var prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            "tokens", decodedResponse['tokens']['access']['token']);
        // print(prefs.getString("tokens"));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(decodedResponse['message'])));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
                    Colors.white.withOpacity(0.05),
                    BlendMode.dstATop,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 40,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Sign to continue",
                      style: TextStyle(color: primaryColor, fontSize: 15),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    TextFormField(
                      controller: emailController,
                      cursorColor: primaryColor,
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
                            color: primaryColor, // Border color when focused
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: passController,
                      cursorColor: primaryColor,
                      obscureText: _obsecureText,
                      validator: (value) {
                        if (value == "") {
                          return "Please enter your password!";
                        } else if (value!.length < 8) {
                          return "Please enter valid password!";
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
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Remember me",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isRemember = !isRemember;
                                });
                              },
                              child: Icon(
                                !isRemember
                                    ? Icons.check_box_outline_blank
                                    : Icons.check_box,
                                color: primaryColor,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                        onTap: () {
                          login();
                        },
                        child: !isLogin
                            ? CustomButton(
                                buttonName: "Login",
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
                        Text("Don't have an account? "),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateAccountPage()));
                          },
                          child: Text(
                            "create a new account",
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600),
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
      ),
    );
  }
}
