class User {
  String name;
  String email;
  String phone;
  String id;
  String? imageURL;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.id,
    this.imageURL,
  });

  static User parseFromJson(Map<String, dynamic> rawUser) {
    return User(
        name: rawUser['name'],
        email: rawUser['email'],
        phone: rawUser['phone'],
        id: rawUser['id'],
        imageURL: rawUser['imageURL']);
  }
}
