import 'package:e_commerce/provider/meme_provider.dart';
import 'package:e_commerce/resources/components/meme_container.dart';
import 'package:e_commerce/resources/components/memes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostedMemes extends StatelessWidget {
  const PostedMemes({super.key});

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MemeProvider>(context, listen: false);
    prov.fetchPostedMemes(context);
    return Consumer<MemeProvider>(
      builder: (context, value, child) {
        return value.isPosted
            ? MemeList(
                memes: value.postedMemesList,
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
