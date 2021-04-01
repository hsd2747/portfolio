import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/mouse_cursor_model.dart';

class MouseEffectWrap extends StatelessWidget {
  final Widget child;

  MouseEffectWrap({this.child});

  @override
  Widget build(BuildContext context) {
    final mouseCursorModel = Provider.of<MouseCursorModel>(
      context,
      listen: false,
    );

    return MouseRegion(
      onEnter: (event) {
        mouseCursorModel.setHoverButton(true);
      },
      onExit: (event) {
        mouseCursorModel.setHoverButton(false);
      },
      child: child,
    );
  }
}
