import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/sign_in_form.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _signIn() async {
    final prefs = await SharedPreferences.getInstance();
    final enteredUsername = _usernameController.text;
    final enteredPassword = _passwordController.text;

    // Check if the entered username and password are correct
    if (enteredUsername == 'avinash@gmail.com' && enteredPassword == '1234') {
      prefs.setBool('isSignedIn', true);
      Navigator.pushReplacementNamed(context, '/crop_list');
    } else {
      // Show a popup for invalid user credentials
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid User'),
          content: const Text('The username or password is incorrect.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign In',
          style: TextStyle(
            fontSize: 20, // Adjust the font size as needed
            fontWeight: FontWeight.bold, // Bold font weight
            color: Colors.white, // Text color
          ),
        ),
        backgroundColor: Colors.blue, // Background color of the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SignInForm(
          usernameController: _usernameController,
          passwordController: _passwordController,
          onSignIn: _signIn,
        ),
      ),
    );
  }
}
