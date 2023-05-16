import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tool_track/managers/account_manager.dart';
import 'package:tool_track/constants.dart';
import 'package:tool_track/screens/assets_screen.dart';
import 'package:tool_track/components/rect_button.dart';

class RegistrationScreen extends StatelessWidget {
  static const route = 'registration';

  RegistrationScreen({super.key});

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
                  Icons.person_add_alt_1,
                  size: 250.0,
                  color: kPrimaryDarkColor,
                ),
              ),
              RegistrationForm(),
            ]),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Registration'),
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final accountManager = AccountManager();

  String fullname = '';
  String email = '';
  String password = '';

  void registerUser() {}

  void showError(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Full Name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your details';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                fullname = value;
              });
            },
          ),
          SizedBox(
            height: kFormElemetsGap,
          ),
          TextFormField(
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
                text: 'Register',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      EasyLoading.show();
                      await accountManager.register(
                        email: email,
                        password: password,
                        fullname: fullname,
                      );
                      Navigator.pushNamed(context, AssetsScreen.route);
                      EasyLoading.showSuccess('Registered');
                    } on FirebaseAuthException catch (e) {
                      EasyLoading.dismiss();
                      showError(
                          e.message != null ? e.message! : 'Unknown Error');
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
