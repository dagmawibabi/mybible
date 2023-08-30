import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void loadingDelay() {
    Timer.periodic(
      const Duration(seconds: 2),
      (time) {
        time.cancel();
        Navigator.popAndPushNamed(context, "homePage");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadingDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              "assets/icons/bibleLogo.jpg",
              width: 200.0,
            ),
            Text(
              "My Bible",
              style: GoogleFonts.ubuntu(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Column(
              children: [
                Text(
                  "August 30, 2023",
                  style: TextStyle(
                    color: Colors.grey[800]!,
                    fontSize: 12.0,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  "Dream Intelligence",
                  style: TextStyle(
                    color: Colors.grey[800]!,
                    // fontSize: 20.0,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
