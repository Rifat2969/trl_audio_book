// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trl_audio_book/login/add_email.dart';
import 'package:trl_audio_book/utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  double _progressValue = 0.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // adjust speed here
    )..addListener(() {
        setState(() {
          _progressValue = _controller.value;
        });
        if (_controller.isCompleted) {
          // Navigate when done
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AddEmail()),
          );
/*
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddEmail()));
*/
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.initMediaQuery(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1C2037),
              Color(0xFF191C23),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg_icons/Logo.svg',
              height: 7.height,
            ),
            SizedBox(height: 6.height),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 112),
              child: LinearProgressIndicator(
                value: _progressValue, // controlled progress
                backgroundColor: Colors.white24,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
