import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'navigator/routes.dart';
import 'navigator/route_parser.dart';
import 'navigator/router.dart';

import 'models/mouse_cursor.dart';

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
    return ChangeNotifierProvider(
      create: (context) => MouseCursorModel(),
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Portfolio',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routerDelegate: _appRouterDelegate,
          routeInformationParser: _appRouteInformationParser,
        );
      },
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

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 1000,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mouseCursorModel = Provider.of<MouseCursorModel>(
      context,
      listen: false,
    );

    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onHover: (eve) {
        mouseCursorModel.changeCursorPoint(eve.position);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SequenceAnimation(
                      controller: _controller,
                      startInterval: 0.100,
                      endInterval: 0.600,
                      axis: AnimationAxis.right,
                      child: menuWidget('Portfolio', onTap: () {
                        (Router.of(context).routerDelegate as AppRouterDelegate)
                            .changePage(
                          PortfolioRoute(),
                        );
                      }),
                    ),
                    SequenceAnimation(
                      controller: _controller,
                      startInterval: 0.200,
                      endInterval: 0.700,
                      axis: AnimationAxis.right,
                      child: menuWidget(
                        'Project 1',
                        onTap: () {
                          (Router.of(context).routerDelegate
                                  as AppRouterDelegate)
                              .changePage(
                            FirstProjectRoute(),
                          );
                        },
                      ),
                    ),
                    SequenceAnimation(
                      controller: _controller,
                      startInterval: 0.300,
                      endInterval: 0.800,
                      axis: AnimationAxis.right,
                      child: menuWidget('Project 2'),
                    ),
                    SequenceAnimation(
                      controller: _controller,
                      startInterval: 0.400,
                      endInterval: 0.900,
                      axis: AnimationAxis.right,
                      child: menuWidget('Project 3'),
                    ),
                  ],
                );
              },
            ),
            Selector<MouseCursorModel, Offset>(
              selector: (context, model) => model.secondPosition,
              builder: (context, secondPosition, child) {
                return Positioned(
                  left: secondPosition.dx - 15,
                  top: secondPosition.dy - 15,
                  child: IgnorePointer(
                    ignoring: true,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.indigo[300],
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                );
              },
            ),
            Selector<MouseCursorModel, Offset>(
              selector: (context, model) => model.mousePosition,
              builder: (context, mousePosition, child) {
                return Positioned(
                  left: mousePosition.dx,
                  top: mousePosition.dy,
                  child: IgnorePointer(
                    ignoring: true,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.indigo[700],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget menuWidget(
    String title, {
    VoidCallback onTap,
  }) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(32, 16, 32, 16),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
