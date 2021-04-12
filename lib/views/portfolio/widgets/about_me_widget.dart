import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../components/sequence_animation.dart';

import '../../../theme/theme_manager.dart';

class AboutMeWidget extends StatefulWidget {
  @override
  _AboutMeWidgetState createState() => _AboutMeWidgetState();
}

class _AboutMeWidgetState extends State<AboutMeWidget>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController _controller;

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
        milliseconds: 4000,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return VisibilityDetector(
      key: ValueKey('aboutMeKey'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction < 0.6) return;

        if (_controller.isDismissed) {
          if (mounted) _controller.forward();
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ABOUT ME',
                  style: TextStyle(
                    color: CustomTheme.of(context).subTextColor1,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SequenceAnimation(
                      controller: _controller,
                      startInterval: 0.0,
                      endInterval: 0.2,
                      child: Container(
                        width: 240,
                        height: 240,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(120),
                          color: CustomTheme.of(context).lightBackground,
                        ),
                        child: Center(
                          child: Text('사진'),
                        ),
                      ),
                    ),
                    SizedBox(width: 80),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SequenceAnimation(
                          startInterval: 0.20,
                          endInterval: 0.30,
                          axis: AnimationAxis.right,
                          controller: _controller,
                          child: introduceText('MY NAME', '한승대'),
                        ),
                        SizedBox(height: 40),
                        SequenceAnimation(
                          startInterval: 0.24,
                          endInterval: 0.34,
                          axis: AnimationAxis.right,
                          controller: _controller,
                          child: introduceText('BIRTHDAY', '1999 . 01 . 25'),
                        ),
                        SizedBox(height: 40),
                        SequenceAnimation(
                          startInterval: 0.28,
                          endInterval: 0.38,
                          axis: AnimationAxis.right,
                          controller: _controller,
                          child: introduceText('CONTACTS', '010.4145.2757'),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40),
                SequenceAnimation(
                  startInterval: 0.35,
                  endInterval: 0.55,
                  controller: _controller,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 600,
                      minWidth: 600,
                    ),
                    child: Text(
                      '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."',
                      style: TextStyle(
                        fontSize: 14,
                        color: CustomTheme.of(context).mainTextColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                SequenceAnimation(
                  startInterval: 0.55,
                  endInterval: 0.75,
                  controller: _controller,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 600,
                      minWidth: 600,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MY LIKES',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: CustomTheme.of(context).mainTextColor,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(5, (index) {
                            return Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: CustomTheme.of(context).lightBackground,
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget introduceText(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: CustomTheme.of(context).mainTextColor,
          ),
        ),
        SizedBox(height: 5),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            color: CustomTheme.of(context).subTextColor2,
          ),
        ),
      ],
    );
  }
}
