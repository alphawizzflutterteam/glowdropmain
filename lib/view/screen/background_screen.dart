// lib/widgets/background_container.dart

import 'package:flutter/material.dart';
class BackgroundContainer extends StatelessWidget {
  final Widget child;

  const BackgroundContainer({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              "assets/images/background.png",
              fit: BoxFit.cover,
            ),
          ),
          // Foreground content
          // SizedBox(height: 20,),
          Center(
            child: SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  // const SizedBox(height: 130),
                  Image.asset("assets/images/logo_image.png"),
                  // const SizedBox(height: 10),
                  child, // Your AuthScreen content
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
