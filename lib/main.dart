import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'navigator/route_parser.dart';
import 'navigator/router.dart';

import 'models/mouse_cursor_model.dart';

import 'theme/custom_theme_data.dart';
import 'theme/theme_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouterDelegate _appRouterDelegate = AppRouterDelegate();
  final AppRouteInformationParser _appRouteInformationParser =
      AppRouteInformationParser();

  final mouseCursorModel = MouseCursorModel();

  // theme
  CustomThemeData customThemeData;

  @override
  void initState() {
    var brightness = SchedulerBinding.instance.window.platformBrightness;

    if (brightness == Brightness.dark) {
      customThemeData = DarkThemeData();
    } else {
      customThemeData = LightThemeData();
    }

    customThemeManager.onThemeChanged = onThemeChanged;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: mouseCursorModel,
      builder: (context, child) {
        return AnimatedCustomTheme(
          customThemeData: this.customThemeData,
          child: MaterialApp.router(
            title: 'Portfolio',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'NanumSquare',
              primarySwatch: Colors.blue,
            ),
            routerDelegate: _appRouterDelegate,
            routeInformationParser: _appRouteInformationParser,
          ),
        );
      },
    );
  }

  void onThemeChanged(CustomThemeData customThemeData) {
    setState(() {
      this.customThemeData = customThemeData;
    });
  }
}
