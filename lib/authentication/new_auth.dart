import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Auth {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

  Future login(loginUsername, loginPassword) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginUsername, password: loginPassword);
      return null;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        print('username unfound'); // TODO: replace with UI element
      } else if (error.code == 'wrong-password') {
        print('wrong password');
      }
      return error.message;
    }
  }

  Future register(creationEmail, creationPassword) async {
    try {
      final accountCreateAttempt = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: creationEmail, password: creationPassword);

      // User? user = accountCreateAttempt.user;
      // user?.updateDisplayName(username);

      // DatabaseReference ref =
      //     FirebaseDatabase.instance.ref("users/${user?.uid}");

      // await ref.set({
      //   "account_info": {
      //     "color_theme": "grey",
      //   },
      // });

      return null;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        print('password is too weak');
      } else if (error.code == 'email-already-in-use') {
        print('email is already in use');
      } else if (error.code == 'invalid-email') {
        print('this email address does not exist');
      }
      return error.message;
    }
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    return null;
  }

  Future verifyEmail() async {
    // return;
    if (user != null && !user!.emailVerified) {
      print("User was sent an email!");
      await user?.sendEmailVerification();
      return null;
    } else if (user == null) {
      print("Hmm, user does not seem to exist");
      return null;
    } else {
      print(user?.emailVerified);
      return user;
    }
  }

  // forgot password
  Future forgotPassword(email) async {
    try {
      print("Attempting to send an email to $email");
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email') {
        print('this email address does not exist');
      } else if (error.code == 'user-not-found') {
        print('this email address does not exist');
      }
      return error.message;
    }
  }
}
