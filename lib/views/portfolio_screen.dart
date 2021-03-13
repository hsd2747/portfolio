import 'package:flutter/material.dart';

import '../components/sequence_animation.dart';

import '../theme/theme_manager.dart';

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

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
    return Scaffold(
      backgroundColor: CustomTheme.of(context).background,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SequenceAnimation(
                    controller: _controller,
                    startInterval: 0.0,
                    endInterval: 0.100,
                    axis: AnimationAxis.top,
                    child: SizedBox(
                      width: 260,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          profileImageWidget(),
                          SizedBox(height: 20),
                          Text(
                            '한 승 대',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: CustomTheme.of(context).mainColor,
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            '"Lorem ipsum dolor sit amet elit, sed do eiusmod tempor incididunt."',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: CustomTheme.of(context).mainColorLight50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 50),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SequenceAnimation(
                        controller: _controller,
                        startInterval: 0.100,
                        endInterval: 0.200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'example text1',
                              style: TextStyle(
                                color: CustomTheme.of(context).mainTextColor,
                              ),
                            ),
                            SizedBox(width: 15),
                            Text(
                              'example text2',
                              style: TextStyle(
                                color: CustomTheme.of(context).mainTextColor,
                              ),
                            ),
                            SizedBox(width: 15),
                            Text(
                              'example text3',
                              style: TextStyle(
                                color: CustomTheme.of(context).mainTextColor,
                              ),
                            ),
                            SizedBox(width: 15),
                            Text(
                              'example text4',
                              style: TextStyle(
                                color: CustomTheme.of(context).mainTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      SequenceAnimation(
                        controller: _controller,
                        startInterval: 0.200,
                        endInterval: 0.300,
                        child: Column(
                          children: [
                            Text(
                              'You have pushed the button this many times:',
                              style: TextStyle(
                                color: CustomTheme.of(context).mainTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
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
