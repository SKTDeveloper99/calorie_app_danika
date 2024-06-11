import 'package:flutter/material.dart';
import '../size_config.dart';
import "package:calorie_app_danika/authentication/auth.dart";
import 'package:calorie_app_danika/authentication/new_auth.dart';

const List<String> dropdownList = <String>['', 'Male', 'Female'];

const List<String> ageList = <String>[
  '',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
  '24',
  '25',
  '26',
  '27',
  '28',
  '29',
  '30',
  '31',
  '32',
  '33',
  '34',
  '35',
  '36',
  '37',
  '38',
  '39',
  '40',
  '41',
  '42',
  '43',
  '44',
  '45',
  '46',
  '47',
  '48',
  '49',
  '50',
  '51',
  '52',
  '53',
  '54',
  '55',
  '56',
  '57',
  '58',
  '59',
  '60',
  '61',
  '62',
  '63',
  '64',
  '65',
  '66',
  '67',
  '68',
  '69',
  '70',
  '71',
  '72',
  '73',
  '74',
  '75',
  '76',
  '77',
  '78',
  '79',
  '80',
  '81',
  '82',
  '83',
  '84',
  '85',
  '86',
  '87',
  '88',
  '89',
  '90',
  '91',
  '92',
  '93',
  '94',
  '95',
  '96',
  '97',
  '98',
  '99',
  '100',
];

const List<String> heightFeetList = <String>[
  '',
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
];

const List<String> heightInchesList = <String>[
  '',
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
];

class SettingsScreen extends StatefulWidget {
  final Function(Color, bool) onColorSelected;

  const SettingsScreen({super.key, required this.onColorSelected});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool profileEdit = false;
  @override
  Widget build(BuildContext context) {
    int colorButtonSize = 9;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75.0),
          child: AppBar(
              backgroundColor: ThemeData.dark().colorScheme.primary,
              centerTitle: true,
              title: const Text("My Profile",
                  style: TextStyle(color: Colors.black))),
        ),
        body: SingleChildScrollView(
          child: Center(
            heightFactor: 1.2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // TODO: implement profile edit in the next update
                  // SizedBox(
                  //     width: SizeConfig.blockSizeHorizontal! * 90,
                  //     height: SizeConfig.blockSizeHorizontal! * 50,
                  //     child: Card(
                  //         child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Image.asset(
                  //           "assets/empty_icon 1.png",
                  //           width: SizeConfig.blockSizeHorizontal! * 30,
                  //         ),
                  //         // (!profileEdit) ?
                  //         Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(Auth().user!.email.toString().split('@')[0],
                  //                 style: const TextStyle(
                  //                     fontWeight: FontWeight.bold,
                  //                     fontSize: 20)),
                  //             const Text("Sex: Female",
                  //                 style: TextStyle(fontSize: 15)),
                  //             const Text("Height: 5' 4''",
                  //                 style: TextStyle(fontSize: 15)),
                  //             const Text("Age: 16",
                  //                 style: TextStyle(fontSize: 15)),
                  //             ElevatedButton(
                  //               // TODO: get rid of the elevation shadow, what you see here rn does not work :(
                  //               onPressed: () {
                  //                 showDialog(
                  //                     context: context,
                  //                     builder: (BuildContext context) {
                  //                       return const ProfilePopup();
                  //                     });
                  //               },
                  //               style: ElevatedButton.styleFrom(elevation: 0.0),
                  //               child: const Text("Edit Profile"),
                  //             )
                  //           ],
                  //         )
                  //       ],
                  //     ))),
                  SizedBox(height: SizeConfig.blockSizeVertical! * 2),
                  SizedBox(
                      width: SizeConfig.blockSizeHorizontal! * 90,
                      height: SizeConfig.blockSizeHorizontal! * 56,
                      child: Card(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                              child: Text("Color Theme",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  height: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      widget.onColorSelected(Colors.red, false);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      // padding: EdgeInsets.all(20),
                                      backgroundColor: const Color(
                                          0xFFB23A48), // <-- Button color
                                      foregroundColor:
                                          Colors.white, // <-- Splash color
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  height: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      widget.onColorSelected(
                                          Colors.blue, false);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      // padding: EdgeInsets.all(20),
                                      backgroundColor: const Color(
                                          0xFFE39348), // <-- Button color
                                      foregroundColor:
                                          Colors.white, // <-- Splash color
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  height: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      widget.onColorSelected(
                                          Colors.green, false);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      // padding: EdgeInsets.all(20),
                                      backgroundColor: const Color(
                                          0xFFF5CB5C), // <-- Button color
                                      foregroundColor:
                                          Colors.white, // <-- Splash color
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  height: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      widget.onColorSelected(
                                          Colors.purple, false);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      // padding: EdgeInsets.all(20),
                                      backgroundColor: const Color(
                                          0xFF90A955), // <-- Button color
                                      foregroundColor:
                                          Colors.white, // <-- Splash color
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  height: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      widget.onColorSelected(
                                          Colors.orange, false);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      // padding: EdgeInsets.all(20),
                                      backgroundColor: const Color(
                                          0xFF48CAE4), // <-- Button color
                                      foregroundColor:
                                          Colors.white, // <-- Splash color
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  height: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      widget.onColorSelected(
                                          Colors.pink, false);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      // padding: EdgeInsets.all(20),
                                      backgroundColor: const Color(
                                          0xFF00509D), // <-- Button color
                                      foregroundColor:
                                          Colors.white, // <-- Splash color
                                    ),
                                    child: Container(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height: SizeConfig.blockSizeHorizontal! * 1.5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  height: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      widget.onColorSelected(
                                          Colors.grey, false);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      // padding: EdgeInsets.all(20),
                                      backgroundColor: const Color(
                                          0xFFCBC0D3), // <-- Button color
                                      foregroundColor:
                                          Colors.white, // <-- Splash color
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  height: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      widget.onColorSelected(
                                          Colors.black, false);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      // padding: EdgeInsets.all(20),
                                      backgroundColor: const Color(
                                          0xFF5E548E), // <-- Button color
                                      foregroundColor:
                                          Colors.white, // <-- Splash color
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  height: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      widget.onColorSelected(
                                          Colors.white, false);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      // padding: EdgeInsets.all(20),
                                      backgroundColor: const Color(
                                          0xFFFFB1B1), // <-- Button color
                                      foregroundColor:
                                          Colors.white, // <-- Splash color
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  height: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      widget.onColorSelected(
                                          Colors.yellow, false);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      // padding: EdgeInsets.all(20),
                                      backgroundColor: const Color(
                                          0xFF984066), // <-- Button color
                                      foregroundColor:
                                          Colors.white, // <-- Splash color
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  height: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      widget.onColorSelected(
                                          Colors.teal, false);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      // padding: EdgeInsets.all(20),
                                      backgroundColor: const Color(
                                          0xFFD0B8AC), // <-- Button color
                                      foregroundColor:
                                          Colors.white, // <-- Splash color
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  height: SizeConfig.blockSizeHorizontal! *
                                      colorButtonSize,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      widget.onColorSelected(
                                          Colors.brown, false);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      // padding: EdgeInsets.all(20),
                                      backgroundColor: const Color(
                                          0xFF6D6875), // <-- Button color
                                      foregroundColor:
                                          Colors.white, // <-- Splash color
                                    ),
                                    child: Container(),
                                  ),
                                ),
                              ],
                            ),
                            // TODO: implement the dark mode toggle in the next update
                            // const Padding(
                            //   padding: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 2.0),
                            //   child: Text("Appearance",
                            //       textAlign: TextAlign.left,
                            //       style: TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           fontSize: 18.0)),
                            // ),
                            // Switch(
                            //   // This bool value toggles the switch.
                            //   value: false,
                            //   activeColor: Colors.green,
                            //   onChanged: (bool value) {},
                            // )
                          ],
                        ),
                      ))),
                  SizedBox(height: SizeConfig.blockSizeVertical! * 2),
                  SizedBox(
                      width: SizeConfig.blockSizeHorizontal! * 90,
                      height: SizeConfig.blockSizeVertical! * 6,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                          onPressed: () {
                            logout();
                          },
                          child: const Text("LOG OUT"))),
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const DeleteAccountPopup();
                            });
                      },
                      child: const Text("Delete Account"))
                ],
              ),
            ),
          ),
        ));
  }
}

// TODO: Make a custom color button class for the theme buttons
class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal! * 5,
      height: SizeConfig.blockSizeHorizontal! * 5,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          // padding: EdgeInsets.all(20),
          backgroundColor: Colors.red, // <-- Button color
          foregroundColor: Colors.white, // <-- Splash color
        ),
        child: Container(),
      ),
    );
  }
}

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  // final _formKey = GlobalKey<FormState>();

  String username = "";
  String sex = "";
  int age = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal! * 70,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: SizeConfig.blockSizeHorizontal! * 35,
                height: SizeConfig.blockSizeHorizontal! * 35,
                child: ElevatedButton(
                    onPressed: () {}, child: const Icon(Icons.camera_alt))),
            TextFormField(
                initialValue: username,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    hintText: "Username"),
                validator: (value) {
                  return null;
                },
                onChanged: (value) => setState(() {
                      username = value;
                    })),
            Row(
              children: [
                const Text("Sex:"),
                DropdownButton(
                  // isExpanded: true,
                  value: sex,
                  onChanged: (value) {
                    setState(() {
                      sex = value.toString();
                    });
                  },
                  items: dropdownList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ],
            ),
            const Row(
              // https://api.flutter.dev/flutter/cupertino/CupertinoPicker-class.html
              children: [Text("Height:")],
            ),
            // Row(
            //   children: [Text("Age:"), TextFormField()],
            // ),
          ]),
    );
  }
}

// edit profile popup
class ProfilePopup extends StatelessWidget {
  const ProfilePopup({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        insetPadding: EdgeInsets.fromLTRB(0, SizeConfig.blockSizeVertical! * 20,
            0, SizeConfig.blockSizeVertical! * 20),
        title: const Text("Edit Profile"),
        content: const EditProfileForm(),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Save"))
        ],
      ),
    );
  }
}

class DeleteAccountPopup extends StatelessWidget {
  const DeleteAccountPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete Account"),
      content: const Text("Are you sure you want to delete your account?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel")),
        ElevatedButton(
            onPressed: () {
              Auth().deleteAccount().then((value) {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/", (route) => false);
              });
            },
            child: const Text("Delete"))
      ],
    );
  }
}
