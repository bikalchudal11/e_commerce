import 'package:e_commerce/provider/meme_provider.dart';
import 'package:e_commerce/resources/components/meme_container.dart';
import 'package:e_commerce/resources/components/memes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikedMemes extends StatelessWidget {
  const LikedMemes({super.key});

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MemeProvider>(context, listen: false);
    prov.fetchLikedMemes(context);
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
