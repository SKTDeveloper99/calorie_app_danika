import 'package:flutter/material.dart';
import "package:calorie_app_danika/size_config.dart";
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:calorie_app_danika/size_config.dart';

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
          // elevation: 0,
          // backgroundColor: Colors.amber,
          ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: SizedBox(
            width: SizeConfig.blockSizeHorizontal! * 100,
            height: SizeConfig.blockSizeVertical! * 100,
            // color: const Color.fromARGB(255, 35, 35, 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 14,
                ),
                const Text(
                  "Register",
                  style: TextStyle(fontSize: 65),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: RegisterForm(),
                )
              ],
            ),
          ),
        ),
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

  // DELETE later
  Future<void> createAccount() async {
    if (_formKey.currentState?.validate() ?? false) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    }
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
                  filled: true,
                  // fillColor: const Color.fromARGB(255, 74, 70, 72),
                  // hintText: "Email",
                  // hintStyle: const TextStyle(
                  //     fontSize: 22,
                  //     color: Color.fromARGB(255, 32, 32, 32),
                  //     fontStyle: FontStyle.italic),
                  labelText: "Email",
                  // label: Container(
                  //     color: Colors.amber, child: Text("Email or phone #")),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        style: BorderStyle.none,
                        color: Color.fromARGB(0, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  return null;
                },
                onChanged: (value) => setState(() {
                      email = value;
                    })),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  // fillColor: const Color.fromARGB(255, 74, 70, 72),
                  // hintText: "Email",
                  // hintStyle: const TextStyle(
                  //     fontSize: 22,
                  //     color: Color.fromARGB(255, 32, 32, 32),
                  //     fontStyle: FontStyle.italic),
                  labelText: "Password",
                  // label: Container(
                  //     color: Colors.amber, child: Text("Email or phone #")),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        style: BorderStyle.none,
                        color: Color.fromARGB(0, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  return null;
                },
                onChanged: (value) => setState(() {
                      password = value;
                    })),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  // fillColor: const Color.fromARGB(255, 74, 70, 72),
                  // hintText: "Email",
                  // hintStyle: const TextStyle(
                  //     fontSize: 22,
                  //     color: Color.fromARGB(255, 32, 32, 32),
                  //     fontStyle: FontStyle.italic),
                  labelText: "Confirm Password",
                  // label: Container(
                  //     color: Colors.amber, child: Text("Email or phone #")),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        style: BorderStyle.none,
                        color: Color.fromARGB(0, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  return null;
                },
                onChanged: (value) => setState(() {
                      confirm = value;
                    })),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal! * 100,
              child: ElevatedButton(
                  onPressed: () async {
                    await createAccount().then((_) {
                      Navigator.pushNamed(context, "/setupScreen");
                    });
                  },
                  child: const Text("CREATE ACCOUNT")),
            )
          ],
        ));
  }
}
