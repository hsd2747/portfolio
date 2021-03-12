class AllRoutes {
  // routes add
  final List<AppRoute> routes = [
    PortfolioRoute(),
    HomeRoute(),
    FirstProjectRoute(),
    UnknownRoute(),
  ];
}

abstract class AppRoute {
  String id;
}

class HomeRoute extends AppRoute {
  @override
  String id = '';
}

class PortfolioRoute extends AppRoute {
  @override
  String id = 'portfolio';
}

class FirstProjectRoute extends AppRoute {
  @override
  String id = 'firstProject';
}

class UnknownRoute extends AppRoute {
  @override
  String id = 'unknown';
}
