import 'dart:io';
import 'package:e_commerce/resources/constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddMeme extends StatefulWidget {
  const AddMeme({super.key});

  @override
  State<AddMeme> createState() => _AddMemeState();
}

class _AddMemeState extends State<AddMeme> {
  XFile? image;
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: secondaryColor,
        title: Text(
          "Add meme",
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
                  onTap: () async {
                    image = await picker.pickImage(source: ImageSource.gallery);
                    setState(() {});
                  },
                  child: image == null
                      ? Container(
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
                                  "Click to choose a meme",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: FileImage(File(image!.path)))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    image = null;
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.close),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                      side: MaterialStatePropertyAll(
                                          BorderSide())),
                                  onPressed: () async {
                                    image = await picker.pickImage(
                                      source: ImageSource.gallery,
                                    );
                                    setState(() {});
                                  },
                                  child: Text(
                                    "Choose Another",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                style: ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(Size.fromWidth(400)),
                    backgroundColor: MaterialStatePropertyAll(
                        image == null ? Colors.grey : primaryColor),
                    foregroundColor: MaterialStatePropertyAll(secondaryColor)),
                onPressed: image == null ? null : () {},
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Post this meme",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
