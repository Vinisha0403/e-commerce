class User {
  final String id;
  final String username;
  final String email;
  final String password;
  final String phoneNumber;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
    };
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
