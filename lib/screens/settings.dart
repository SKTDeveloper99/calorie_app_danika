import 'package:flutter/material.dart';
import '../size_config.dart';
import "package:calorie_app_danika/authentication/auth.dart";

const List<String> dropdownList = <String>['Male', 'Female'];

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

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
          preferredSize: Size.fromHeight(75.0),
          child: AppBar(
              backgroundColor: Colors.amberAccent,
              centerTitle: true,
              title: Text("My Profile", style: TextStyle(color: Colors.black))),
        ),
        body: Expanded(
          // color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // TODO: horizontal alignment is just...wrong for some reason pls fix
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: SizeConfig.blockSizeHorizontal! * 90,
                    height: SizeConfig.blockSizeHorizontal! * 50,
                    child: Card(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "assets/empty_icon 1.png",
                          width: SizeConfig.blockSizeHorizontal! * 30,
                        ),
                        (!profileEdit)
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Username",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  Text("Sex: Female",
                                      style: TextStyle(fontSize: 15)),
                                  Text("Height: 5' 4''",
                                      style: TextStyle(fontSize: 15)),
                                  Text("Age: 16",
                                      style: TextStyle(fontSize: 15)),
                                  ElevatedButton(
                                    // TODO: get rid of the elevation shadow, what you see here rn does not work :(
                                    onPressed: () {
                                      // setState(() {
                                      //   profileEdit = true;
                                      // });
                                    },
                                    child: Text("Edit Profile"),
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0.0),
                                  )
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [EditProfileForm()],
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
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
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
                                  onPressed: () {},
                                  child: Container(),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    // padding: EdgeInsets.all(20),
                                    backgroundColor:
                                        Color(0xFFB23A48), // <-- Button color
                                    foregroundColor:
                                        Colors.white, // <-- Splash color
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal! *
                                    colorButtonSize,
                                height: SizeConfig.blockSizeHorizontal! *
                                    colorButtonSize,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Container(),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    // padding: EdgeInsets.all(20),
                                    backgroundColor:
                                        Color(0xFFE39348), // <-- Button color
                                    foregroundColor:
                                        Colors.white, // <-- Splash color
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal! *
                                    colorButtonSize,
                                height: SizeConfig.blockSizeHorizontal! *
                                    colorButtonSize,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Container(),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    // padding: EdgeInsets.all(20),
                                    backgroundColor:
                                        Color(0xFFF5CB5C), // <-- Button color
                                    foregroundColor:
                                        Colors.white, // <-- Splash color
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal! *
                                    colorButtonSize,
                                height: SizeConfig.blockSizeHorizontal! *
                                    colorButtonSize,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Container(),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    // padding: EdgeInsets.all(20),
                                    backgroundColor:
                                        Color(0xFF90A955), // <-- Button color
                                    foregroundColor:
                                        Colors.white, // <-- Splash color
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal! *
                                    colorButtonSize,
                                height: SizeConfig.blockSizeHorizontal! *
                                    colorButtonSize,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Container(),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    // padding: EdgeInsets.all(20),
                                    backgroundColor:
                                        Color(0xFF48CAE4), // <-- Button color
                                    foregroundColor:
                                        Colors.white, // <-- Splash color
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal! *
                                    colorButtonSize,
                                height: SizeConfig.blockSizeHorizontal! *
                                    colorButtonSize,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Container(),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    // padding: EdgeInsets.all(20),
                                    backgroundColor:
                                        Color(0xFF00509D), // <-- Button color
                                    foregroundColor:
                                        Colors.white, // <-- Splash color
                                  ),
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
                                  onPressed: () {},
                                  child: Container(),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    // padding: EdgeInsets.all(20),
                                    backgroundColor:
                                        Color(0xFFCBC0D3), // <-- Button color
                                    foregroundColor:
                                        Colors.white, // <-- Splash color
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal! *
                                    colorButtonSize,
                                height: SizeConfig.blockSizeHorizontal! *
                                    colorButtonSize,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Container(),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    // padding: EdgeInsets.all(20),
                                    backgroundColor:
                                        Color(0xFF5E548E), // <-- Button color
                                    foregroundColor:
                                        Colors.white, // <-- Splash color
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal! *
                                    colorButtonSize,
                                height: SizeConfig.blockSizeHorizontal! *
                                    colorButtonSize,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Container(),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    // padding: EdgeInsets.all(20),
                                    backgroundColor:
                                        Color(0xFFFFB1B1), // <-- Button color
                                    foregroundColor:
                                        Colors.white, // <-- Splash color
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal! *
                                    colorButtonSize,
                                height: SizeConfig.blockSizeHorizontal! *
                                    colorButtonSize,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Container(),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    // padding: EdgeInsets.all(20),
                                    backgroundColor:
                                        Color(0xFF984066), // <-- Button color
                                    foregroundColor:
                                        Colors.white, // <-- Splash color
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal! *
                                    colorButtonSize,
                                height: SizeConfig.blockSizeHorizontal! *
                                    colorButtonSize,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Container(),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    // padding: EdgeInsets.all(20),
                                    backgroundColor:
                                        Color(0xFFD0B8AC), // <-- Button color
                                    foregroundColor:
                                        Colors.white, // <-- Splash color
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal! *
                                    colorButtonSize,
                                height: SizeConfig.blockSizeHorizontal! *
                                    colorButtonSize,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Container(),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    // padding: EdgeInsets.all(20),
                                    backgroundColor:
                                        Color(0xFF6D6875), // <-- Button color
                                    foregroundColor:
                                        Colors.white, // <-- Splash color
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 2.0),
                            child: Text("Appearance",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0)),
                          ),
                          Switch(
                            // This bool value toggles the switch.
                            value: false,
                            activeColor: Colors.green,
                            onChanged: (bool value) {},
                          )
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
                        child: Text("LOG OUT"))),
                TextButton(onPressed: () {}, child: Text("Delete Account"))
              ],
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
        child: Container(),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          // padding: EdgeInsets.all(20),
          backgroundColor: Colors.red, // <-- Button color
          foregroundColor: Colors.white, // <-- Splash color
        ),
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
  final _formKey = GlobalKey<FormState>();

  String username = "";
  String sex = "";
  int age = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                Text("Sex:"),
                // DropdownButton(
                //   isExpanded: true,
                //   value: sex,
                //   onChanged: (value) {
                //     setState(() {
                //       sex = value.toString();
                //     });
                //   },
                //   items: dropdownList
                //       .map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                // )
              ],
            ),
            Row(
              children: [Text("Height:")],
            ),
            // Row(
            //   children: [Text("Age:"), TextFormField()],
            // ),
          ]),
    );
  }
}
