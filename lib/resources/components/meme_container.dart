// ignore_for_file: prefer_const_literals_to_create_immutables, must_be_immutable, prefer_is_empty
import 'package:e_commerce/provider/auth_provider.dart';
import 'package:e_commerce/provider/meme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MemeContainer extends StatelessWidget {
  String memeId;
  String name;
  String createdAt;
  String? caption;
  String filePath;
  List<dynamic>? likesIds;
  MemeContainer({
    super.key,
    required this.name,
    required this.memeId,
    required this.createdAt,
    this.caption = "",
    required this.filePath,
    required this.likesIds,
  });

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(createdAt);
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    createdAt = dateFormat.format(dateTime);
    var prov = Provider.of<AuthProvider>(context, listen: false);
    String userId = prov.userDetails["id"];
    // print(userId);
    return Container(
      height: MediaQuery.of(context).size.height * 0.60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: CircleAvatar(
              radius: 30,
              child: Icon(
                Icons.person,
                size: 30,
              ),
            ),
            title: Text(
              name,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(createdAt),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(caption!),
          SizedBox(
            height: 15,
          ),
          Container(
            height: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(filePath))),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Consumer<MemeProvider>(builder: (context, value, child) {
                    return IconButton(
                      onPressed: () {
                        value.toggleLike(memeId);
                      },
                      icon: Icon(
                          likesIds!.contains(userId)
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: likesIds!.contains(userId)
                              ? Colors.red
                              : Colors.black),
                    );
                  }),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    ((likesIds!.length) == 0 ? " " : "${likesIds!.length} ") +
                        ((likesIds!.length == 1) ? "like" : "likes"),
                  )
                ],
              ),
              Icon(
                Icons.bookmark_outline,
                size: 30,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            thickness: 2,
          )
        ],
      ),
    );
  }
}
