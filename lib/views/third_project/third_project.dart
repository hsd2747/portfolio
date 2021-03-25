import 'package:flutter/material.dart';

import '../../theme/theme_manager.dart';

class ThirdProject extends StatefulWidget {
  @override
  _ThirdProjectState createState() => _ThirdProjectState();
}

class _ThirdProjectState extends State<ThirdProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.of(context).background,
      body: Container(
        alignment: Alignment.center,
        child: Text(
          'thirdProject',
          style: TextStyle(
            color: CustomTheme.of(context).mainTextColor,
          ),
        ),
      ),
    );
  }
}
