import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tool_track/constants.dart';
import 'package:tool_track/screens/assets_screen.dart';
import 'package:tool_track/components/rect_button.dart';

const double kFormElemetsGap = 16.0;

class RegistrationScreen extends StatelessWidget {
  static const route = 'registration';
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
      appBar: AppBar(
        title: Text('Registration'),
      ),
    );
  }
}

class RegistrationForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

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
          ),
          SizedBox(
            height: kFormElemetsGap,
          ),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
            validator: (value) {
              // TODO: Password validation
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }
              return null;
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Register here
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registering...')),
                    );
                    EasyLoading.show();
                    Navigator.pushNamed(context, AssetsScreen.route);
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
