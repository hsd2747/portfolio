import 'package:flutter/material.dart';

import 'mock/graph_mock_data.dart';

import 'custom_graph.dart';

import '../../theme/theme_manager.dart';

class SecondProject extends StatefulWidget {
  @override
  _SecondProjectState createState() => _SecondProjectState();
}

class _SecondProjectState extends State<SecondProject> {
  @override
  Widget build(BuildContext context) {
    var graphMockData = GraphMockData(context);

    return Scaffold(
      backgroundColor: CustomTheme.of(context).background,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'secondProject',
                style: TextStyle(
                  color: CustomTheme.of(context).mainTextColor,
                ),
              ),
            ),
            Container(
              height: 350,
              padding: EdgeInsets.only(top: 20),
              child: CustomGraph(
                graphMockData.weekBarGroup,
                graphMockData.weekLabels,
                graphMockData.weekBarTapData,
                animation: true,
                height: 300,
                xDataRepeatCount: 1,
                width: 500,
                margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                curMonth: DateTime.now(),
                popupTapData: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
