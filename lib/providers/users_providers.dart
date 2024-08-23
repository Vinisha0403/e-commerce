import 'package:flutter/material.dart';
import '../models/user.dart';

class UsersProvider with ChangeNotifier {
  List<User> _users = [
    // Add sample users or fetch from an API
    User(
        id: '1',
        username: 'John_Doe',
        email: 'john@example.com',
        password: '123456',
        phoneNumber: '9872345678'),
    User(
        id: '638',
        username: 'shinchan',
        email: 'shinchan@gmail.com',
        password: '123123',
        phoneNumber: '9812981298'),
    // Add other users
  ];

  List<User> get users => _users;

  User? getUserByEmail(String? email) {
    if (email == null) {
      return null;
    }

    try {
      List<User> filteredUsers =
          _users.where((user) => user.email == email).toList();
      return filteredUsers.isNotEmpty ? filteredUsers.first : null;
    } catch (e) {
      print('Error finding user: $e');
      return null;
    }
  }
}
