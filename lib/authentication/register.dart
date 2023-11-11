import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String confirm = "";

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
                decoration: InputDecoration(hintText: "Email"),
                validator: (value) {
                  return null;
                },
                onChanged: (value) => setState(() {
                      email = value;
                    })),
            TextFormField(
                decoration: InputDecoration(hintText: "Password"),
                obscureText: true,
                validator: (value) {
                  return null;
                },
                onChanged: (value) => setState(() {
                      password = value;
                    })),
            TextFormField(
                decoration: InputDecoration(hintText: "Confirm Password"),
                obscureText: true,
                validator: (value) {
                  return null;
                },
                onChanged: (value) => setState(() {
                      confirm = value;
                    })),
          ],
        ));
  }
}
