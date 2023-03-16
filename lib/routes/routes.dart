import 'package:flutter/material.dart';
import 'package:ordering_app/screens/login/login.dart';
import 'package:ordering_app/shared/screens/error_page.dart';

class AppNavigator extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const AppNavigator({required this.routes, required this.naviKey});
  final String routes;
  final GlobalKey<NavigatorState> naviKey;
  @override
  // ignore: library_private_types_in_public_api
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  @override
  Widget build(BuildContext context) {
    print(widget.naviKey);
    String path;
    return Navigator(
      key: widget.naviKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (_) {
              if (settings.name != '/') {
                path = settings.name!;
              } else {
                path = widget.routes;
              }
              switch (path) {
                case 'login':
                  return const LoginForm();
                default:
                  return const ErrorScreen();
              }
            });
      },
    );
  }
}
