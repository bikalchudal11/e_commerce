import 'package:e_commerce/models/meme.dart';
import 'package:e_commerce/resources/components/meme_container.dart';
import 'package:flutter/material.dart';

class MemeList extends StatelessWidget {
  List<Meme> memes;

  MemeList({
    super.key,
    required this.memes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: memes
          .map((e) => MemeContainer(
                meme: e,
              ))
          .toList(),
    );
  }
}
