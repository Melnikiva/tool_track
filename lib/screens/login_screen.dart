import 'package:flutter/material.dart';

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
                color: Colors.blue.shade300,
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
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: Login here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logging in...')),
                  );
                  Navigator.pushNamed(context, '/assets');
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Login'),
              ),
              style: ButtonStyle(
                textStyle: MaterialStatePropertyAll<TextStyle>(
                  TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
