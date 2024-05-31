// ignore_for_file: prefer_const_literals_to_create_immutables, must_be_immutable, prefer_is_empty, unnecessary_null_comparison, use_build_context_synchronously, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings
import 'dart:convert';

import 'package:e_commerce/models/meme.dart';
import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/provider/auth_provider.dart';
import 'package:e_commerce/provider/meme_provider.dart';
import 'package:e_commerce/resources/constant.dart';
import 'package:e_commerce/views/home/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MemeContainer extends StatefulWidget {
  Meme meme;

  MemeContainer({super.key, required this.meme});

  @override
  State<MemeContainer> createState() => _MemeContainerState();
}

class _MemeContainerState extends State<MemeContainer> {
  TextEditingController captionController = TextEditingController();
  @override
  void initState() {
    captionController.text = widget.meme.caption.toString();
    super.initState();
  }

  Future<void> goToProfile() async {
    var prov = Provider.of<AuthProvider>(context, listen: false);
    //check if the user on tapping
    //if the user is self then pass the data through user details
    //if the user is not self then pass the data through the meme

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfilePage(
                  user: widget.meme.uploadedBy,
                )));
  }

  Future<void> showLikersInfo() async {
    String token = AuthProvider.authId;
    List<User>? likersList;
    // print(token);
    var response = await http.get(
      Uri.parse("$baseApi" + "memes/" + "${widget.meme.id}" + "/likers"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    var decodedResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (int i = 0; i < decodedResponse.length; i++) {
        // print(decodedResponse[i]);
        likersList = (decodedResponse as List<dynamic>)
            .map((e) => User.parseFromJson(e))
            .toList();
      }
      // print(likersList!.first.name);
    } else {
      throw Exception(decodedResponse['message']);
    }

    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
          child: Container(
        width: double.infinity,
        // width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: textFieldBgColor),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: likersList!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfilePage(user: likersList![index])));
                  },
                  leading: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: textFieldBgColor,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: likersList![index].imageURL == null
                                ? NetworkImage(User.defaultImageUrl)
                                : NetworkImage(likersList[index].imageURL!))),
                  ),
                  title: Text(likersList[index].name),
                  trailing: Icon(
                    Icons.favorite,
                    size: 20,
                    color: Colors.red,
                  ),
                ),
              );
            }),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(caption);
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = dateFormat.format(widget.meme.createdAt);
    var prov = Provider.of<AuthProvider>(context, listen: false);
    var provMeme = Provider.of<MemeProvider>(context, listen: false);
    String userId = prov.userDetails!.id;

    // print(provMeme.memesList);
    // print(userId);
    // print(widget.uploadPersonId);
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () {
              goToProfile();
            },
            contentPadding: EdgeInsets.all(0),
            leading: widget.meme.uploadedBy.imageURL != null
                ? Container(
                    width: 40,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.meme.uploadedBy.imageURL!),
                        ),
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 216, 204, 239)),
                  )
                : Container(
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(255, 206, 185, 243)),
                    // backgroundImage: FileImage(File(profilePic!.path)),
                    child: Center(
                      child: Icon(Icons.person),
                    )),
            title: Text(
              widget.meme.uploadedBy.name,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(formattedDate),
            trailing: userId == widget.meme.uploadedBy.id
                ? PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text(
                                      "Do you want to delete this meme ?",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                primaryColor,
                                              ),
                                              foregroundColor:
                                                  MaterialStatePropertyAll(
                                                secondaryColor,
                                              ),
                                            ),
                                            onPressed: () {
                                              provMeme.deleteMeme(
                                                  widget.meme.id, context);
                                              Navigator.pop(context);
                                            },
                                            child: Text("Yes"),
                                          ),
                                          TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                primaryColor,
                                              ),
                                              foregroundColor:
                                                  MaterialStatePropertyAll(
                                                secondaryColor,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("No"),
                                          )
                                        ],
                                      ),
                                    ],
                                  ));
                        },
                        value: "delete",
                        child: Text("Delete"),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: ((context) => AlertDialog(
                                    title: Text(
                                      "Edit caption",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    content: TextField(
                                      controller: captionController,
                                      decoration: InputDecoration(
                                        fillColor: textFieldBgColor,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                primaryColor,
                                              ),
                                              foregroundColor:
                                                  MaterialStatePropertyAll(
                                                secondaryColor,
                                              ),
                                            ),
                                            onPressed: () {
                                              provMeme.editCaption(
                                                  widget.meme.id,
                                                  captionController.text,
                                                  context);
                                              Navigator.pop(context);
                                            },
                                            child: Text("Save"),
                                          ),
                                          TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                primaryColor,
                                              ),
                                              foregroundColor:
                                                  MaterialStatePropertyAll(
                                                secondaryColor,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Don't save"),
                                          )
                                        ],
                                      ),
                                    ],
                                  )));
                        },
                        value: "edit",
                        child: Text("Edit"),
                      ),
                    ],
                  )
                : SizedBox(),
          ),
          SizedBox(
            height: 5,
          ),
          Text(widget.meme.caption == null
              ? ""
              : widget.meme.caption.toString()),
          SizedBox(
            height: 15,
          ),
          Container(
            height: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(widget.meme.filePath))),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Consumer<MemeProvider>(builder: (context, value, child) {
                return IconButton(
                  onPressed: () {
                    value.toggleLike(widget.meme.id);
                  },
                  icon: Icon(
                      widget.meme.likes!.contains(userId)
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: widget.meme.likes!.contains(userId)
                          ? Colors.red
                          : Colors.black),
                );
              }),
              InkWell(
                onTap: () {
                  showLikersInfo();
                },
                child: Text(
                  ((widget.meme.likes!.length) == 0
                          ? " "
                          : "${widget.meme.likes!.length} ") +
                      ((widget.meme.likes!.length == 1) ? "like" : "likes"),
                ),
              ),
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
