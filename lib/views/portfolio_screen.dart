import 'package:flutter/material.dart';

import '../components/sequence_animation.dart';

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
      _controller.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    child: profileImageWidget(),
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
                            Text('example text1'),
                            SizedBox(width: 15),
                            Text('example text2'),
                            SizedBox(width: 15),
                            Text('example text3'),
                            SizedBox(width: 15),
                            Text('example text4'),
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
                  color: Colors.grey[400],
                  offset: Offset(2, 2),
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
                      color: Colors.indigo[300],
                    ),
                    child: Center(
                      child: Text('사진'),
                    ),
                  ),
                  Container(
                    width: 170,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'HAN SEUNG DAE',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'CHARMING',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
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
                offset: Offset(0, -15),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.indigoAccent.withOpacity(0.4),
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
