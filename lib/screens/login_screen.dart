import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tool_track/account_manager.dart';
import 'package:tool_track/components/rect_button.dart';
import 'package:tool_track/constants.dart';
import 'package:tool_track/screens/assets_screen.dart';
import 'package:tool_track/screens/registration_screen.dart';

// TODO: Remove before release
const defaultEmail = 'ivanmel.vn23@gmail.com';
const defaultPassword = '12344321';

class LoginScreen extends StatelessWidget {
  static const route = 'login';

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(24.0),
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 62.0),
                child: Icon(
                  kMainIcon,
                  size: 250.0,
                  color: kPrimaryDarkColor,
                ),
              ),
              LoginForm(),
            ]),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Tool Track'),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final accountManager = AccountManager();

  String email = defaultEmail;
  String password = defaultPassword;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            initialValue: defaultEmail,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
            validator: (value) {
              if (value != null && kEmailValidation.hasMatch(value)) {
                return null;
              }
              return 'Please enter valid email';
            },
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
          ),
          SizedBox(
            height: kFormElemetsGap,
          ),
          TextFormField(
            obscureText: true,
            initialValue: defaultPassword,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
          ),
          SizedBox(
            height: kFormElemetsGap * 2,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RectButton(
                text: 'Login',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      EasyLoading.show();
                      await accountManager.login(
                        email: email,
                        password: password,
                      );
                      Navigator.pushNamed(context, AssetsScreen.route);
                      EasyLoading.showSuccess('Logged in');
                    } on FirebaseAuthException catch (e) {
                      EasyLoading.dismiss();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${e.message}',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  }
                },
                color: kSecondaryColor,
              ),
              SizedBox(
                height: 16.0,
              ),
              RectButton(
                text: 'Register',
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.route);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
