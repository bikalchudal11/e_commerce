import 'package:e_commerce/provider/auth_provider.dart';
import 'package:e_commerce/resources/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<AuthProvider>(context, listen: false);
    var user = prov.userDetails;
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                child: Icon(
                  Icons.person,
                  size: 50,
                ),
              ),
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
            ],
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
