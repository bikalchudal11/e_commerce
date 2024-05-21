// ignore_for_file: prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MemeContainer extends StatelessWidget {
  String name;
  String createdAt;
  String? caption;
  String filePath;
  MemeContainer(
      {super.key,
      required this.name,
      required this.createdAt,
      this.caption = "",
      required this.filePath});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(createdAt);
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    createdAt = dateFormat.format(dateTime);
    return Container(
      height: MediaQuery.of(context).size.height * 0.60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                      fit: BoxFit.cover, image: NetworkImage(filePath))),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("4 likes")
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
      ),
    );
  }
}
