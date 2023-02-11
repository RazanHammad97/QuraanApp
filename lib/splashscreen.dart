import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key,required this.title}) : super(key: key);
final String title;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () => {
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const MyHomePage(title: "القران الكريم", ))
    )});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Image(image: AssetImage("Splash.png"),),
      ),
    );
  }
}
