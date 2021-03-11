import 'package:flutter/material.dart';
import 'package:portfolio/navigator/routes.dart';

import 'navigator/route_parser.dart';
import 'navigator/router.dart';

import 'views/first_project.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  AppRouterDelegate _appRouterDelegate = AppRouterDelegate();
  AppRouteInformationParser _appRouteInformationParser =
      AppRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: _appRouterDelegate,
      routeInformationParser: _appRouteInformationParser,
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Portfolio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            InkWell(
              child: Container(
                child: Center(
                  child: Text('Move First Project'),
                ),
              ),
              onTap: () {
                (Router.of(context).routerDelegate as AppRouterDelegate)
                    .changePage(
                  FirstProjectRoute(),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
