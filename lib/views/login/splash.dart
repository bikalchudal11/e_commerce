// ignore_for_file: prefer_const_constructors

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_commerce/resources/constant.dart';
import 'package:e_commerce/views/login/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _next();
    super.initState();
  }

  _next() {
    Future.delayed(Duration(milliseconds: 2200), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LogInScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
            // image: DecorationImage(
            //   fit: BoxFit.cover,
            //   image: AssetImage('assets/images/splash_pic.jpg'),
            // ),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    "Meme",
                    textStyle: TextStyle(
                      fontFamily: 'SedgwickAve',
                      fontSize: 100,
                    ),
                    colors: [
                      primaryColor,
                      Colors.purple,
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            DefaultTextStyle(
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.0,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText('Start your day with joy'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}