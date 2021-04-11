import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../models/mouse_cursor_model.dart';

import '../theme/theme_manager.dart';

class CustomCursorWrap extends StatefulWidget {
  final Widget child;

  CustomCursorWrap({@required this.child});

  @override
  _CustomCursorWrapState createState() => _CustomCursorWrapState();
}

class _CustomCursorWrapState extends State<CustomCursorWrap> {
  double scroll_length = 130;
  final int scroll_speed_ms = 1000;

  bool initialize = false;

  double _scroll = 0;

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

    scroll_length = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: CustomTheme.of(context).background,
      body: MouseRegion(
        cursor: SystemMouseCursors.none,
        child: kIsWeb
            ? Listener(
                behavior: HitTestBehavior.translucent,
                onPointerHover: (eve) {
                  mouseCursorModel.changeCursorPoint(eve.position);
                },
                onPointerMove: (eve) {
                  mouseCursorModel.changeCursorPoint(eve.position);
                },
                onPointerSignal: (pointerSignal) {
                  if (mouseCursorModel.scrollController == null) return;
                  if (!mouseCursorModel.scrollController.hasClients) return;

                  int millis = scroll_speed_ms;

                  if (pointerSignal is PointerScrollEvent) {
                    if (pointerSignal.scrollDelta.dy > 0) {
                      _scroll += scroll_length;
                    } else {
                      _scroll -= scroll_length;
                    }

                    double maxScrollExtent = mouseCursorModel
                        .scrollController.position.maxScrollExtent;

                    if (_scroll > maxScrollExtent) {
                      _scroll = maxScrollExtent;
                      //millis = scroll_speed_ms ~/ 2;
                    } else if (_scroll < 0) {
                      _scroll = 0;
                      //millis = scroll_speed_ms ~/ 2;
                    }

                    mouseCursorModel.scrollController.animateTo(
                      _scroll,
                      duration: Duration(milliseconds: millis),
                      curve: Curves.ease,
                    );
                  }
                },
                child: Stack(
                  fit: StackFit.expand,
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
                                  color:
                                      CustomTheme.of(context).mainColorLight50,
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
                ),
              )
            : widget.child,
      ),
    );
  }
}
