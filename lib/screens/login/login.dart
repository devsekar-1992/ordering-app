import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ordering_app/services/auth/auth.dart';
import 'package:ordering_app/shared/layout/view/layout.dart';
import 'package:ordering_app/widgets/g_button.dart';
import 'package:ordering_app/widgets/g_mobileno.dart';
import 'package:ordering_app/widgets/g_password.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool loginState = false;
  String loginMsg = '';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileno = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future login(authData) async {
    try {
      final response = await AuthRequest().login(authData);
      if (kDebugMode) {
        print(response.token);
      }
      setState(() {
        loginState = true;
        loginMsg = '';
      });
      return response.token.toString();
    } catch (e) {
      if (kDebugMode) {
        setState(() {
          loginMsg = e.toString();
          loginState = false;
        });
        return e.toString();
      }
    }
    return '';
  }

  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: GMobileTextField(
                      fieldLabel: 'Mobile No',
                      isObsureText: false,
                      changeFn: (value) {
                        setState(() => {_mobileno.text = value});
                      },
                      onValidate: (value) {
                        if (kDebugMode) {
                          print(value);
                        }
                        if (value == '') {
                          return 'Mobile no is mandatory';
                        }
                        return null;
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: PasswordField(
                    onValidate: (value) {
                      if (value == '') {
                        return 'Password should be filled';
                      }
                    },
                    isObsureText: isHidden,
                    passwordSuffix: InkWell(
                      onTap: () {
                        setState(() {
                          isHidden = !isHidden;
                        });
                      },
                      child: isHidden
                          ? const Icon(
                              Icons.visibility_off,
                              color: Colors.black,
                            )
                          // ignore: dead_code
                          : const Icon(
                              Icons.visibility,
                              color: Colors.black,
                            ),
                    ),
                    fieldLabel: 'Password',
                    changeFn: (value) {
                      setState(() {
                        _password.text = value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevBtn(
                  btnText: 'Login',
                  onPressed: () async {
                    if (kDebugMode) {
                      print(_formKey.currentState!.validate());
                      if (_formKey.currentState!.validate()) {
                        print(_formKey.currentState);
                        await login({
                          'user_name': _mobileno.text,
                          'password': _password.text
                        });
                        print(loginState);
                        if (loginState) {
                          print('Login Successfully');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Layout()));
                        }
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(loginMsg),
                          backgroundColor: Colors.redAccent,
                        ));
                      }
                    }
                  },
                  color: Colors.blue)
            ],
          )),
    );
  }
}
