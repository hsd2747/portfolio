import 'package:flutter/material.dart';

import 'routes.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRoute> {
  @override
  Future<AppRoute> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.length == 0) {
      return HomeRoute();
    }

    if (uri.pathSegments.length == 1) {
      var routes = AllRoutes().routes;

      for (var route in routes) {
        if (route.id == uri.pathSegments[0]) {
          return route;
        }
      }
    }

    return UnknownRoute();
  }

  @override
  RouteInformation restoreRouteInformation(AppRoute path) {
    if (path is UnknownRoute) {
      return RouteInformation(location: '/404');
    }

    if (path.id != null) {
      return RouteInformation(location: '/${path.id}');
    }

    return null;
  }
}
