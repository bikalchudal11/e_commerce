// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class MemeContainer extends StatelessWidget {
  const MemeContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                "Hari Bahadur",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text("24 dec, 2025"),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Post description"),
            SizedBox(
              height: 5,
            ),
            Container(
              height: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtw1w0P9_gX9H5gsnBFZmazGkBQ3z7bt4iE4_MR-T5LQ&s'))),
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
