import 'package:flutter/material.dart';

import '../../../theme/theme_manager.dart';

class AboutMeWidget extends StatelessWidget {
  AboutMeWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            ),
          ],
        ),
        SizedBox(height: 40),
        Text(
          '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."',
          style: TextStyle(
            fontSize: 14,
            color: CustomTheme.of(context).mainTextColor,
          ),
        )
      ],
    );
  }
}
