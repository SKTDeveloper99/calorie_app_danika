import 'package:flutter/material.dart';
import '../size_config.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text("My Profile", style: TextStyle(color: Colors.black))),
        body: Padding(
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
              SizedBox(
                  width: SizeConfig.blockSizeHorizontal! * 90,
                  height: SizeConfig.blockSizeHorizontal! * 45,
                  child: Card(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Color Theme"),
                        Row(
                          children: [
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal! * 5,
                              height: SizeConfig.blockSizeHorizontal! * 5,
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
                            ElevatedButton(
                              onPressed: () {},
                              child: Container(),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                // padding: EdgeInsets.all(20),
                                backgroundColor:
                                    Colors.orange, // <-- Button color
                                foregroundColor:
                                    Colors.white, // <-- Splash color
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Container(),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                // padding: EdgeInsets.all(20),
                                backgroundColor:
                                    Colors.amber, // <-- Button color
                                foregroundColor:
                                    Colors.white, // <-- Splash color
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Container(),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                // padding: EdgeInsets.all(20),
                                backgroundColor:
                                    Colors.green, // <-- Button color
                                foregroundColor:
                                    Colors.white, // <-- Splash color
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Container(),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                // padding: EdgeInsets.all(20),
                                backgroundColor:
                                    Colors.teal, // <-- Button color
                                foregroundColor:
                                    Colors.white, // <-- Splash color
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Container(),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                // padding: EdgeInsets.all(20),
                                backgroundColor:
                                    Colors.blue, // <-- Button color
                                foregroundColor:
                                    Colors.white, // <-- Splash color
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Container(),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                // padding: EdgeInsets.all(20),
                                backgroundColor:
                                    Colors.indigo, // <-- Button color
                                foregroundColor:
                                    Colors.white, // <-- Splash color
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Container(),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                // padding: EdgeInsets.all(20),
                                backgroundColor:
                                    Colors.purple, // <-- Button color
                                foregroundColor:
                                    Colors.white, // <-- Splash color
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Container(),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                // padding: EdgeInsets.all(20),
                                backgroundColor:
                                    Colors.indigo, // <-- Button color
                                foregroundColor:
                                    Colors.white, // <-- Splash color
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Container(),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                // padding: EdgeInsets.all(20),
                                backgroundColor:
                                    Colors.purple, // <-- Button color
                                foregroundColor:
                                    Colors.white, // <-- Splash color
                              ),
                            ),
                          ],
                        ),
                        Text("Appearance"),
                        Switch(
                          // This bool value toggles the switch.
                          value: false,
                          activeColor: Colors.green,
                          onChanged: (bool value) {},
                        )
                      ],
                    ),
                  ))),
              SizedBox(
                  width: SizeConfig.blockSizeHorizontal! * 90,
                  child:
                      ElevatedButton(onPressed: () {}, child: Text("LOG OUT"))),
              TextButton(onPressed: () {}, child: Text("Delete Account"))
            ],
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
