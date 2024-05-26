import 'package:e_commerce/provider/meme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PostedMemes extends StatelessWidget {
  const PostedMemes({super.key});

  @override
  Widget build(BuildContext context) {
    // var prov = Provider.of<MemeProvider>(context, listen: false);
    // prov.fetchPostedMemes(context);
    // print(prov.postedMemesList);
    return Expanded(
      child: ListView(
        children: [
          Text("Posted"),
        ],
      ),
    );
  }
}
