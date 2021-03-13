import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../models/mouse_cursor.dart';

import '../navigator/router.dart';
import '../navigator/routes.dart';

import '../components/sequence_animation.dart';

import '../theme/theme_manager.dart';
import '../theme/custom_theme_data.dart';

class MainMenuScreen extends StatefulWidget {
  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 1000,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) _controller.forward();
    });
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
        backgroundColor: CustomTheme.of(context).background,
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
                          color: CustomTheme.of(context).mainColorLight50,
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
                        color: CustomTheme.of(context).mainColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 24, 24),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '다크 모드',
                      style: TextStyle(
                        fontSize: 14,
                        color: CustomTheme.of(context).mainTextColor,
                      ),
                    ),
                    SizedBox(width: 10),
                    CupertinoSwitch(
                      value: CustomTheme.of(context).isDark,
                      activeColor: CustomTheme.of(context).mainColor,
                      onChanged: (value) {
                        if (value) {
                          customThemeManager.onThemeChanged(DarkThemeData());
                        } else {
                          customThemeManager.onThemeChanged(LightThemeData());
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
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
            style: TextStyle(
              fontSize: 24,
              color: CustomTheme.of(context).mainTextColor,
            ),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
