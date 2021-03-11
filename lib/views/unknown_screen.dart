import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          '404 Error',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
