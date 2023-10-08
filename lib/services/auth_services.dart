import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firelessonfirst/main.dart';
import 'package:firelessonfirst/models/user_model.dart';
import 'package:flutter/widgets.dart';

class AuthServices {
  final firebaseAuth = FirebaseAuth.instance;

  //sign in/login

  Future<User?> login(UserModel model) async {
    User? user0;

    firebaseAuth.authStateChanges().listen((event) async {
      if (event == null) {
        final user = await firebaseAuth.signInWithEmailAndPassword(
          email: model.email,
          password: model.password,
        );
        user0 = user.user;
        log("Bu User ro'yxatimizdan o'tgan");
      }
    });
    return user0;
  }

  Stream<User?> checkUser() {
    return firebaseAuth.authStateChanges();
  }

//logout

  Future<void> logout(BuildContext context) async {
    await firebaseAuth.signOut().then((value) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(CheckUserPage.id, (Route route) => false);
    });
  }
}