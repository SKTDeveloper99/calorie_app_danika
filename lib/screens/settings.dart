import 'dart:io';

import 'package:calorie_app_danika/services/singleton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../size_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:calorie_app_danika/authentication/auth.dart";
import 'package:calorie_app_danika/authentication/new_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:calorie_app_danika/shared/themes.dart'; // Import the themes

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
  final Function(ColorScheme, bool) onColorSchemeSelected;

  const SettingsScreen({super.key, required this.onColorSchemeSelected});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool profileEdit = false;
  Singleton singleton = Singleton();
  @override
  Widget build(BuildContext context) {
    // print(singleton.userdata);
    int colorButtonSize = 9;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75.0),
          child: AppBar(
              backgroundColor: singleton.alternateColorScheme.primary,
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
                  SizedBox(
                      width: SizeConfig.blockSizeHorizontal! * 90,
                      height: SizeConfig.blockSizeHorizontal! * 50,
                      child: Card(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          (singleton.userdata?["account_info"]
                                      ["profileImageUrl"] ==
                                  null)
                              ? Image.asset(
                                  "assets/empty_icon 1.png",
                                  width: SizeConfig.blockSizeHorizontal! * 30,
                                )
                              : ClipOval(
                                  child: Image.network(
                                    singleton.userdata?["account_info"]
                                        ["profileImageUrl"],
                                    width: SizeConfig.blockSizeHorizontal! * 30,
                                    height:
                                        SizeConfig.blockSizeHorizontal! * 30,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          // (!profileEdit) ?
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(Auth().user!.email.toString().split('@')[0],
                              //     style: const TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: 20)),
                              Text("${Auth().user?.displayName}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  "Sex: ${singleton.userdata?["account_info"]["gender"]}",
                                  style: TextStyle(fontSize: 15)),
                              Text(
                                  "Height: ${singleton.userdata?["account_info"]["height"]}",
                                  style: TextStyle(fontSize: 15)),
                              Text(
                                  "Age: ${singleton.userdata?["account_info"]["age"]}",
                                  style: TextStyle(fontSize: 15)),
                              ElevatedButton(
                                // TODO: get rid of the elevation shadow, what you see here rn does not work :(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const ProfilePopup();
                                      });
                                },
                                style: ElevatedButton.styleFrom(elevation: 0.0),
                                child: const Text("Edit Profile"),
                              )
                            ],
                          )
                        ],
                      ))),
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
                              child: Text(
                                "Color Theme",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _colorButton(
                                    context,
                                    (singleton.isDarkMode)
                                        ? darkRedColorScheme
                                        : lightRedColorScheme),
                                _colorButton(
                                    context,
                                    (singleton.isDarkMode)
                                        ? darkOrangeColorScheme
                                        : lightOrangeColorScheme),
                                _colorButton(
                                    context,
                                    (singleton.isDarkMode)
                                        ? darkYellowColorScheme
                                        : lightYellowColorScheme),
                                _colorButton(
                                    context,
                                    (singleton.isDarkMode)
                                        ? darkGreenColorScheme
                                        : lightGreenColorScheme),
                                _colorButton(
                                    context,
                                    (singleton.isDarkMode)
                                        ? darkLightBlueColorScheme
                                        : lightLightBlueColorScheme),
                                _colorButton(
                                    context,
                                    (singleton.isDarkMode)
                                        ? darkBlueColorScheme
                                        : lightBlueColorScheme),
                              ],
                            ),
                            SizedBox(
                                height: SizeConfig.blockSizeHorizontal! * 1.5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _colorButton(
                                    context,
                                    (singleton.isDarkMode)
                                        ? darkLightPurpleColorScheme
                                        : lightLightPurpleColorScheme),
                                _colorButton(
                                    context,
                                    (singleton.isDarkMode)
                                        ? darkPurpleColorScheme
                                        : lightPurpleColorScheme),
                                _colorButton(
                                    context,
                                    (singleton.isDarkMode)
                                        ? darkLightPinkColorScheme
                                        : lightLightPinkColorScheme),
                                _colorButton(
                                    context,
                                    (singleton.isDarkMode)
                                        ? darkPinkColorScheme
                                        : lightPinkColorScheme),
                                _colorButton(
                                    context,
                                    (singleton.isDarkMode)
                                        ? darkBrownColorScheme
                                        : lightBrownColorScheme),
                                _colorButton(
                                    context,
                                    (singleton.isDarkMode)
                                        ? darkGreyColorScheme
                                        : lightGreyColorScheme),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 2.0),
                              child: Text(
                                "Appearance",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                            Switch(
                              value: singleton.isDarkMode,
                              activeColor: Colors.green,
                              onChanged: (bool value) {
                                singleton.isDarkMode = value;

                                print(singleton.isDarkMode);

                                ColorScheme newScheme = singleton.colorScheme;

                                switch (singleton.colorScheme) {
                                  case lightRedColorScheme:
                                    newScheme = (value)
                                        ? darkRedColorScheme
                                        : lightRedColorScheme;
                                    singleton.alternateColorScheme = (value)
                                        ? lightRedColorScheme
                                        : darkRedColorScheme;
                                    break;
                                  case lightOrangeColorScheme:
                                    newScheme = (value)
                                        ? darkOrangeColorScheme
                                        : lightOrangeColorScheme;
                                    singleton.alternateColorScheme = (value)
                                        ? lightOrangeColorScheme
                                        : darkOrangeColorScheme;
                                    break;
                                  case lightYellowColorScheme:
                                    newScheme = (value)
                                        ? darkYellowColorScheme
                                        : lightYellowColorScheme;
                                    singleton.alternateColorScheme = (value)
                                        ? lightYellowColorScheme
                                        : darkYellowColorScheme;
                                    break;
                                  case lightGreenColorScheme:
                                    newScheme = (value)
                                        ? darkGreenColorScheme
                                        : lightGreenColorScheme;
                                    singleton.alternateColorScheme = (value)
                                        ? lightGreenColorScheme
                                        : darkGreenColorScheme;
                                    break;
                                  case lightLightBlueColorScheme:
                                    newScheme = (value)
                                        ? darkLightBlueColorScheme
                                        : lightLightBlueColorScheme;
                                    singleton.alternateColorScheme = (value)
                                        ? lightLightBlueColorScheme
                                        : darkLightBlueColorScheme;
                                    break;
                                  case lightBlueColorScheme:
                                    newScheme = (value)
                                        ? darkBlueColorScheme
                                        : lightBlueColorScheme;
                                    singleton.alternateColorScheme = (value)
                                        ? lightBlueColorScheme
                                        : darkBlueColorScheme;
                                    break;
                                  case lightLightPurpleColorScheme:
                                    newScheme = (value)
                                        ? darkLightPurpleColorScheme
                                        : lightLightPurpleColorScheme;
                                    singleton.alternateColorScheme = (value)
                                        ? lightLightPurpleColorScheme
                                        : darkLightPurpleColorScheme;
                                    break;
                                  case lightPurpleColorScheme:
                                    newScheme = (value)
                                        ? darkPurpleColorScheme
                                        : lightPurpleColorScheme;
                                    singleton.alternateColorScheme = (value)
                                        ? lightPurpleColorScheme
                                        : darkPurpleColorScheme;
                                    break;
                                  case lightLightPinkColorScheme:
                                    newScheme = (value)
                                        ? darkLightPinkColorScheme
                                        : lightLightPinkColorScheme;
                                    singleton.alternateColorScheme = (value)
                                        ? lightLightPinkColorScheme
                                        : darkLightPinkColorScheme;
                                    break;
                                  case lightPinkColorScheme:
                                    newScheme = (value)
                                        ? darkPinkColorScheme
                                        : lightPinkColorScheme;
                                    singleton.alternateColorScheme = (value)
                                        ? lightPinkColorScheme
                                        : darkPinkColorScheme;
                                    break;
                                  case lightBrownColorScheme:
                                    newScheme = (value)
                                        ? darkBrownColorScheme
                                        : lightBrownColorScheme;
                                    singleton.alternateColorScheme = (value)
                                        ? lightBrownColorScheme
                                        : darkBrownColorScheme;
                                    break;
                                  case lightGreyColorScheme:
                                    newScheme = (value)
                                        ? darkGreyColorScheme
                                        : lightGreyColorScheme;
                                    singleton.alternateColorScheme = (value)
                                        ? lightGreyColorScheme
                                        : darkGreyColorScheme;
                                    break;
                                }

                                widget.onColorSchemeSelected(newScheme,
                                    newScheme.brightness == Brightness.dark);

                                setState(() {});

                                widget.onColorSchemeSelected(newScheme, value);
                              },
                            ),
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
                            logout().then(
                              (value) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, "/", (route) => false);
                              },
                            );
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

  Widget _colorButton(BuildContext context, ColorScheme colorScheme) {
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal! * 9,
      height: SizeConfig.blockSizeHorizontal! * 9,
      child: ElevatedButton(
        onPressed: () {
          widget.onColorSchemeSelected(
              colorScheme, colorScheme.brightness == Brightness.dark);

          setState(() {});
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: Colors.white,
        ),
        child: Container(),
      ),
    );
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
  String heightFeet = "";
  String heightInches = "";
  File? _image;

  Future<void> getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final FirebaseDatabase _database = FirebaseDatabase.instance;
      final FirebaseStorage _storage = FirebaseStorage.instance;
      final User? user = _auth.currentUser;
      if (user != null) {
        String uid = user.uid;
        String? imageUrl;

        if (_image != null) {
          // Upload image to Firebase Storage
          final ref =
              _storage.ref().child('Users').child(uid).child('profile.jpg');
          await ref.putFile(_image!);
          imageUrl = await ref.getDownloadURL();
        }

        // Update display name
        await user.updateDisplayName(username);

        // Write additional data to Firebase Realtime Database
        await _database.ref('users/$uid/account_info').update({
          // 'username': username,
          'gender': sex,
          'height': "$heightFeet' $heightInches\"",
          'profileImageUrl': imageUrl
        });

        // Update local state to reflect changes
        setState(() {});

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: $e')),
      );
    }
  }

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
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: getImage,
                    child: (_image == null)
                        ? const Icon(Icons.camera_alt)
                        : ClipOval(
                            child: Image.file(_image!,
                                width: SizeConfig.blockSizeHorizontal! * 35,
                                fit: BoxFit.cover),
                          ))),
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
            Row(
              // https://api.flutter.dev/flutter/cupertino/CupertinoPicker-class.html
              children: [
                const Text("Height:"),
                DropdownButton(
                    // isExpanded: true,
                    items: heightFeetList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        heightFeet = value.toString();
                      });
                    }),
                DropdownButton(
                    // isExpanded: true,
                    items: heightInchesList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        heightInches = value.toString();
                      });
                    }),
              ],
            ),
            ElevatedButton(
              onPressed: _saveProfile,
              child: const Text("Save"),
            ),
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
          // ElevatedButton(
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //     child: const Text("Save"))
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
