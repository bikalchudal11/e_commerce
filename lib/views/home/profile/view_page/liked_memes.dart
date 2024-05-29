// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:e_commerce/provider/meme_provider.dart';
import 'package:e_commerce/resources/components/memes.dart';

class LikedMemes extends StatelessWidget {
  String id;
  LikedMemes({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MemeProvider>(context, listen: false);
    prov.fetchLikedMemes(context, id);
    return Consumer<MemeProvider>(
      builder: (context, value, child) {
        return value.isLiked
            ? MemeList(
                memes: value.likedMemesList,
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
