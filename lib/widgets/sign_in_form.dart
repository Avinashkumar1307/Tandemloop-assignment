import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback onSignIn;

  const SignInForm({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.onSignIn,
  }) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Welcome Back!',
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Sign in to continue to your account and manage your crops efficiently.',
            style: TextStyle(
              fontSize: 18.0,
              color: Theme.of(context).primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          TextField(
            controller: widget.usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: widget.passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
            obscureText: !_isPasswordVisible,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: widget.onSignIn,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              textStyle: TextStyle(fontSize: 18.0),
              // primary: Theme.of(context).primaryColor, // Use theme color
            ),
            child: Text('Sign In',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.color, // Use theme color
                )),
          ),
          SizedBox(height: 20),
          Text(
            'Or',
            style: TextStyle(
              fontSize: 16.0,
              color: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.color, // Use theme color
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            child: Column(
              children: [
                const SizedBox(height: 10),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            child: Text('Continue with Google'),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              textStyle: TextStyle(fontSize: 20.0),
              primary: Theme.of(context).primaryColor, // Use theme color
            ),
          ),
        ],
      ),
    );
  }
}
