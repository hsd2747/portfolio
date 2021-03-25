class AllRoutes {
  // routes add
  final List<AppRoute> routes = [
    PortfolioRoute(),
    HomeRoute(),
    FirstProjectRoute(),
    SecondProjectRoute(),
    ThirdProjectRoute(),
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

class SecondProjectRoute extends AppRoute {
  @override
  String id = 'secondProject';
}

class ThirdProjectRoute extends AppRoute {
  @override
  String id = 'thirdProject';
}

class UnknownRoute extends AppRoute {
  @override
  String id = 'unknown';
}
