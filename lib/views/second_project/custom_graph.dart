import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class BarGroup {
  List<BarType> barType;

  BarGroup(this.barType);
}

class BarType {
  double value;
  Color barColor;
  String name;

  BarType(this.value, this.barColor, {this.name});
}

class BarTapData {
  DateTime goWorkTime;
  DateTime goHomeTime;

  BarTapData(this.goWorkTime, this.goHomeTime);
}

List<Offset> coordinates;

class CustomGraph extends StatefulWidget {
  final List<BarGroup> barGroup;
  final List<DateTime> labels;
  final List<BarTapData> barTapData;
  final double width;
  final double height;
  final int yDataViewCount;
  final int xDataRepeatCount;
  final bool animation;
  final EdgeInsets margin;
  final DateTime curMonth;
  final bool popupTapData;

  CustomGraph(
    this.barGroup,
    this.labels,
    this.barTapData, {
    this.width,
    this.height,
    this.yDataViewCount = 6,
    this.xDataRepeatCount = 1,
    this.animation = true,
    this.margin,
    this.curMonth,
    this.popupTapData = true,
  });

  @override
  _CustomGraphState createState() => _CustomGraphState();
}

class _CustomGraphState extends State<CustomGraph>
    with TickerProviderStateMixin {
  AnimationController animationController;
  AnimationController animationController2;
  Animation animation;
  Animation animation2;

  double bottomPadding = 0;
  double leftPadding = 0;

  int tapPosition = -1;
  double positionLeft = 0;
  bool useLeft = true;
  double positionRight = 0;
  double barLeft = 0;

  BoxConstraints boxConstraints;
  Offset localOffset;

  String workStartString;
  String workEndString;

  bool beforeTap = false;

  @override
  void dispose() {
    animationController.dispose();
    animationController2.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // Workmanager.initialize(
    //   callbackDispatcher,
    //   isInDebugMode: true
    // );

    // Workmanager.registerOneOffTask(
    //   "1",
    //   "simpleTask",
    //   // backoffPolicy: BackoffPolicy.exponential
    //   initialDelay: Duration(seconds: 20)
    // );

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    animationController2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.ease,
    ));

    animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController2, curve: Curves.elasticOut));

    if (widget.animation) {
      animationController.reset();
      animationController.forward();
    } else
      animationController.value = 1.0;

    // animationController2.forward();

    Size size = Size(widget?.width ?? 0, widget?.height ?? 0);

    bottomPadding = size.height / 10;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // barGroup.clear();

    // barGroup.add(BarGroup(barType1));
    // barGroup.add(BarGroup(barType2));
    // barGroup.add(BarGroup(barType3));
    // barGroup.add(BarGroup(barType4));
    // barGroup.add(BarGroup(barType5));
    // barGroup.add(BarGroup(barType6));
    // barGroup.add(BarGroup(barType7));
    // for (int i = 0; i < 24; i++)
    //   barGroup.add(BarGroup(barType1));

    // labels.clear();
    // for ( int i = 0; i < 31; i++)
    //   labels.add('${i + 1}');

    if (!beforeTap) {
      animationController2.reset();
      tapPosition = -1;

      if (widget.popupTapData) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          // double barWidthMargin = ((size.width - 20) / coordinates.length);
          if ((coordinates?.length ?? 0) > 0) {
            Size size2 = Size(
                boxConstraints?.maxWidth ?? 0, boxConstraints?.maxHeight ?? 0);

            Offset offset = coordinates[0];
            double left = offset.dx + (size2.width / coordinates.length / 3);
            // double right = offset.dx + barWidthMargin; // 간격만큼 가로로 이동

            localOffset = Offset(left + 1, 1);
            if (mounted) taskTapGraph();
          }
        });
      }
    }

    beforeTap = false;

    workStringGenerate(tapPosition);

    TextSpan span = TextSpan(
      style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600),
      text: 'temp',
    );

    TextPainter tp = TextPainter(
        text: span, textDirection: TextDirection.ltr, textScaleFactor: 1.0);
    tp.layout();

    return LayoutBuilder(
      builder: (context, constraints) {
        boxConstraints = constraints;

        return Padding(
            padding: widget?.margin ?? EdgeInsets.all(0),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: useLeft ? positionLeft : null,
                  right: useLeft ? null : positionRight,
                  child: AnimatedBuilder(
                      animation: animation2,
                      builder: (context, _) {
                        return Transform.scale(
                            scale: animation2.value,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(158, 158, 158, 1.0),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(workStartString,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                          textScaleFactor: 1.0),
                                      Text(workEndString,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                          textScaleFactor: 1.0)
                                    ],
                                  ),
                                ),
                                // CustomPaint(
                                //   size: Size(10, 6),
                                //   painter: TrianglePainter(
                                //     Color.fromRGBO(158, 158, 158, 1.0),
                                //   )
                                // ),
                              ],
                            ));
                      }),
                ),
                Positioned(
                    left: barLeft,
                    top: (tp.height * 2) + 9.5,
                    child: AnimatedBuilder(
                        animation: animation2,
                        builder: (context, _) {
                          return Transform.scale(
                            scale: animation2.value,
                            child: CustomPaint(
                              size: Size(10, 6),
                              painter: TrianglePainter(
                                Color.fromRGBO(158, 158, 158, 1.0),
                              ),
                            ),
                          );
                        })),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  // onHorizontalDragUpdate: (details){
                  //   if (widget.popupTapData){
                  //     localOffset = details.localPosition;
                  //     taskTapGraph();
                  //   }
                  // },
                  onTapDown: (details) {
                    if (widget.popupTapData) {
                      localOffset = details.localPosition;
                      taskTapGraph();
                    }
                  },
                  child: AnimatedBuilder(
                    animation: animation,
                    builder: (context, _) {
                      return Padding(
                        padding: widget.popupTapData
                            ? EdgeInsets.only(top: 52)
                            : EdgeInsets.zero,
                        child: CustomPaint(
                          size: Size(widget?.width ?? 0, widget?.height ?? 0),
                          foregroundPainter: BarChart(
                            data: widget.barGroup,
                            labels: widget.labels,
                            //color: Color.fromRGBO(74, 94, 163, 1.0),
                            yDataViewCount: widget.yDataViewCount,
                            xDataRepeatCount: widget.xDataRepeatCount,
                            animationValue: animation.value,
                            curMonth: widget.curMonth, //DateTime(2020, 3),
                            context: context,
                          ),
                        ), // color - 막대 그래프의 색깔
                      );
                    },
                  ),
                )
              ],
            ));
      },
    );
  }

  void taskTapGraph() {
    // print(details);
    Size size =
        Size(boxConstraints?.maxWidth ?? 0, boxConstraints?.maxHeight ?? 0);

    double barWidthMargin = ((size.width - 20) / coordinates.length);

    for (int i = 0; i < coordinates.length; i++) {
      Offset offset = coordinates[i];
      double left = offset.dx + (size.width / coordinates.length / 3);
      double right = offset.dx + barWidthMargin; // 간격만큼 가로로 이동

      Rect rect = Rect.fromLTRB(left, 0, right, size.height - bottomPadding);

      if (rect.contains(localOffset)) {
        if (i != tapPosition) {
          print('$i');

          animationController2.reset();
          animationController2.forward();

          setState(() {
            beforeTap = true;
            tapPosition = i;
            positionLeft = left - 35;
            if (positionLeft < 0) positionLeft = 0;

            positionRight = 0;
            barLeft = left + ((right - left) / 2) - 7.5;

            workStringGenerate(tapPosition);

            String longerText = workStartString.length > workEndString.length
                ? workStartString
                : workEndString;

            TextSpan span = TextSpan(
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
              ),
              text: longerText,
            );

            TextPainter tp =
                TextPainter(text: span, textDirection: TextDirection.ltr);

            tp.layout();

            if ((coordinates.last.dx + barWidthMargin) >
                (positionLeft + tp.width + 20))
              useLeft = true;
            else
              useLeft = false;
            //  (i == (coordinates.length - 1))
          });
        }
      }
    }
  }

  void workStringGenerate(int position) {
    workStartString = '출근';
    workEndString = '퇴근';

    if (position == -1) return;

    if (widget.barTapData[position].goWorkTime != null) {
      workStartString = '출근' +
          ' : ' +
          intl.DateFormat(
            'aa hh:mm',
          ).format(
            widget.barTapData[position].goWorkTime,
          );
    }
    if (widget.barTapData[position].goHomeTime != null) {
      workEndString = '퇴근' +
          ' : ' +
          intl.DateFormat(
            'aa hh:mm',
          ).format(
            widget.barTapData[position].goHomeTime,
          );
    }
  }
}

class BarChart extends CustomPainter {
  double textScaleFactorXAxis = 1.0; // x축 텍스트의 비율을 정함.
  double textScaleFactorYAxis = 1.0; // y축 텍스트의 비율을 정함.

  // List<double> data = [];
  List<BarGroup> data = [];
  List<DateTime> labels = [];
  double bottomPadding = 0.0;
  double leftPadding = 0.0;
  double animationValue;
  int yDataViewCount;
  int xDataRepeatCount;
  DateTime curMonth;
  BuildContext context;

  BarChart(
      {this.data,
      this.labels,
      this.yDataViewCount = 5,
      this.xDataRepeatCount = 1,
      this.animationValue,
      this.curMonth,
      this.context});

  @override
  void paint(Canvas canvas, Size size) {
    setTextPadding(size); // 텍스트를 공간을 미리 정함.

    coordinates = getCoordinates(size);

    drawXLabels(canvas, size, coordinates);
    drawYLabels(canvas, size, coordinates);
    drawBar(canvas, size, coordinates);
    // drawLines(canvas, size, coordinates);
  }

  void setTextPadding(Size size) {
    bottomPadding = size.height / 10; // 세로 크기의 1/10만큼만 텍스트 패딩을 줌
    // leftPadding = size.width / 14; // 가로 길이의 1/10만큼 텍스트 패딩을 줌
    double maxValue = findMaxData();

    TextSpan span = TextSpan(
      style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600),
      text: maxValue >= 6
          ? maxValue.ceil().toString() + 'h'
          : maxValue.toStringAsFixed(1) + 'h',
    );

    TextPainter tp = TextPainter(
        text: span, textDirection: TextDirection.ltr, textScaleFactor: 1.0);

    tp.layout();
    leftPadding = tp.width;
  }

  void drawBar(Canvas canvas, Size size, List<Offset> coordinates) {
    // 막대 그래프가 겹치지 않게 간격을 줌.
    // 계산법 - (전체 너비 - 20) / 데이터 값의 갯수
    double barWidthMargin = ((size.width - 20) / coordinates.length);

    for (var index = 0; index < coordinates.length; index++) {
      double totalSize = 0;
      // 하나의 데이터값을 모두 더함
      for (int j = 0; j < data[index].barType.length; j++) {
        if (data[index].barType[j].value <= 0) continue;

        totalSize += data[index].barType[j].value;
      }

      // Bar 뒷 회색 배경 그리기
      Paint paint = Paint()
        ..color = Color.fromRGBO(238, 238, 238, 1.0)
        ..style = PaintingStyle.fill
        ..strokeCap = StrokeCap.butt;

      Offset offset = coordinates[index];
      double left = offset.dx + (size.width / coordinates.length / 3);
      double right = offset.dx + barWidthMargin; // 간격만큼 가로로 이동

      Rect rect = Rect.fromLTRB(right, 0, left, size.height - bottomPadding);

      canvas.drawRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(4)), paint);

      bool firstTopTotal = true;
      double topTotal = 0;
      List<Rect> listRect = List();
      List<Paint> listPaint = List();
      for (int j = 0; j < data[index].barType.length; j++) {
        // for (int j = (data[index].barType.length - 1); j >= 0; j--){
        if (data[index].barType[j].value <= 0) continue;

        Paint paint = Paint()
          ..color = data[index].barType[j].barColor
          ..style = PaintingStyle.fill
          ..strokeCap = StrokeCap.butt;

        Offset offset = coordinates[index];

        // 막대 그래프가 그려지는 범위의 최대크기 계산
        double barMaxHeight = size.height - bottomPadding;
        // 모든 데이터의 최대값 가져오기
        double maxValue = findMaxData(); // data[indexOfMax];
        // 최대값 여유 공간을 위해 값을 올림
        double viewMaxValue = maxValue.ceil().toDouble();

        // 빈공간 값
        double blankValue =
            (barMaxHeight * ((viewMaxValue - maxValue) / viewMaxValue));
        // 값을 올린만큼 최대길이 빈공간을 제거함
        barMaxHeight -= blankValue;

        // 그래프 값에 따라 따로 계산하기위해 값 한개짜리를 구함
        double oneSize = 0;
        if (totalSize != 0) oneSize = (barMaxHeight - offset.dy) / totalSize;

        if (firstTopTotal) topTotal = oneSize * totalSize;

        // 애니메이션 처리를 위해 사이즈 처리
        oneSize *= animationValue;

        double left = offset.dx + (size.width / coordinates.length / 3);
        double right = offset.dx + barWidthMargin; // 간격만큼 가로로 이동

        // (((size.height - bottomPadding) - (offset.dy + topTotal)) * (1 - animationValue))
        double bottom = offset.dy +
            topTotal +
            blankValue; //bottom - (oneSize * data[index].barType[j].value);// bottom - (oneSize * data[index].barType[j].value) - 4;   // offset.dy + topTotal;
        topTotal -= (oneSize * data[index].barType[j].value);

        double top = bottom -
            (oneSize *
                data[index]
                    .barType[j]
                    .value); //offset.dy + topTotal + blankValue;// (size.height - bottomPadding) - topTotal + 4;   //top + (oneSize * data[index].barType[j].value); // 텍스트 크기만큼 패딩을 빼줘서, 텍스트와 겹치지 않게 함.

        // round 처리 빈공간 제거
        if (!firstTopTotal) bottom += 5;

        // print('$index $j topTotal: ${topTotal}  top: $top, bottom: $bottom');

        Rect rect = Rect.fromLTRB(right, top, left, bottom);

        listRect.add(rect);
        listPaint.add(paint);

        firstTopTotal = false;
      }

      for (int j = (listRect.length - 1); j >= 0; j--)
        canvas.drawRRect(
            RRect.fromRectAndRadius(listRect[j], Radius.circular(4)),
            listPaint[j]);
    }
  }

  // X축 텍스트(레이블)을 그림.
  void drawXLabels(Canvas canvas, Size size, List<Offset> coordinates) {
    double fontSize =
        14; //calculateFontSize(labels[0], size, xAxis: true); // 화면 크기에 유동적으로 폰트 크기를 계산함.

    int count = xDataRepeatCount;
    for (int index = 0; index < labels.length; index++) {
      if (count % xDataRepeatCount == 0 ||
          index == 0 ||
          (index + 1) == labels.length) {
        for (int j = 0; j < 2; j++) {
          TextSpan span = TextSpan(
              style: TextStyle(
                color: labels[index].weekday == 7
                    ? Color.fromRGBO(255, 116, 116, 1.0)
                    : Color.fromRGBO(66, 66, 66, 1.0),
                fontSize: fontSize,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
              text: j == 0
                  ? curMonth.month != labels[index].month
                      ? intl.DateFormat('M.dd').format(labels[index])
                      : intl.DateFormat('d').format(labels[index])
                  : intl.DateFormat(
                      'EEE',
                    ).format(
                      labels[index],
                    ));

          Paint paint = Paint()
            ..color = Colors.grey[600]
            ..strokeCap = StrokeCap.butt
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2;

          TextPainter tp =
              TextPainter(text: span, textDirection: TextDirection.ltr);
          tp.layout();

          Offset offset = coordinates[index];

          // 글씨 가운데 맞추는 좌표 구하기
          double dxLeft = offset.dx + (size.width / coordinates.length / 3);
          double dxRight = offset.dx + ((size.width - 20) / coordinates.length);

          double dx = dxLeft +
              ((dxRight - dxLeft) / 2) -
              (tp.width /
                  2); //offset.dx + ((size.width - 20) / coordinates.length / 3);//10.0 + 8;
          double dy = size.height - tp.height;

          // 글씨 위쪽 가운데 기준선 좌표 구하기
          double dxCenter = dxLeft + ((dxRight - dxLeft) / 2);
          double dyBottom = size.height - bottomPadding + 5;

          // 기준선 그리기
          // Path path = Path();
          // path.moveTo(dxCenter, dyBottom);
          // path.lineTo(dxCenter, dyBottom + 3);

          // canvas.drawPath(path, paint);

          // 글씨 그리기
          tp.paint(canvas, Offset(dx, j == 0 ? dy : dy + 30));
        }
      }
      count++;
    }
  }

  // Y축 텍스트(레이블)을 그림. 최저값과 최고값을 Y축에 표시함.
  void drawYLabels(Canvas canvas, Size size, List<Offset> coordinates) {
    double bottomY = coordinates[0].dy;
    double topY = coordinates[0].dy;
    int indexOfMax = 0;
    int indexOfMin = 0;

    for (int index = 0; index < coordinates.length; index++) {
      double dy = coordinates[index].dy;

      if (bottomY < dy) {
        bottomY = dy;
        indexOfMin = index;
      }

      if (topY > dy) {
        topY = dy;
        indexOfMax = index;
      }
    }

    // double barMaxHeight = topY - bottomY;

    double maxValue = findMaxData(); // data[indexOfMax];
    double viewMaxValue = maxValue.ceil().toDouble();

    double barMaxHeight = size.height - bottomPadding;
    // barMaxHeight -= (barMaxHeight * (viewMaxValue - maxValue));
    double barDivideFive = barMaxHeight / (yDataViewCount - 1);

    // double maxValueDivideFive = maxValue / (yDataViewCount - 1);
    double viewMaxValueDivideFive = viewMaxValue / (yDataViewCount - 1);

    String maxValueString = "${maxValue.toInt()}";
    // String minValue = "${data[indexOfMin].toInt()}";

    double fontSize =
        12; //calculateFontSize(maxValueString, size, xAxis: false);

    // drawYText(canvas, maxValue, fontSize, topY);
    for (int i = 0; i < yDataViewCount; i++) {
      double drawY = barMaxHeight - (barDivideFive * i);
      double value = viewMaxValueDivideFive * i;

      String valueString;
      if (maxValue >= 6)
        valueString = "${value.toInt()}h";
      else
        valueString = "${value.toStringAsFixed(1)}h";

      drawYText(canvas, valueString, fontSize, drawY - 7);
      //drawYLine(canvas, size, drawY, coordinates);
    }

    // drawYText(canvas, minValue, fontSize, bottomY);
  }

  // 화면 크기에 비례해 폰트 크기를 계산.
  double calculateFontSize(String value, Size size, {bool xAxis}) {
    // int numberOfCharacters = value.length; // 글자수에 따라 폰트 크기를 계산하기 위함.
    double fontSize = min(((size.width - 20) / data.length),
        14); // width가 600일 때 100글자를 적어야 한다면, fontSize는 글자 하나당 6이어야겠죠.

    // if (xAxis) {
    //   fontSize *= textScaleFactorXAxis;
    // } else {
    //   fontSize *= textScaleFactorYAxis;
    // }

    return 13; //fontSize;
  }

  // y축을 구분하는 세부 선을 긋습니다.
  void drawYLine(
      Canvas canvas, Size size, double height, List<Offset> coordinates) {
    Paint paint = Paint()
      ..color = Colors.grey[400]
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // double bottom = size.height - bottomPadding;
    double left = coordinates[0].dx;

    Path path = Path();
    path.moveTo(left, height);
    // path.lineTo(left, bottom);
    path.lineTo(size.width, height);

    canvas.drawPath(path, paint);
  }

  // x축과 y축을 구분하는 선을 긋습니다.
  void drawLines(Canvas canvas, Size size, List<Offset> coordinates) {
    Paint paint = Paint()
      ..color = Colors.grey[600]
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    double bottom = size.height - bottomPadding;
    double left = coordinates[0].dx;

    Path path = Path();
    path.moveTo(left, 0);
    path.moveTo(left, bottom);
    path.lineTo(size.width, bottom);

    canvas.drawPath(path, paint);
  }

  void drawYText(Canvas canvas, String text, double fontSize, double y) {
    TextSpan span = TextSpan(
      style: TextStyle(
          fontSize: fontSize,
          color: Color.fromRGBO(189, 189, 189, 1.0),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400),
      text: text,
    );

    TextPainter tp = TextPainter(text: span, textDirection: TextDirection.ltr);

    tp.layout();

    Offset offset = Offset(leftPadding - 5 - tp.width, y);
    tp.paint(canvas, offset);
  }

  List<Offset> getCoordinates(Size size) {
    List<Offset> coordinates = [];

    double maxData = findMaxData(); //data.reduce(max);

    double width = size.width - leftPadding;
    double minBarWidth = ((width - (size.width / data.length / 3)) /
        data.length); //width / data.length;

    for (var index = 0; index < data.length; index++) {
      double curValue = 0;
      for (int j = 0; j < data[index].barType.length; j++) {
        if (data[index].barType[j].value <= 0) continue;

        curValue += data[index].barType[j].value;
      }
      // 막대 그래프가 그려지는 범위의 최대크기 계산
      double barMaxHeight = size.height - bottomPadding;
      // 최대값 여유 공간을 위해 값을 올림
      double viewMaxValue = maxData.ceil().toDouble();

      // 빈공간 값
      double blankValue =
          (barMaxHeight * ((viewMaxValue - maxData) / viewMaxValue));

      double left = minBarWidth * (index) + leftPadding; // 그래프의 가로 위치를 정합니다.
      double normalized = curValue / maxData; // 그래프의 높이가 [0~1] 사이가 되도록 정규화 합니다.
      double height =
          (barMaxHeight - blankValue); // x축에 표시되는 글자들과 겹치지 않게 높이에서 패딩을 제외합니다.
      double top = height - normalized * height; // 정규화된 값을 통해 높이를 구해줍니다.

      Offset offset = Offset(left, top);
      coordinates.add(offset);
    }

    return coordinates;
  }

  double findMaxData() {
    double maxValue = 0;
    for (int i = 0; i < data.length; i++) {
      double curValue = 0;
      for (int j = 0; j < data[i].barType.length; j++) {
        curValue += data[i].barType[j].value;
      }

      if (maxValue < curValue) maxValue = curValue;
    }

    return maxValue;
  }

  @override
  bool shouldRepaint(BarChart old) {
    if (old.animationValue != animationValue) return true;

    return old.data != data;
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;

    var path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
