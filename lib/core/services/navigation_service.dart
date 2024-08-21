import '/index.dart';

class NavigationService {
  // create the navigator key
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // use the navigator key to push routes
  Future<dynamic> toNamed(String routeName, {Object? arguments}) =>
      navigatorKey.currentState!.pushNamed(
        routeName,
        
        arguments: arguments,
      );

  // use the navigator key to push routes
  Future<dynamic> toNamedAndRemoveUntil(
    String routeName, {
    Object? arguments,
  }) =>
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName,
        
        arguments: arguments,
        
        (route) => false,
      );

  // use the navigator key to push routes
  Future<dynamic> to(Widget routeName, {Object? arguments}) =>
      navigatorKey.currentState!.push(
        MaterialPageRoute<void>(

          builder: (BuildContext context) => routeName,
          settings: RouteSettings(arguments: arguments),
        ),
      );
  // use the navigator key to push routes
  Future<dynamic> popAndPushNamed(String routeName) =>
      navigatorKey.currentState!.popAndPushNamed(routeName);

  Future<dynamic> pushAndRemoveUntil(String routeName, Widget routePage) =>
      navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (BuildContext context) => routePage),
        ModalRoute.withName(routeName),
      );

  void pop() =>
      navigatorKey.currentState!.pop(); // use the navigator key to pop routes

  bool canPop() => navigatorKey.currentState!.canPop();
}
