// ignore_for_file: prefer_const_literals_to_create_immutables, must_be_immutable, prefer_is_empty, unnecessary_null_comparison
import 'package:e_commerce/models/meme.dart';
import 'package:e_commerce/provider/auth_provider.dart';
import 'package:e_commerce/provider/meme_provider.dart';
import 'package:e_commerce/resources/constant.dart';
import 'package:e_commerce/views/home/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    // print(caption);
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = dateFormat.format(widget.meme.createdAt);
    var prov = Provider.of<AuthProvider>(context, listen: false);
    var provMeme = Provider.of<MemeProvider>(context, listen: false);
    String? userId = prov.userDetails!.id;

    // print(provMeme.memesList);
    // print(userId);
    // print(widget.uploadPersonId);
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
              Text(
                ((widget.meme.likes!.length) == 0
                        ? " "
                        : "${widget.meme.likes!.length} ") +
                    ((widget.meme.likes!.length == 1) ? "like" : "likes"),
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
