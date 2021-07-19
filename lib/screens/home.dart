import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List receivedData = getProduct();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, "/productlist");
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        "Welcome to Carnival : )",
                        textStyle: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        speed: Duration(milliseconds: 160),
                      ),
                    ],
                    totalRepeatCount: 1,
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Container(
                    height: 30.0,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        FadeAnimatedText(
                          "Tap anywhere to Enter",
                          textStyle: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                          duration: Duration(milliseconds: 3000),
                        ),
                      ],
                      repeatForever: true,
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
