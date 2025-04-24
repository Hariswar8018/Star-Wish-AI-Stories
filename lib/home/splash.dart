import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:story_image_ai/first/login.dart';
import 'package:story_image_ai/first/onboarding.dart';

import '../main.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState(){
    Timer(Duration(seconds: 3), () async {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage(title: '',)));
      } else {
        print("Going...................90");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => OnboardingPage(title: '',)));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffD4D0CF),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Image(
            image: AssetImage('assets/WhatsApp Image 2025-02-18 at 11.31.31_bee03112.jpg'),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
