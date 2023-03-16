import 'package:flutter/material.dart';
import 'package:ordering_app/screens/login/login.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Login Account',
                    style: TextStyle(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Hello,Welcome back to our account',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ]),
          ),
          body: Container(
              padding: const EdgeInsets.all(90.0),
              margin: const EdgeInsets.all(80.0),
              child: const LoginForm()),
        ),
      ),
    );
  }
}
