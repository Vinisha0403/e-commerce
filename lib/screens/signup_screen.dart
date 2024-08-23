import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/auth_provider.dart';
import 'dart:math';

class SignupScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  void _signup(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final newUser = User(
        id: Random().nextInt(10000).toString(), // Generate a random ID
        username: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        phoneNumber: _phoneController.text,
      );

      final success = await Provider.of<AuthProvider>(context, listen: false)
          .signup(newUser);

      if (success) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Signup Successful!')));
        Navigator.of(context)
            .pop(); // Navigate back to login after successful signup
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Signup Failed!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Text(
                "Get Started!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Create a new account",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                        _usernameController, Icons.person, "Full Name", false),
                    SizedBox(height: 20),
                    _buildTextField(
                        _emailController, Icons.email, "Email", false,
                        isEmail: true),
                    SizedBox(height: 20),
                    _buildTextField(
                        _passwordController, Icons.lock, "Password", true),
                    SizedBox(height: 20),
                    _buildTextField(
                        _phoneController, Icons.phone, "Phone Number", false),
                    SizedBox(height: 40),
                    _buildSignupButton(context),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Already have an account? Login",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, IconData icon,
      String hintText, bool isPassword,
      {bool isEmail = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.pink),
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hintText';
        }
        if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        if (isPassword && value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }

  Widget _buildSignupButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.pink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () => _signup(context),
        child: Text(
          "Sign Up",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
