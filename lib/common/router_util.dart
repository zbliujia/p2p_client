import 'package:flutter/material.dart';

class RouterUtil {
  static String? currentRouter = "/";

  static RouteObserver<ModalRoute> routeObserver = MyNavigatorObserver();

}

class MyNavigatorObserver extends RouteObserver<ModalRoute> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    RouterUtil.currentRouter = route.settings.name;
    super.didPush(route, previousRoute);
    debugPrint(
        "RouterUtil didPush: route: ${route.settings.name}  previousRoute: ${previousRoute?.settings.name} ");
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    RouterUtil.currentRouter = previousRoute?.settings.name;
    super.didPop(route, previousRoute);
    debugPrint(
        "RouterUtil didPop route: ${route.settings.name} previousRoute: ${previousRoute?.settings.name} ");
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    debugPrint("didRemove: ${route.settings.name}");
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    debugPrint("didReplace: ${newRoute?.settings.name}");
  }
}
