import 'package:e_commerce/provider/auth_provider.dart';
import 'package:e_commerce/provider/meme_provider.dart';
import 'package:e_commerce/views/home/home_page.dart';
import 'package:e_commerce/views/login/login.dart';
import 'package:e_commerce/views/login/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => MemeProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: "poppins"),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
