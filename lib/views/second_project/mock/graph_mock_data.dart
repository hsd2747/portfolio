import 'package:flutter/material.dart';

import '../custom_graph.dart';

import '../../../theme/theme_manager.dart';

class GraphMockData {
  List<BarGroup> weekBarGroup = [];
  List<BarGroup> monthBarGroup = [];

  List<DateTime> weekLabels = [];
  List<DateTime> monthLabels = [];

  List<BarTapData> weekBarTapData = [];
  List<BarTapData> monthBarTapData = [];

  GraphMockData(BuildContext context) {
    this._createWeekData(context);
  }

  void _createWeekData(BuildContext context) {
    this._createWeekBarGroup(context);
    this._createWeekLabel();
    this._createWeekTapBar();
  }

  void _createWeekBarGroup(BuildContext context) {
    List<BarType> weekBarType = [];

    // 월
    weekBarType.add(BarType(
      9,
      CustomTheme.of(context).mainColor,
    ));
    weekBarType = [];
    this.weekBarGroup.add(BarGroup(weekBarType));

    // 화
    weekBarType.add(BarType(
      4,
      Color.fromRGBO(255, 123, 93, 1.0),
    ));

    weekBarType.add(BarType(
      4,
      CustomTheme.of(context).mainColor,
    ));

    weekBarType.add(BarType(0.7, Color.fromRGBO(41, 55, 102, 1.0)));
    weekBarType = [];
    this.weekBarGroup.add(BarGroup(weekBarType));

    // 수
    weekBarType.add(BarType(
      9,
      CustomTheme.of(context).mainColor,
    ));
    weekBarType = [];
    this.weekBarGroup.add(BarGroup(weekBarType));

    // 목
    weekBarType.add(BarType(
      9,
      CustomTheme.of(context).mainColor,
    ));
    weekBarType = [];
    this.weekBarGroup.add(BarGroup(weekBarType));

    // 금
    weekBarType.add(BarType(
      9,
      CustomTheme.of(context).mainColor,
    ));
    weekBarType = [];
    this.weekBarGroup.add(BarGroup(weekBarType));

    // 토
    weekBarType.add(BarType(
      9,
      CustomTheme.of(context).mainColor,
    ));
    weekBarType = [];
    this.weekBarGroup.add(BarGroup(weekBarType));

    // 일
    weekBarType.add(BarType(
      9,
      CustomTheme.of(context).mainColor,
    ));
    weekBarType = [];
    this.weekBarGroup.add(BarGroup(weekBarType));
  }

  void _createWeekLabel() {
    var now = DateTime.now();

    DateTime firstWeekday = now.subtract(Duration(days: now.weekday));

    for (int i = 0; i < 7; i++) {
      this.weekLabels.add(
            firstWeekday.add(Duration(
              days: i,
            )),
          );
    }
  }

  void _createWeekTapBar() {
    for (int i = 0; i < 7; i++) {
      this.weekBarTapData.add(
            BarTapData(
              DateTime.now(),
              DateTime.now().add(
                Duration(hours: 8),
              ),
            ),
          );
    }
  }
}
