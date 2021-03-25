import 'dart:ui';

import 'package:flutter/material.dart';

import '../main.dart';
import '../views/custom_cursor_wrap.dart';
import '../views/main_menu_screen.dart';
import '../views/portfolio_screen.dart';
import '../views/first_project/first_project.dart';
import '../views/second_project/second_project.dart';
import '../views/third_project/third_project.dart';

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

  Page _getPage(AppRoute path) {
    if (path == null)
      return AnimatedPage(
        key: ValueKey('main'),
        child: MainMenuScreen(),
      );

    if (path.id == 'portfolio') {
      return AnimatedPage(
        key: ValueKey('portfolio'),
        child: PortfolioScreen(),
      );
    } else if (path.id == 'firstProject') {
      return AnimatedPage(
        key: ValueKey('firstProject'),
        child: FirstProject(),
      );
    } else if (path.id == 'secondProject') {
      return AnimatedPage(
        key: ValueKey('secondProject'),
        child: SecondProject(),
      );
    } else if (path.id == 'thirdProject') {
      return AnimatedPage(
        key: ValueKey('thirdProject'),
        child: ThirdProject(),
      );
    } else if (path.id == '') {
      return AnimatedPage(
        key: ValueKey('main'),
        child: MainMenuScreen(),
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

class AnimatedPage extends Page {
  final Widget child;

  AnimatedPage({Key key, this.child}) : super(key: key);

  Route createRoute(BuildContext context) {
    return AnimatedPageRoute(
      builder: (context) => CustomCursorWrap(
        child: child,
      ),
      settings: this,
    );
  }
}

class AnimatedPageRoute extends MaterialPageRoute {
  AnimatedPageRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    var begin = Offset(1.0, 0.0);
    var end = Offset.zero;
    var tween = Tween(begin: begin, end: end).chain(
      CurveTween(
        curve: Curves.easeInOutBack,
      ),
    );

    var offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
