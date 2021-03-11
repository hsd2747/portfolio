import 'package:flutter/material.dart';
import 'package:portfolio/navigator/routes.dart';

import 'navigator/route_parser.dart';
import 'navigator/router.dart';

import 'views/first_project.dart';

import 'components/sequence_animation.dart';

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

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  int _counter = 0;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 7,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SequenceAnimation(
                controller: _controller,
                startInterval: 0.0,
                endInterval: 0.100,
                axis: AnimationAxis.right,
                child: Container(
                  width: 90,
                  height: 90,
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45.0),
                    color: Colors.indigo,
                  ),
                  child: Center(
                    child: Text('사진'),
                  ),
                ),
              ),
              SequenceAnimation(
                controller: _controller,
                startInterval: 0.100,
                endInterval: 0.200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('example text1'),
                    SizedBox(width: 15),
                    Text('example text2'),
                    SizedBox(width: 15),
                    Text('example text3'),
                    SizedBox(width: 15),
                    Text('example text4'),
                  ],
                ),
              ),
              SizedBox(height: 20),
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
}
