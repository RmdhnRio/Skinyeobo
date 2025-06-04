import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skinyeobo/onBoardingScreen.dart';
import 'package:skinyeobo/theme/colors.dart';
import 'package:skinyeobo/theme/text.dart';
import 'package:skinyeobo/utils/page_transitions.dart';

import 'main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const Confirmation());
}

class Confirmation extends StatelessWidget {
  const Confirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: AppColorScheme.lightColorScheme,
        useMaterial3: true,
        fontFamily: 'CabinetGrotesk',
      ),
      home: const ConfirmationScreen(),
    );
  }
}

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  void initState() {
    super.initState();
    // Set up a timer to navigate to the main page after 5 seconds
    Timer(const Duration(seconds: 5), () {
      context.pushWithTransition(
        const MyHomePage(title: 'title'),
        type: TransitionType.slide,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: -50,
                    left: -118,
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Ellipse_1.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -100,
                    right: -220,
                    child: Container(
                      height: 500,
                      width: 500,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/Ellipse_2.png'),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 48.0),
                    alignment: Alignment.topCenter,
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 80),
                          height: 220,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(
                                'assets/images/email_confirm_letter.png'),
                            fit: BoxFit.fitHeight,
                          )),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'We sending you an email',
                          style: AppTextStyles.signInLarge
                              .copyWith(color: ColorPalette.green),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Please confirm your registration\nvia email',
                          style: AppTextStyles.textSmall
                              .copyWith(color: ColorPalette.green),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
