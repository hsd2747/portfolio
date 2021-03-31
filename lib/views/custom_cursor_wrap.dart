import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../models/mouse_cursor.dart';

import '../theme/theme_manager.dart';

class CustomCursorWrap extends StatefulWidget {
  final Widget child;

  CustomCursorWrap({@required this.child});

  @override
  _CustomCursorWrapState createState() => _CustomCursorWrapState();
}

class _CustomCursorWrapState extends State<CustomCursorWrap> {
  bool initialize = false;

  @override
  void initState() {
    initialize = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mouseCursorModel = Provider.of<MouseCursorModel>(
      context,
      listen: false,
    );

    if (initialize) {
      initialize = false;

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        mouseCursorModel.setHoverButton(false);
      });
    }

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
                  Selector<MouseCursorModel, Tuple2<bool, Offset>>(
                    selector: (context, model) => Tuple2<bool, Offset>(
                      model.hoverButton,
                      model.mousePosition,
                    ),
                    builder: (context, value, child) {
                      return AnimatedPositioned(
                        left: value.item1
                            ? value.item2.dx - 25
                            : value.item2.dx - 15,
                        top: value.item1
                            ? value.item2.dy - 25
                            : value.item2.dy - 15,
                        duration: Duration(
                          milliseconds: 100,
                        ),
                        curve: Curves.easeOutCubic,
                        child: IgnorePointer(
                          ignoring: true,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            width: value.item1 ? 60 : 40,
                            height: value.item1 ? 60 : 40,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: CustomTheme.of(context).mainColorLight50,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(
                                value.item1 ? 30.0 : 20.0,
                              ),
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
                ],
              )
            : widget.child,
      ),
    );
  }
}
