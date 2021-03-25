import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../models/mouse_cursor.dart';

import '../theme/theme_manager.dart';

class CustomCursorWrap extends StatefulWidget {
  final Widget child;

  CustomCursorWrap({@required this.child});

  @override
  _CustomCursorWrapState createState() => _CustomCursorWrapState();
}

class _CustomCursorWrapState extends State<CustomCursorWrap> {
  @override
  Widget build(BuildContext context) {
    final mouseCursorModel = Provider.of<MouseCursorModel>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: CustomTheme.of(context).background,
      body: MouseRegion(
        cursor: SystemMouseCursors.none,
        onHover: (eve) {
          mouseCursorModel.changeCursorPoint(eve.position);
        },
        child: kIsWeb
            ? Stack(
                children: [
                  widget.child,
                  Selector<MouseCursorModel, bool>(
                    selector: (context, model) => model.hoverButton,
                    builder: (context, hoverButton, child) {
                      return Selector<MouseCursorModel, Offset>(
                        selector: (context, model) => model.mousePosition,
                        builder: (context, secondPosition, child) {
                          return Positioned(
                            left: hoverButton
                                ? secondPosition.dx - 25
                                : secondPosition.dx - 15,
                            top: hoverButton
                                ? secondPosition.dy - 25
                                : secondPosition.dy - 15,
                            child: IgnorePointer(
                              ignoring: true,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.bounceIn,
                                width: hoverButton ? 60 : 40,
                                height: hoverButton ? 60 : 40,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: CustomTheme.of(context)
                                        .mainColorLight50,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    hoverButton ? 30.0 : 20.0,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
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
                ],
              )
            : widget.child,
      ),
    );
  }
}
