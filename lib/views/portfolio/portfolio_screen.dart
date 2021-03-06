import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/mouse_cursor_model.dart';

import '../../components/sequence_animation.dart';
import 'widgets/main_image_widget.dart';
import 'widgets/about_me_widget.dart';

import '../../theme/theme_manager.dart';

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
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
        // Container(
        //   height: 300,
        //   color: CustomTheme.of(context).background,
        // ),
        MainImageWidget(),
        // Container(
        //   height: 70,
        //   color: CustomTheme.of(context).background,
        // ),
        AboutMeWidget(),
        // SizedBox(height: 5000),
      ],
    );
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
  //                   '??? ??? ???',
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
  //                           '????????????',
  //                           '1999??? 1??? 25???',
  //                         ),
  //                         profileChildWidget(
  //                           '????????????',
  //                           '010-4145-2757',
  //                         ),
  //                         profileChildWidget(
  //                           '??????',
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
  //                           '????????????',
  //                           '1999??? 1??? 25???',
  //                         ),
  //                         profileChildWidget(
  //                           '????????????',
  //                           '010-4145-2757',
  //                         ),
  //                         profileChildWidget(
  //                           '??????',
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
  //                           '????????????',
  //                           '1999??? 1??? 25???',
  //                         ),
  //                         profileChildWidget(
  //                           '????????????',
  //                           '010-4145-2757',
  //                         ),
  //                         profileChildWidget(
  //                           '??????',
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
  //                           '????????????',
  //                           '1999??? 1??? 25???',
  //                         ),
  //                         profileChildWidget(
  //                           '????????????',
  //                           '010-4145-2757',
  //                         ),
  //                         profileChildWidget(
  //                           '??????',
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

  // Widget profileChildWidget(
  //   String title,
  //   String text,
  // ) {
  //   return Padding(
  //     padding: EdgeInsets.only(top: 15),
  //     child: Row(
  //       children: [
  //         Text(
  //           title,
  //           style: TextStyle(
  //             fontSize: 14,
  //             color: CustomTheme.of(context).mainColorLight50,
  //           ),
  //         ),
  //         SizedBox(width: 20),
  //         Text(
  //           text,
  //           style: TextStyle(
  //             fontSize: 14,
  //             color: CustomTheme.of(context).subTextColor1,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget profileImageWidget() {
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       Stack(
  //         alignment: Alignment.topCenter,
  //         children: [
  //           Container(
  //             decoration: BoxDecoration(boxShadow: [
  //               BoxShadow(
  //                 color: CustomTheme.of(context).subTextColor4,
  //                 offset: Offset(3, 3),
  //                 blurRadius: 7,
  //                 spreadRadius: 1,
  //               )
  //             ]),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Container(
  //                   width: 170,
  //                   height: 200,
  //                   decoration: BoxDecoration(
  //                     color: CustomTheme.of(context).mainColor,
  //                   ),
  //                   child: Center(
  //                     child: Text(
  //                       '??????',
  //                       style: TextStyle(
  //                         color: CustomTheme.of(context).mainTextColor,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   width: 170,
  //                   height: 60,
  //                   decoration: BoxDecoration(
  //                     color: CustomTheme.of(context).background,
  //                   ),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Text(
  //                         'HAN SEUNG DAE',
  //                         style: TextStyle(
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.bold,
  //                           color: CustomTheme.of(context).mainTextColor,
  //                         ),
  //                       ),
  //                       SizedBox(height: 3),
  //                       Text(
  //                         'CHARMING',
  //                         style: TextStyle(
  //                           fontSize: 14,
  //                           fontWeight: FontWeight.bold,
  //                           color: CustomTheme.of(context).mainTextColor,
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Align(
  //             alignment: Alignment.topCenter,
  //             child: Transform.translate(
  //               offset: Offset(0, -22),
  //               child: Container(
  //                 width: 44,
  //                 height: 44,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(22),
  //                   color: CustomTheme.of(context).cardBackground,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
}
