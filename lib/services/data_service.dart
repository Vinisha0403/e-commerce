import 'dart:convert';
import 'package:http/http.dart' as http;
//import '../models/user.dart';

class DataService {
  static const String _baseUrl =
      'http://localhost:3000'; // Adjust this if needed

  // Add user to the server
  static Future<void> addUser(Map<String, dynamic> userData) async {
    final url = Uri.parse('$_baseUrl/user'); // Endpoint for adding a user
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userData),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add user');
    }
  }

  // Fetch user data from the server
  static Future<List<Map<String, dynamic>>> getData() async {
    final url = Uri.parse('$_baseUrl/user'); // Endpoint for fetching user data
    final response = await http.get(url);
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      // return json.decode(response.body);
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
