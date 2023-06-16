import 'dart:developer';

import 'package:demo/controller/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/screen/loginscreen.dart';
import '../routes/routes.dart';
import '../screen.dart/home_screen.dart';

class AuthController extends ChangeNotifier {
  FirebaseAuth fb = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? dropdowmValue;
  List<String> dropdwonList = [
    "ZONE 1",
    "ZONE 2",
    "ZONE 3",
    "ZONE 4",
    "ZONE 5"
  ];

  changeDropDownValue(value) {
    dropdowmValue = value;
    notifyListeners();
  }

  bool loader = false;

  signup() async {
    loader = true;
    try {
      await fb.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      final data = UserModel(zone: dropdowmValue, email: fb.currentUser?.email);
      await db.collection("user").add(data.toJson());
      await saveAuthLocal();
      Routes.pushreplace(screen: HomeScreen());
      loader = false;
      notifyListeners();
    } catch (e) {
      log("--------------------erreer${e.toString()}--------------------------");
      clearLocalData();
      loader = false;
      notifyListeners();
    }
  }

  saveAuthLocal() async {
    final email = fb.currentUser?.email;
    final password = passwordController.text;
    final pref = await SharedPreferences.getInstance();
    await pref.setString('email', email.toString());
    await pref.setString('password', password.toString());
    await pref.setString('zone', dropdowmValue.toString().toUpperCase());
  }

  clearLocalData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('email');
    await pref.remove('password');
    await pref.remove('zone');
  }

  String? userEmail;
  String? userPassword;

  getLocalData() async {
    final pref = await SharedPreferences.getInstance();
    userEmail = pref.getString('email');
    userPassword = pref.getString('password');
    notifyListeners();
  }

  cheackLocalData(context) async {
    final pref = await SharedPreferences.getInstance();
    userEmail = pref.getString('email');
    userPassword = pref.getString('password');
    notifyListeners();
    log(userEmail.toString());
    log(userPassword.toString());
    if (userEmail == null || userPassword == null) {
      print("use name${userEmail}");
      print("user password${userPassword}");
      Routes.pushreplace(screen: LoginScreen());
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      // Routes.pushreplace(screen: HomeScreen());
      print("email founded");
      final homeController =
          Provider.of<HomeController>(context, listen: false);
      homeController.fecthData(context);
    }
  }

  login() async {
    await fb.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    notifyListeners();
    Routes.pushreplace(screen: HomeScreen());
    saveAuthLocal();
  }
}

class UserModel {
  String? email, zone, password;

  UserModel({this.password, required this.zone, required this.email});
  Map<String, dynamic> toJson() =>
      {"password": password, "email": email, "zone": zone};
}
