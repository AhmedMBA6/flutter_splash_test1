import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: Text(
        "Hello",
        style: TextStyle(color: Colors.white, fontSize: 20),
      )),
    );
  }
}