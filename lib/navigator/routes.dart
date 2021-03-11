class AllRoutes {
  // routes add
  final List<AppRoute> routes = [
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
  String id = 'home';
}

class FirstProjectRoute extends AppRoute {
  @override
  String id = 'firstProject';
}

class UnknownRoute extends AppRoute {
  @override
  String id = 'unknown';
}
