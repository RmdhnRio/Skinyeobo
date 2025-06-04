import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skinyeobo/register.dart';
import 'package:skinyeobo/signin.dart';
import 'theme/colors.dart';
import 'theme/text.dart';
import 'utils/page_transitions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: AppColorScheme.lightColorScheme,
        useMaterial3: true,
        fontFamily: 'CabinetGrotesk',
      ),
      home: const OnBoardingScreen(), // Use OnBoardingScreen here
    );
  }
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _SkincareAppScreenState();
}

class _SkincareAppScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header Section

            // Main Content
            Expanded(
              child: ListView(
                children: [
                  // Hero Section
                  Stack(
                    children: [
                      Container(
                        height: 400,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(28.0),
                            bottomLeft: Radius.circular(28.0),
                          ),
                          color: ColorPalette.salmon,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        height: 450,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/onboarding_illustration.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 12, 5),
                    child: const Text(
                      'Hi gurl!',
                      style: AppTextStyles.bannerLarge,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 12, 20),
                    child: const Text(
                      'Discover the perfect skincare for you!',
                      style: AppTextStyles.bannerMedium,
                    ),
                  ),
                  // Call-to-Action Button
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.grey), // Add a border (optional)
                        borderRadius: BorderRadius.circular(
                            8), // Add rounded corners (optional)
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize
                            .min, // Make the Row as small as possible
                        children: [
                          Expanded(
                            // Expand each button to take up half the width
                            child: ElevatedButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16), // Adjust padding asneeded
                                backgroundColor: Colors
                                    .white, // Make the background transparent
                                foregroundColor:
                                    ColorPalette.salmon, // Set text color
                                elevation: 3,
                              ),
                              onPressed: () {
                                context.pushWithTransition(
                                  const SignIn(),
                                  type: TransitionType.slide,
                                );
                              },
                              child: const Text('Sign In',
                                  style: AppTextStyles.textSmall),
                            ),
                          ),
                          const VerticalDivider(
                              color: Colors.grey), // Add a vertical divider
                          Expanded(
                            child: ElevatedButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 16),
                                backgroundColor: ColorPalette.salmon,
                                foregroundColor: Colors.white,
                                elevation: 3,
                              ),
                              onPressed: () {
                                context.pushWithTransition(
                                  const RegisterScreen(),
                                  type: TransitionType.slide,
                                );
                              },
                              child: const Text('Register',
                                  style: AppTextStyles.textSmall),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
