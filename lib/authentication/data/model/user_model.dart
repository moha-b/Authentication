class User {
  String? name;
  String? email;
  String? picture;

  User({
    required this.name,
    required this.email,
    required this.picture,
  });

  factory User.empty() {
    return User(name: "name", email: "email", picture: "picture");
  }
}
