import 'package:flutter/material.dart';
import 'package:ordering_app/screens/login/login_view.dart';
import 'package:ordering_app/services/auth/auth.dart';
import 'package:ordering_app/shared/layout/view/layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isAuthenticate = await AuthRequest().isAuthenticated();
  print(isAuthenticate);
  runApp(MyApp(auth: isAuthenticate));
}

class MyApp extends StatelessWidget {
  final bool auth;
  const MyApp({super.key, required this.auth});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop Order',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: (auth) ? const Layout() : const LoginView(),
    );
  }
}
