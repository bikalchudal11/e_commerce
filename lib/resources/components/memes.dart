import 'package:e_commerce/resources/components/meme_container.dart';
import 'package:flutter/material.dart';

class MemeList extends StatelessWidget {
  List<Map<String, dynamic>> memes;
  MemeList({super.key, required this.memes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: memes
          .map((e) => MemeContainer(
                memeId: e["_id"],
                likesIds: e["likes"],
                name: e['uploadedBy']['name'],
                uploaderImg: e['uploadedBy']['imageURL'],
                uploadPersonId: e['uploadedBy']['id'],
                caption: e['caption'],
                createdAt: e['createdAt'],
                filePath: e['filePath'],
              ))
          .toList(),
    );
  }
}
