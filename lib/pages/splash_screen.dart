// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:bloc_api_sample/pages/home_screen.dart';
import 'package:bloc_api_sample/view/login_screen/login_screen.dart';
import 'package:bloc_api_sample/view/registration_screen/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
   Timer(Duration(seconds: 3), () async {
    final prefs = await SharedPreferences.getInstance();
    final access = prefs .getString("access");
     if(access != null && access.isNotEmpty){
        Navigator.pushReplacement(context,
       MaterialPageRoute(builder: (context)=>HomeScreen()));
     } else{
      Navigator.pushReplacement(context,
       MaterialPageRoute(builder: (context)=>LoginScreen()));
     }
    
     
   },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: Center(child: Text("SPLASH SCREEN",
  style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 30
  ),),),
    );
  }
}