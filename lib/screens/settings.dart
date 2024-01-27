import 'package:flutter/material.dart';
import '../size_config.dart';
import "package:calorie_app_danika/authentication/auth.dart";

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Username",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Text("Sex: Female", style: TextStyle(fontSize: 15)),
                            Text("Height: 5' 4''",
                                style: TextStyle(fontSize: 15)),
                            Text("Age: 16", style: TextStyle(fontSize: 15)),
                            ElevatedButton(
                              // TODO: get rid of the elevation shadow, what you see here rn does not work :(
                              onPressed: () {},
                              child: Text("Edit Profile"),
                              style: ElevatedButton.styleFrom(elevation: 0.0),
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
                                        Colors.red, // <-- Button color
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
                                        Colors.red, // <-- Button color
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
                                        Colors.red, // <-- Button color
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
                                        Colors.red, // <-- Button color
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
                                        Colors.red, // <-- Button color
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
                                        Colors.red, // <-- Button color
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
                                        Colors.red, // <-- Button color
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
                                        Colors.red, // <-- Button color
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
                                        Colors.red, // <-- Button color
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
                                        Colors.red, // <-- Button color
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
                                        Colors.red, // <-- Button color
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
                                        Colors.red, // <-- Button color
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
