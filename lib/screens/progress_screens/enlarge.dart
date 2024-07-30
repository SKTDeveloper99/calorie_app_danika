import 'package:calorie_app_danika/services/singleton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class EnlargedScreen extends StatelessWidget {
  EnlargedScreen({super.key, required this.image});
  final String image;

  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Singleton singleton = Singleton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(children: [
          Image.network(image),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // delete button
              SizedBox(
                width: 100,
                child: ElevatedButton(
                    onPressed: () async {
                      // get progressPictures from Singleton
                      List<dynamic> progressPictures = List<dynamic>.from(
                          singleton.userdata?["account_info"]
                                  ["progressPictures"] ??
                              []);

                      // find the entry whose value at key "url" is equal to image
                      progressPictures
                          .removeWhere((entry) => entry["url"] == image);

                      // update the progressPictures in Singleton
                      singleton.userdata?["account_info"]["progressPictures"] =
                          progressPictures;

                      // update the progressPictures in Firebase
                      await database
                          .reference()
                          .child("users")
                          .child(auth.currentUser!.uid)
                          .update({
                        "account_info": singleton.userdata?["account_info"]
                      });

                      // delete the image from Firebase Storage
                      await storage.refFromURL(image).delete();

                      // pop the screen
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.delete)),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
