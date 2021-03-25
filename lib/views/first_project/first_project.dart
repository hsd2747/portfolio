import 'package:flutter/material.dart';

import '../../theme/theme_manager.dart';

class FirstProject extends StatefulWidget {
  @override
  _FirstProjectState createState() => _FirstProjectState();
}

class _FirstProjectState extends State<FirstProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.of(context).background,
      body: Container(
        alignment: Alignment.center,
        child: Text(
          'firstProject',
          style: TextStyle(
            color: CustomTheme.of(context).mainTextColor,
          ),
        ),
      ),
    );
  }
}
