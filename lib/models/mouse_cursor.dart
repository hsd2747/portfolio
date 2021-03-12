import 'package:flutter/material.dart';

class MouseCursorModel extends ChangeNotifier {
  Offset mousePosition = Offset.zero;
  Offset secondPosition = Offset.zero;
  bool hoverButton = false;

  // dispose flag
  bool _isDisposed = false;

  @override
  void dispose() {
    super.dispose();
    this._isDisposed = true;
  }

  void safetyNotifyListeners() {
    if (!this._isDisposed) notifyListeners();
  }

  void changeCursorPoint(Offset position) async {
    this.mousePosition = position;
    safetyNotifyListeners();

    await Future.delayed(Duration(milliseconds: 15));
    this.secondPosition = position;
    safetyNotifyListeners();
  }
}
