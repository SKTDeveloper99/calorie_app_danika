import 'package:flutter/material.dart';
import "package:calorie_app_danika/size_config.dart";

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
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RegisterForm(),
          )
        ],
      ),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Register",
              style: TextStyle(fontSize: 65),
            ),
            TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    hintText: "Email"),
                validator: (value) {
                  return null;
                },
                onChanged: (value) => setState(() {
                      email = value;
                    })),
            TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Password"),
                obscureText: true,
                validator: (value) {
                  return null;
                },
                onChanged: (value) => setState(() {
                      password = value;
                    })),
            TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Confirm Password"),
                obscureText: true,
                validator: (value) {
                  return null;
                },
                onChanged: (value) => setState(() {
                      confirm = value;
                    })),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal! * 50,
              child: ElevatedButton(onPressed: () {}, child: Text("Register")),
            )
          ],
        ));
  }
}
