import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
        if (kDebugMode) print('username unfound');
      } else if (error.code == 'wrong-password') {
        if (kDebugMode) print('wrong password');
      }
      return error.message;
    }
  }

  Future register(creationEmail, creationPassword) async {
    try {
      final accountCreateAttempt = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: creationEmail, password: creationPassword);

      User? user = accountCreateAttempt.user;
      if (kDebugMode) print(user?.email);
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
        if (kDebugMode) print('password is too weak');
      } else if (error.code == 'email-already-in-use') {
        if (kDebugMode) print('email is already in use');
      } else if (error.code == 'invalid-email') {
        if (kDebugMode) print('this email address does not exist');
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
      if (kDebugMode) print("User was sent an email!");
      await user?.sendEmailVerification();
      return null;
    } else if (user == null) {
      if (kDebugMode) print("Hmm, user does not seem to exist");
      return null;
    } else {
      if (kDebugMode) print(user?.emailVerified);
      return user;
    }
  }

  // forgot password
  Future forgotPassword(email) async {
    try {
      if (kDebugMode) print("Attempting to send an email to $email");
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email') {
        if (kDebugMode) print('this email address does not exist');
      } else if (error.code == 'user-not-found') {
        if (kDebugMode) print('this email address does not exist');
      }
      return error.message;
    }
  }

  // delete account
  Future deleteAccount() async {
    try {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref("users/${user?.uid}");
      await ref.remove().then((value) {
        if (kDebugMode) print("User data removed");
        user?.delete();
      });
      return null;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'requires-recent-login') {
        if (kDebugMode) print('this operation requires a recent login');
      }
      return error.message;
    }
  }
}
