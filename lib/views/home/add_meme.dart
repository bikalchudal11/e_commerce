import 'package:e_commerce/resources/constant.dart';
import 'package:e_commerce/resources/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddMeme extends StatelessWidget {
  const AddMeme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Post a new meme",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Write caption:"),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "caption here...",
                    filled: true,
                    fillColor: textFieldBgColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Upload meme:"),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Icon(
                            Icons.add_a_photo_outlined,
                            size: 30,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Click to choose a file",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                // Container(
                //   height: MediaQuery.of(context).size.width * 0.9,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       image: DecorationImage(
                //           fit: BoxFit.fill,
                //           image: NetworkImage(
                //               'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtw1w0P9_gX9H5gsnBFZmazGkBQ3z7bt4iE4_MR-T5LQ&s'))),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     IconButton(
                //       onPressed: () {},
                //       icon: Icon(Icons.close),
                //     ),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     TextButton(
                //       style: ButtonStyle(
                //           side: MaterialStatePropertyAll(BorderSide())),
                //       onPressed: () {},
                //       child: Text(
                //         "Choose Another",
                //         style: TextStyle(
                //           color: Colors.black,
                //         ),
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
            CustomButton(buttonName: "Post this meme")
          ],
        ),
      ),
    );
  }
}
