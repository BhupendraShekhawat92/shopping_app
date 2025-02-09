class User {
  final String username;
  final String password;
  final String token;

  User({
    required this.username,
    required this.password,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username']??"",
      password: json['password']??"",
      token: json['token']??"",
    );
  }
}
