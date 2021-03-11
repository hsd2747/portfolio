import 'package:flutter/material.dart';

import '../main.dart';
import '../views/first_project.dart';
import '../views/unknown_screen.dart';

import 'routes.dart';

class AppRouterDelegate extends RouterDelegate<AppRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoute> {
  AppRoute _curPath;
  bool isUnknown = false;

  AppRoute get currentConfiguration {
    return this._curPath;
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(AppRoute path) async {
    this._curPath = path;
    notifyListeners();
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        _getPage(this._curPath),
      ],
      onPopPage: (route, result) {
        if (!result.didPop(result)) {
          return false;
        }

        this._curPath = null;
        notifyListeners();

        return true;
      },
    );
  }

  MaterialPage _getPage(AppRoute path) {
    if (path == null)
      return MaterialPage(
        key: ValueKey('home'),
        child: MainPage(),
      );

    if (path.id == 'firstProject') {
      return MaterialPage(
        key: ValueKey('firstProject'),
        child: FirstProject(),
      );
    } else if (path.id == 'home') {
      return MaterialPage(
        key: ValueKey('home'),
        child: MainPage(),
      );
    }

    return MaterialPage(
      key: ValueKey('unknown'),
      child: UnknownScreen(),
    );
  }

  void changePage(AppRoute path) {
    this._curPath = path;
    notifyListeners();
  }
}
