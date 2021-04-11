import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../../components/sequence_animation.dart';

class MainImageWidget extends StatefulWidget {
  @override
  _MainImageWidgetState createState() => _MainImageWidgetState();
}

class _MainImageWidgetState extends State<MainImageWidget>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController _controller;

  final GlobalKey _mainImageKey = GlobalKey();

  @override
  bool get wantKeepAlive => true;

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
        milliseconds: 2500,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) _controller.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Flow(
            delegate: ParallaxFlowDelegate(
              scrollable: Scrollable.of(context),
              itemContext: context,
              itemKey: _mainImageKey,
            ),
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 5.0,
                    sigmaY: 5.0,
                  ),
                  child: Transform.scale(
                    scale: 1.1,
                    child: Image.asset(
                      'resources/portfolio_main.jpg',
                      key: _mainImageKey,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SequenceAnimation(
                    startInterval: 0.0,
                    endInterval: 0.3,
                    controller: _controller,
                    axis: AnimationAxis.right,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                        40,
                        12,
                        40,
                        12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 6,
                        ),
                      ),
                      child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        animatedTexts: [
                          TyperAnimatedText(
                            'PORTFOLIO',
                            textStyle: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 10,
                            ),
                            speed: Duration(milliseconds: 200),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SequenceAnimation(
                    startInterval: 0.7,
                    endInterval: 1.0,
                    controller: _controller,
                    axis: AnimationAxis.right,
                    child: Text(
                      'MOBILE DEVELOPER   ·   HAN SEUNG DAE',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 50, 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'SCROLL',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      letterSpacing: 5,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 15,
                    padding: EdgeInsets.fromLTRB(0, 8, 4, 0),
                    child: CustomPaint(
                      painter: CustomDownArrow(),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  final ScrollableState scrollable;
  final BuildContext itemContext;
  final GlobalKey itemKey;

  ParallaxFlowDelegate({
    @required this.scrollable,
    @required this.itemContext,
    @required this.itemKey,
  }) : super(repaint: scrollable.position);

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // final scrollableBox =
    //     this.scrollable.context.findRenderObject() as RenderBox;
    // final itemBox = this.itemContext.findRenderObject() as RenderBox;
    // final itemOffset = itemBox.localToGlobal(
    //   itemBox.size.centerLeft(Offset.zero),
    //   ancestor: scrollableBox,
    // );

    // final viewportDimension = this.scrollable.position.viewportDimension;
    // final scrollFraction = (itemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // double y = scrollFraction * 4 - 1;
    // final verticalAlignment = Alignment(0.0, y);

    // final itemSize =
    //     (this.itemKey.currentContext.findRenderObject() as RenderBox).size;
    // final listItemSize = context.size;

    // final childRect = verticalAlignment.inscribe(
    //   itemSize,
    //   Offset.zero & listItemSize,
    // );
    //print('${childRect}');
    final scrollableBox =
        this.scrollable.context.findRenderObject() as RenderBox;
    final itemBox = this.itemContext.findRenderObject() as RenderBox;
    final itemOffset = itemBox.localToGlobal(
      itemBox.size.topLeft(Offset.zero),
      ancestor: scrollableBox,
    );
    // print('$itemOffset ${this.scrollable.position.pixels} ');

    context.paintChild(
      0,
      transform: Transform.translate(
        offset: Offset(
          0.0,
          (itemOffset.dy * 0.6) + this.scrollable.position.pixels,
          // childRect.top,
        ),
      ).transform,
    );
  }

  @override
  bool shouldRepaint(covariant ParallaxFlowDelegate oldDelegate) {
    return this.scrollable != oldDelegate.scrollable ||
        this.itemContext != oldDelegate.itemContext ||
        this.itemKey != oldDelegate.itemKey;
  }
}

class CustomDownArrow extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(0, size.height - (size.height / 4)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
