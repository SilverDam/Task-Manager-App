import 'package:budget_app/config/colors.dart';
import 'package:budget_app/view/Onboarding%20screens/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splashIconSize: 600,
        duration: 10000,
        splash: 'asset/images/animated-logo-2.gif',
        nextScreen: const OnboardScreen(),

        splashTransition: SplashTransition.fadeTransition ,
        pageTransitionType: PageTransitionType.bottomToTop,
        backgroundColor: bkgrColor,
        
        
        );
  }
}
