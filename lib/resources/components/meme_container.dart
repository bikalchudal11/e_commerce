// ignore_for_file: prefer_const_literals_to_create_immutables, must_be_immutable, prefer_is_empty
import 'package:e_commerce/provider/auth_provider.dart';
import 'package:e_commerce/provider/meme_provider.dart';
import 'package:e_commerce/resources/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MemeContainer extends StatefulWidget {
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
  State<MemeContainer> createState() => _MemeContainerState();
}

class _MemeContainerState extends State<MemeContainer> {
  TextEditingController captionController = TextEditingController();
  @override
  void initState() {
    captionController.text = widget.caption!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(caption);
    DateTime dateTime = DateTime.parse(widget.createdAt);
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    widget.createdAt = dateFormat.format(dateTime);
    var prov = Provider.of<AuthProvider>(context, listen: false);
    var provMeme = Provider.of<MemeProvider>(context, listen: false);
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
              widget.name,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(widget.createdAt),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {
                    showDialog(
                        context: context, builder: (context) => AlertDialog());
                    provMeme.deleteMeme(widget.memeId, context);
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
                                        provMeme.editCaption(widget.memeId,
                                            captionController.text, context);
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
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(widget.caption!),
          SizedBox(
            height: 15,
          ),
          Container(
            height: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(widget.filePath))),
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
                        value.toggleLike(widget.memeId);
                      },
                      icon: Icon(
                          widget.likesIds!.contains(userId)
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: widget.likesIds!.contains(userId)
                              ? Colors.red
                              : Colors.black),
                    );
                  }),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    ((widget.likesIds!.length) == 0
                            ? " "
                            : "${widget.likesIds!.length} ") +
                        ((widget.likesIds!.length == 1) ? "like" : "likes"),
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
