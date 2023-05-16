import 'package:flutter/material.dart';
import 'package:tool_track/constants.dart';
import 'package:tool_track/screens/assets_screen.dart';

const double kFormElemetsGap = 16.0;

class LoginScreen extends StatelessWidget {
  static const route = 'login';
  const LoginScreen({super.key});

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
                Icons.handyman_rounded,
                size: 250.0,
              ),
            ),
            LoginForm(),
          ]),
        ),
      ),
      appBar: AppBar(
        title: Text('Tool Track'),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
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
              labelText: 'Email',
            ),
            validator: (value) {
              // TODO: Email validation
              if (value == null || value.isEmpty) {
                return 'Please enter email';
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
              FormButton(
                formKey: _formKey,
                text: 'Login',
                onPressed: () {
                  // TODO: Login here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logging in...')),
                  );
                  Navigator.pushNamed(context, AssetsScreen.route);
                },
                color: kSecondaryColor,
              ),
              SizedBox(
                height: 16.0,
              ),
              FormButton(
                formKey: _formKey,
                text: 'Register',
                onPressed: () {
                  // TODO: Register here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Registering...')),
                  );
                  Navigator.pushNamed(context, AssetsScreen.route);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.text,
    required this.onPressed,
    this.color = kPrimaryColor,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final Function onPressed;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // TODO: Register here
          this.onPressed();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(this.text),
      ),
      style: ButtonStyle(
        textStyle: MaterialStatePropertyAll<TextStyle>(
          TextStyle(fontSize: 18.0),
        ),
        backgroundColor: MaterialStatePropertyAll<Color>(this.color),
      ),
    );
  }
}
