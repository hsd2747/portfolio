import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'custom_theme_data.dart';

class CustomThemeManager {
  Function(CustomThemeData customThemeData) onThemeChanged;
}

CustomThemeManager customThemeManager = CustomThemeManager();

class CustomTheme extends StatelessWidget {
  final Widget child;
  final CustomThemeData customThemeData;

  CustomTheme({
    Key key,
    @required this.child,
    @required this.customThemeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _InheritedThemeData(
      customTheme: this,
      child: child,
    );
  }

  static CustomThemeData of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_InheritedThemeData>())
        .customTheme
        .customThemeData;
  }
}

class _InheritedThemeData extends InheritedWidget {
  final CustomTheme customTheme;
  final Widget child;

  _InheritedThemeData({
    Key key,
    @required this.customTheme,
    @required this.child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedThemeData old) {
    // TODO: type 비교
    return this.customTheme != old.customTheme;
  }
}

class CustomThemeDataTween extends Tween<CustomThemeData> {
  CustomThemeDataTween({CustomThemeData begin, CustomThemeData end})
      : super(begin: begin, end: end);

  @override
  CustomThemeData lerp(double t) => CustomThemeData.lerp(begin, end, t);
}

class AnimatedCustomTheme extends StatefulWidget {
  final CustomThemeData customThemeData;
  final Widget child;

  AnimatedCustomTheme({
    Key key,
    @required this.child,
    @required this.customThemeData,
  }) : super(key: key);

  @override
  _AnimatedCustomThemeState createState() => _AnimatedCustomThemeState();
}

class _AnimatedCustomThemeState extends State<AnimatedCustomTheme>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  CustomThemeDataTween _data;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    animation =
        CurvedAnimation(curve: Curves.ease, parent: animationController);
    // Tween<double>(begin: 0.0, end: 1.0).animate(animationController);

    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedCustomTheme oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.customThemeData != oldWidget.customThemeData) {
      _data = CustomThemeDataTween(
          begin: oldWidget.customThemeData, end: widget.customThemeData);

      animationController.reset();
      if (animationController.isDismissed) animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return CustomTheme(
          customThemeData: _data != null
              ? _data.lerp(animation.value)
              : widget.customThemeData,
          child: widget.child,
        );
      },
    );
  }
}
