import 'package:flutter/material.dart';
import '../services/data_service.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  Future<bool> signup(User newUser) async {
    try {
      await DataService.addUser(newUser.toJson());
      return true;
    } catch (e) {
      print('Error during signup: $e');
      return false;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      // Fetch the list of user data from the data service
      final List<Map<String, dynamic>> users = await DataService.getData();

      // Find the user matching the provided email and password
      Map<String, dynamic>? user;
      for (var u in users) {
        if (u['email'] == email && u['password'] == password) {
          user = u;
          break;
        }
      }

      // Return the user object if found, otherwise return null
      return user != null ? User.fromJson(user) : null;
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }
}
