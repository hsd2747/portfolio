import 'package:flutter/material.dart';

enum AnimationAxis {
  left,
  top,
  right,
  bottom,
}

class SequenceAnimation extends StatefulWidget {
  final double startInterval;
  final double endInterval;
  final AnimationController controller;
  final Widget child;
  final AnimationAxis axis;

  SequenceAnimation({
    @required this.startInterval,
    @required this.endInterval,
    @required this.controller,
    @required this.child,
    this.axis = AnimationAxis.bottom,
  });

  @override
  _SequenceAnimationState createState() => _SequenceAnimationState();
}

class _SequenceAnimationState extends State<SequenceAnimation> {
  Animation<double> opacity;
  Animation<double> moveTo;

  @override
  void initState() {
    opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Interval(
          widget.startInterval,
          widget.endInterval,
          curve: Curves.ease,
        ),
      ),
    );

    moveTo = Tween<double>(
      begin:
          widget.axis == AnimationAxis.top || widget.axis == AnimationAxis.left
              ? -50
              : 50,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Interval(
          widget.startInterval,
          widget.endInterval,
          curve: Curves.ease,
        ),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity.value,
      child: Transform(
        transform: Matrix4.translationValues(
          widget.axis == AnimationAxis.left ||
                  widget.axis == AnimationAxis.right
              ? moveTo.value
              : 0,
          widget.axis == AnimationAxis.top ||
                  widget.axis == AnimationAxis.bottom
              ? moveTo.value
              : 0,
          0,
        ),
        child: widget.child,
      ),
    );
  }
}
