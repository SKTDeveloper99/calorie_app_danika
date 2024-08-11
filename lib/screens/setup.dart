import 'package:flutter/material.dart';
import "package:calorie_app_danika/size_config.dart";
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:calorie_app_danika/size_config.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

enum Gender { male, female }

class _SetupScreenState extends State<SetupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   appBar: AppBar(
      //       // elevation: 0,
      //       // backgroundColor: Colors.amber,
      //       ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: SizedBox(
            width: SizeConfig.blockSizeHorizontal! * 100,
            height: SizeConfig.blockSizeVertical! * 100,
            // color: const Color.fromARGB(255, 35, 35, 35),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //   SizedBox(
                //     height: SizeConfig.blockSizeVertical! * 14,
                //   ),
                //   Text(
                //     "Register",
                //     style: TextStyle(fontSize: 65),
                //   ),
                Padding(
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
  Gender? _gender = Gender.male;
  String activity = "Basal Metabolic Rate (BMR)";
  bool showAdvancedSettings = false;

  int age = 0;
  String gender = "";
  String height = "";
  int heightFeet = 0;
  int heightInches = 0;
  int currentWeight = 1;
  int goalWeight = 0;
  int fatPercentage = 20;

//   // DELETE later
//   Future<void> createAccount() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  // fillColor: const Color.fromARGB(255, 74, 70, 72),
                  // hintText: "Email",
                  // hintStyle: const TextStyle(
                  //     fontSize: 22,
                  //     color: Color.fromARGB(255, 32, 32, 32),
                  //     fontStyle: FontStyle.italic),
                  labelText: "Age",
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
                      age = int.parse(value);
                    })),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Gender"),
                Row(
                  children: [
                    Radio(
                        value: Gender.male,
                        groupValue: _gender,
                        onChanged: (Gender? value) {
                          setState(() {
                            _gender = value;
                          });
                        }),
                    const Text("Male"),
                    Radio(
                        value: Gender.female,
                        groupValue: _gender,
                        onChanged: (Gender? value) {
                          setState(() {
                            _gender = value;
                          });
                        }),
                    const Text("Female"),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Height"),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal! * 34,
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              // fillColor: const Color.fromARGB(255, 74, 70, 72),
                              // hintText: "Email",
                              // hintStyle: const TextStyle(
                              //     fontSize: 22,
                              //     color: Color.fromARGB(255, 32, 32, 32),
                              //     fontStyle: FontStyle.italic),
                              labelText: "feet",
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
                                  heightFeet = int.parse(value);
                                })),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal! * 34,
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              // fillColor: const Color.fromARGB(255, 74, 70, 72),
                              // hintText: "Email",
                              // hintStyle: const TextStyle(
                              //     fontSize: 22,
                              //     color: Color.fromARGB(255, 32, 32, 32),
                              //     fontStyle: FontStyle.italic),
                              labelText: "inches",
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
                                  heightInches = int.parse(value);
                                })),
                      ),
                    ]),
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  // fillColor: const Color.fromARGB(255, 74, 70, 72),
                  // hintText: "Email",
                  // hintStyle: const TextStyle(
                  //     fontSize: 22,
                  //     color: Color.fromARGB(255, 32, 32, 32),
                  //     fontStyle: FontStyle.italic),
                  labelText: "Current Weight (in pounds)",
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
                      currentWeight = int.parse(value);
                    })),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  // fillColor: const Color.fromARGB(255, 74, 70, 72),
                  // hintText: "Email",
                  // hintStyle: const TextStyle(
                  //     fontSize: 22,
                  //     color: Color.fromARGB(255, 32, 32, 32),
                  //     fontStyle: FontStyle.italic),
                  labelText: "Goal Weight (in pounds)",
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
                      goalWeight = int.parse(value);
                    })),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Activity"),
                DropdownButtonFormField(
                    value: activity,
                    items: [
                      "Basal Metabolic Rate (BMR)",
                      "Sedentary (little/no exercise)",
                      "Light (exercise 1-2 times/week)",
                      "Moderate (exercise 3-5 times/week)",
                      "Heavy (exercise 6-7 times/week)",
                      "Very Active (intense exercise daily)",
                    ].map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        activity = value!;
                      });
                    }),
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    showAdvancedSettings = !showAdvancedSettings;
                  });
                },
                child: Text((!showAdvancedSettings)
                    ? "Show Advanced Settings"
                    : "Hide Advanced Settings")),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            (showAdvancedSettings)
                ? TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      // fillColor: const Color.fromARGB(255, 74, 70, 72),
                      // hintText: "Email",
                      // hintStyle: const TextStyle(
                      //     fontSize: 22,
                      //     color: Color.fromARGB(255, 32, 32, 32),
                      //     fontStyle: FontStyle.italic),
                      labelText: "Body Fat Percentage",
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
                          fatPercentage = int.parse(value);
                        }))
                : Container(),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal! * 100,
              child: ElevatedButton(
                  onPressed: () async {
                    // await createAccount().then((_) {
                    //   Navigator.pushNamed(context, "/homeScreen");
                    // });
                    DatabaseReference ref = FirebaseDatabase.instance
                        .ref("users/${FirebaseAuth.instance.currentUser?.uid}");

                    await ref.set({
                      "account_info": {
                        "age": age,
                        "calorie_budget": 1000,
                        "color_theme": "grey",
                        "gender": ("$_gender").substring(6),
                        "height": "$heightFeet'$heightInches\"",
                        "weight_target": goalWeight,
                      },
                    }).then((value) {
                      Navigator.pushNamed(context, "/homeScreen");
                    });
                  },
                  child: const Text("CONFIRM")),
            )
          ],
        ));
  }
}
