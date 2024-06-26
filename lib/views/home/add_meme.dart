// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:e_commerce/provider/auth_provider.dart';
import 'package:e_commerce/provider/meme_provider.dart';
import 'package:e_commerce/resources/constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';

class AddMeme extends StatefulWidget {
  const AddMeme({super.key});

  @override
  State<AddMeme> createState() => _AddMemeState();
}

class _AddMemeState extends State<AddMeme> {
  XFile? image;
  final ImagePicker picker = ImagePicker();
  TextEditingController captionController = TextEditingController();
  bool isSendingRequest = false;
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
      body: SingleChildScrollView(
        child: Padding(
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
                    controller: captionController,
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
                      image =
                          await picker.pickImage(source: ImageSource.gallery);
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
              SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: isSendingRequest
                    ? CircularProgressIndicator()
                    : TextButton(
                        style: ButtonStyle(
                            fixedSize:
                                MaterialStatePropertyAll(Size.fromWidth(400)),
                            backgroundColor: MaterialStatePropertyAll(
                                image == null ? Colors.grey : primaryColor),
                            foregroundColor:
                                MaterialStatePropertyAll(secondaryColor)),
                        onPressed: image == null
                            ? null
                            : () async {
                                try {
                                  setState(() {
                                    isSendingRequest = true;
                                  });
                                  String token = AuthProvider.authId;
                                  String? enteredCaption =
                                      captionController.text;
                                  Uri endPoint = Uri.parse('$baseApi' 'memes');
                                  //creating headers
                                  Map<String, String> headers = {
                                    "Authorization": "Bearer $token"
                                  };
                                  //creating request
                                  var request =
                                      http.MultipartRequest('POST', endPoint);

                                  //setting headers
                                  request.headers.addAll(headers);

                                  //putting caption in request
                                  request.fields
                                      .addAll({"caption": enteredCaption});

                                  // putting file in request
                                  request.files.add(
                                    await http.MultipartFile.fromPath(
                                      "image",
                                      image!.path,
                                      // we need to send mime type of file also.
                                      contentType: MediaType.parse(
                                        lookupMimeType(image!.path)!,
                                      ),
                                    ),
                                  );

                                  var res = await request.send();
                                  final resBody =
                                      await res.stream.bytesToString();
                                  // print(resBody);
                                  if (res.statusCode == 201) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text(
                                                "Meme Uploaded Successfully")));
                                    Navigator.of(context).pop();
                                    Provider.of<MemeProvider>(context,
                                            listen: false)
                                        .fetchMemes();
                                  } else {
                                    throw Exception(resBody);
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())));
                                } finally {
                                  setState(() {
                                    isSendingRequest = false;
                                  });
                                }
                              },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Post this meme",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
