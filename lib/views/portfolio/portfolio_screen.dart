import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/mouse_cursor_model.dart';

import '../../components/sequence_animation.dart';

import '../../theme/theme_manager.dart';

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  final GlobalKey _mainImageKey = GlobalKey();

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
        seconds: 7,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) _controller.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mouseCursorModel = Provider.of<MouseCursorModel>(
      context,
      listen: false,
    );

    return ListView(
      physics: NeverScrollableScrollPhysics(),
      controller: mouseCursorModel.scrollController,
      children: [
        mainImageWidget(),
        Container(
          height: 30,
          color: CustomTheme.of(context).background,
        ),
        Center(
          child: Text(
            'ABOUT ME',
            style: TextStyle(
              color: CustomTheme.of(context).subTextColor1,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 60),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: CustomTheme.of(context).lightBackground,
              ),
              child: Center(
                child: Text('사진'),
              ),
            ),
            SizedBox(width: 60),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MY NAME',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: CustomTheme.of(context).mainTextColor,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '한승대',
                  style: TextStyle(
                    fontSize: 16,
                    color: CustomTheme.of(context).subTextColor2,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'BIRTHDAY',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: CustomTheme.of(context).mainTextColor,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '1999 . 01 . 25',
                  style: TextStyle(
                    fontSize: 16,
                    color: CustomTheme.of(context).subTextColor2,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'CONTACTS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: CustomTheme.of(context).mainTextColor,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '010.4145.2757',
                  style: TextStyle(
                    fontSize: 16,
                    color: CustomTheme.of(context).subTextColor2,
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 5000),
      ],
    );
  }

  Widget mainImageWidget() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width,
      child: Builder(
        builder: (context) {
          return Flow(
            delegate: ParallaxFlowDelegate(
              scrollable: Scrollable.of(context),
              itemContext: context,
              itemKey: _mainImageKey,
            ),
            children: [
              Stack(
                fit: StackFit.expand,
                children: [
                  ImageFiltered(
                    key: _mainImageKey,
                    imageFilter: ImageFilter.blur(
                      sigmaX: 5.0,
                      sigmaY: 5.0,
                    ),
                    child: Image.asset(
                      'resources/portfolio_main.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 36),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 6,
                          ),
                        ),
                        child: Text(
                          'P O R T F O L I O',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'MOBILE DEVELOPER   ·   HAN SEUNG DAE',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
    // Builder(
    //   builder: (context) {
    //     return Flow(
    //       delegate: ParallaxFlowDelegate(
    //         scrollable: Scrollable.of(context),
    //         itemContext: context,
    //         itemKey: _mainImageKey,
    //       ),
    //       children: [

    //       ],
    //     );
    //   },
    // );
  }

  // AnimatedBuilder(
  //     animation: _controller,
  //     builder: (context, child) {
  //       return Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               SequenceAnimation(
  //                 controller: _controller,
  //                 startInterval: 0.0,
  //                 endInterval: 0.100,
  //                 axis: AnimationAxis.top,
  //                 child: SizedBox(
  //                   width: 260,
  //                   child: profileImageWidget(),
  //                 ),
  //               ),
  //               SizedBox(height: 20),
  //               SequenceAnimation(
  //                 startInterval: 0.100,
  //                 endInterval: 0.200,
  //                 controller: _controller,
  //                 axis: AnimationAxis.right,
  //                 child: Text(
  //                   '한 승 대',
  //                   style: TextStyle(
  //                     fontSize: 22,
  //                     fontWeight: FontWeight.bold,
  //                     color: CustomTheme.of(context).mainColor,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 20),
  //               SequenceAnimation(
  //                 startInterval: 0.200,
  //                 endInterval: 0.300,
  //                 controller: _controller,
  //                 axis: AnimationAxis.right,
  //                 child: SizedBox(
  //                   width: 300,
  //                   child: Text(
  //                     '"Lorem ipsum dolor sit amet elit, sed do eiusmod tempor incididunt."',
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(
  //                       fontSize: 18,
  //                       color: CustomTheme.of(context).mainColorLight50,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           SizedBox(width: 50),
  //           Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Row(
  //                 children: [
  //                   SequenceAnimation(
  //                     controller: _controller,
  //                     startInterval: 0.300,
  //                     endInterval: 0.400,
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           'PROFILE',
  //                           style: TextStyle(
  //                             fontSize: 22,
  //                             fontWeight: FontWeight.bold,
  //                             color: CustomTheme.of(context).mainColor,
  //                           ),
  //                         ),
  //                         Container(
  //                           height: 2,
  //                           margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
  //                           color: CustomTheme.of(context).mainColor,
  //                         ),
  //                         profileChildWidget(
  //                           '생년월일',
  //                           '1999년 1월 25일',
  //                         ),
  //                         profileChildWidget(
  //                           '전화번호',
  //                           '010-4145-2757',
  //                         ),
  //                         profileChildWidget(
  //                           '메일',
  //                           'tmdeo2747@gmail.com',
  //                         ),
  //                         profileChildWidget(
  //                           'Git',
  //                           'https://github.com/hsd2747',
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(width: 50),
  //                   SequenceAnimation(
  //                     controller: _controller,
  //                     startInterval: 0.320,
  //                     endInterval: 0.420,
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           'PROFILE',
  //                           style: TextStyle(
  //                             fontSize: 22,
  //                             fontWeight: FontWeight.bold,
  //                             color: CustomTheme.of(context).mainColor,
  //                           ),
  //                         ),
  //                         Container(
  //                           height: 2,
  //                           margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
  //                           color: CustomTheme.of(context).mainColor,
  //                         ),
  //                         profileChildWidget(
  //                           '생년월일',
  //                           '1999년 1월 25일',
  //                         ),
  //                         profileChildWidget(
  //                           '전화번호',
  //                           '010-4145-2757',
  //                         ),
  //                         profileChildWidget(
  //                           '메일',
  //                           'tmdeo2747@gmail.com',
  //                         ),
  //                         profileChildWidget(
  //                           'Git',
  //                           'https://github.com/hsd2747',
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(height: 50),
  //               Row(
  //                 children: [
  //                   SequenceAnimation(
  //                     controller: _controller,
  //                     startInterval: 0.340,
  //                     endInterval: 0.440,
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           'PROFILE',
  //                           style: TextStyle(
  //                             fontSize: 22,
  //                             fontWeight: FontWeight.bold,
  //                             color: CustomTheme.of(context).mainColor,
  //                           ),
  //                         ),
  //                         Container(
  //                           height: 2,
  //                           margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
  //                           color: CustomTheme.of(context).mainColor,
  //                         ),
  //                         profileChildWidget(
  //                           '생년월일',
  //                           '1999년 1월 25일',
  //                         ),
  //                         profileChildWidget(
  //                           '전화번호',
  //                           '010-4145-2757',
  //                         ),
  //                         profileChildWidget(
  //                           '메일',
  //                           'tmdeo2747@gmail.com',
  //                         ),
  //                         profileChildWidget(
  //                           'Git',
  //                           'https://github.com/hsd2747',
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(width: 50),
  //                   SequenceAnimation(
  //                     controller: _controller,
  //                     startInterval: 0.360,
  //                     endInterval: 0.460,
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           'PROFILE',
  //                           style: TextStyle(
  //                             fontSize: 22,
  //                             fontWeight: FontWeight.bold,
  //                             color: CustomTheme.of(context).mainColor,
  //                           ),
  //                         ),
  //                         Container(
  //                           height: 2,
  //                           margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
  //                           color: CustomTheme.of(context).mainColor,
  //                         ),
  //                         profileChildWidget(
  //                           '생년월일',
  //                           '1999년 1월 25일',
  //                         ),
  //                         profileChildWidget(
  //                           '전화번호',
  //                           '010-4145-2757',
  //                         ),
  //                         profileChildWidget(
  //                           '메일',
  //                           'tmdeo2747@gmail.com',
  //                         ),
  //                         profileChildWidget(
  //                           'Git',
  //                           'https://github.com/hsd2747',
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ],
  //       );
  //     },
  //   );

  Widget profileChildWidget(
    String title,
    String text,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: CustomTheme.of(context).mainColorLight50,
            ),
          ),
          SizedBox(width: 20),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: CustomTheme.of(context).subTextColor1,
            ),
          ),
        ],
      ),
    );
  }

  Widget profileImageWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: CustomTheme.of(context).subTextColor4,
                  offset: Offset(3, 3),
                  blurRadius: 7,
                  spreadRadius: 1,
                )
              ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 170,
                    height: 200,
                    decoration: BoxDecoration(
                      color: CustomTheme.of(context).mainColor,
                    ),
                    child: Center(
                      child: Text(
                        '사진',
                        style: TextStyle(
                          color: CustomTheme.of(context).mainTextColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 170,
                    height: 60,
                    decoration: BoxDecoration(
                      color: CustomTheme.of(context).background,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'HAN SEUNG DAE',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: CustomTheme.of(context).mainTextColor,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'CHARMING',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: CustomTheme.of(context).mainTextColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Transform.translate(
                offset: Offset(0, -22),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: CustomTheme.of(context).cardBackground,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
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
    final scrollableBox =
        this.scrollable.context.findRenderObject() as RenderBox;
    final itemBox = this.itemContext.findRenderObject() as RenderBox;
    final itemOffset = itemBox.localToGlobal(
      itemBox.size.centerLeft(Offset.zero),
      ancestor: scrollableBox,
    );

    final viewportDimension = this.scrollable.position.viewportDimension;
    final scrollFraction = (itemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    final itemSize =
        (this.itemKey.currentContext.findRenderObject() as RenderBox).size;
    final listItemSize = context.size;
    final childRect = verticalAlignment.inscribe(
      itemSize,
      Offset.zero & listItemSize,
    );

    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(covariant ParallaxFlowDelegate oldDelegate) {
    return this.scrollable != oldDelegate.scrollable ||
        this.itemContext != oldDelegate.itemContext ||
        this.itemKey != oldDelegate.itemKey;
  }
}
