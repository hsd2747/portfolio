import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../models/mouse_cursor_model.dart';

import '../navigator/router.dart';
import '../navigator/routes.dart';

import '../components/sequence_animation.dart';
import '../components/mouse_effect_wrap.dart';

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

    return Stack(
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
                  child: menuWidget(
                    'Portfolio',
                    onTap: () {
                      (Router.of(context).routerDelegate as AppRouterDelegate)
                          .changePage(
                        PortfolioRoute(),
                      );
                    },
                    mouseCursorModel: mouseCursorModel,
                  ),
                ),
                SequenceAnimation(
                  controller: _controller,
                  startInterval: 0.200,
                  endInterval: 0.700,
                  axis: AnimationAxis.right,
                  child: menuWidget(
                    'Project 1',
                    onTap: () {
                      (Router.of(context).routerDelegate as AppRouterDelegate)
                          .changePage(
                        FirstProjectRoute(),
                      );
                    },
                    mouseCursorModel: mouseCursorModel,
                  ),
                ),
                SequenceAnimation(
                  controller: _controller,
                  startInterval: 0.300,
                  endInterval: 0.800,
                  axis: AnimationAxis.right,
                  child: menuWidget(
                    'Project 2',
                    onTap: () {
                      (Router.of(context).routerDelegate as AppRouterDelegate)
                          .changePage(
                        SecondProjectRoute(),
                      );
                    },
                    mouseCursorModel: mouseCursorModel,
                  ),
                ),
                SequenceAnimation(
                  controller: _controller,
                  startInterval: 0.400,
                  endInterval: 0.900,
                  axis: AnimationAxis.right,
                  child: menuWidget(
                    'Project 3',
                    onTap: () {
                      (Router.of(context).routerDelegate as AppRouterDelegate)
                          .changePage(
                        ThirdProjectRoute(),
                      );
                    },
                    mouseCursorModel: mouseCursorModel,
                  ),
                ),
              ],
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
                MouseEffectWrap(
                  child: CupertinoSwitch(
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget menuWidget(
    String title, {
    VoidCallback onTap,
    MouseCursorModel mouseCursorModel,
  }) {
    return MouseEffectWrap(
      child: GestureDetector(
        onTap: onTap,
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
      ),
    );
  }
}
