class User {
  final String userId;
  final String password;

  User({
    required this.userId,
    required this.password
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] ?? '',
      password: json['password'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'password': password
    };
  }
}
