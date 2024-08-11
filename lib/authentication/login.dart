// import 'package:calorie_app_danika/authentication/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:calorie_app_danika/size_config.dart';
import 'package:calorie_app_danika/authentication/new_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // alignment: Alignment.center,
        padding: const EdgeInsets.all(50),
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.blockSizeVertical! * 5),
            SizedBox(
                // color: Colors.amber,
                width: SizeConfig.blockSizeHorizontal! * 45,
                height: SizeConfig.blockSizeHorizontal! * 45,
                child: Image.asset("assets/app_icon.png")),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 4,
            ),
            const Text("PROPERPLATES",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  // color: Color.fromARGB(255, 240, 217, 181)
                )),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 4,
            ),
            const LoginForm(),
            // SizedBox(height: SizeConfig.blockSizeVertical! * 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/registerScreen");
                    },
                    child: const Text(
                      "Register Now",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ))
              ],
            )
          ],
        )),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  final bool _obscureText = true;

  // TODO: REPLACE THIS WHEN NEW AUTH IS MADE
  // Future login(loginUsername, loginPassword) async {
  //   try {
  //     print("logging in with $loginUsername and $loginPassword");
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: loginUsername, password: loginPassword);
  //     return null;
  //   } on FirebaseAuthException catch (error) {
  //     if (error.code == 'user-not-found') {
  //       // print('username unfound');
  //     } else if (error.code == 'wrong-password') {
  //       // print('wrong password');
  //     }
  //     return error.message;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                // borderSide: const BorderSide(
                //     style: BorderStyle.none, color: Color.fromARGB(0, 0, 0, 0)
                //     ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (value) => setState(() => email = value),
            style: const TextStyle(
              fontSize: 22,
              // color: Color.fromARGB(255, 240, 217, 181)
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 2,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Password",
              filled: true,
              // fillColor: const Color.fromARGB(255, 74, 70, 72),
              // hintText: "Password",
              // hintStyle: const TextStyle(
              //     fontSize: 22,
              //     color: Color.fromARGB(255, 32, 32, 32),
              //     fontStyle: FontStyle.italic),
              border: OutlineInputBorder(
                // borderSide: const BorderSide(
                //     style: BorderStyle.none, color: Color.fromARGB(0, 0, 0, 0)
                //     ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            obscureText: _obscureText,
            onChanged: (value) => setState(() => password = value),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            style: const TextStyle(
              fontSize: 22,
              // color: Color.fromARGB(255, 240, 217, 181)
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical! * 3),
          SizedBox(
              width: SizeConfig.blockSizeHorizontal! * 95,
              height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    // backgroundColor:
                    //     const Color.fromARGB(255, 240, 217, 181)
                  ),
                  onPressed: () {
                    Auth().login(email, password).then((result) {
                      print("logging in with $email and $password and $result");
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/', (route) => false);
                    });
                  },
                  child: const Text('LOG IN',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        // color: Color.fromARGB(255, 96, 59, 26)
                      )))),
          TextButton(
              onPressed: () {},
              child: const Text(
                "Forgot Password?",
                // style: TextStyle(color: Colors.red)
              )),
        ],
      ),
    );
  }
}
