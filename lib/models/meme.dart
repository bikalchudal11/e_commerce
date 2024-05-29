import 'package:e_commerce/models/user.dart';

class Meme {
  List<String>? likes;
  String id;
  String? caption;
  String filePath;
  User uploadedBy;
  DateTime createdAt;
  DateTime updatedAt;

  Meme({
    this.likes,
    required this.id,
    this.caption,
    required this.filePath,
    required this.uploadedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  static Meme parseFromJson(Map<String, dynamic> rawMeme) {
    return Meme(
        id: rawMeme['_id'],
        likes: (rawMeme['likes'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
        caption: rawMeme['caption'],
        filePath: rawMeme['filePath'],
        uploadedBy: User.parseFromJson(rawMeme['uploadedBy']),
        createdAt: DateTime.parse(rawMeme['createdAt']),
        updatedAt: DateTime.parse(rawMeme['updatedAt']));
  }
}
