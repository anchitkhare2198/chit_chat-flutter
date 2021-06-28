import 'dart:async';

import 'package:chitchat_flutter/screens/chat_screen.dart';
import 'package:chitchat_flutter/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'Splash_Screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;
  AnimationController controller;
  Animation animation;

  startTime() async {
    var _duration = Duration(seconds: 4);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    // Navigator.of(context).pushReplacementNamed(LoginScreen.id);
    final _auth = FirebaseAuth.instance;
    User currentUser = _auth.currentUser;

    if (currentUser != null) {
      print('UID is ${currentUser.uid}');
      Navigator.of(context).pushReplacementNamed(ChatScreen.id);
    } else {
      print('Null');
      Navigator.of(context).pushReplacementNamed(LoginScreen.id);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    animation.addListener(() => this.setState(() {}));
    controller.forward();
    // controller.addListener(() {
    //   setState(() {});
    //   print(controller.value);
    // });
    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Hero(
          tag: 'logo',
          child: Container(
            child: Image.asset('images/logo.png'),
            height: animation.value * 1000,
          ),
        ),
      ),
    );
  }
}
