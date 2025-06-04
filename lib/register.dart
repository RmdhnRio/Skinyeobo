import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skinyeobo/confirmationScreen.dart';
import 'package:skinyeobo/onBoardingScreen.dart';
import 'package:skinyeobo/theme/colors.dart';
import 'package:skinyeobo/theme/text.dart';
import 'package:skinyeobo/utils/page_transitions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const Register());
}

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: AppColorScheme.lightColorScheme,
        useMaterial3: true,
        fontFamily: 'CabinetGrotesk',
      ),
      home: const RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  Widget _buildSocialButton(String imagePath) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            // Handle social login
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset(
              imagePath,
              width: 24,
              height: 24,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(children: [
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
                      const Text(
                        'Register now',
                        style: AppTextStyles.signInLarge,
                        textAlign: TextAlign.left,
                      ),
                      const Text(
                        'And get a special voucher\nonly for you!',
                        style: AppTextStyles.signInSmall,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 40),
                      // Email Field
                      Container(
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorPalette.white,
                            borderRadius: BorderRadius.circular(10),
                            border: const Border(
                              bottom: BorderSide(
                                color: ColorPalette.salmon,
                                width: 2.0,
                              ),
                            ),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(color: ColorPalette.orange),
                              prefixIconColor: ColorPalette.orange,
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Username Field
                      Container(
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorPalette.white,
                            borderRadius: BorderRadius.circular(10),
                            border: const Border(
                              bottom: BorderSide(
                                color: ColorPalette.salmon,
                                width: 2.0,
                              ),
                            ),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Username',
                              hintStyle: TextStyle(color: ColorPalette.orange),
                              prefixIconColor: ColorPalette.orange,
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Password Field
                      Container(
                        decoration: BoxDecoration(
                          color: ColorPalette.white,
                          borderRadius: BorderRadius.circular(10),
                          border: const Border(
                            bottom: BorderSide(
                              color: ColorPalette.salmon,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: TextFormField(
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle:
                                const TextStyle(color: ColorPalette.orange),
                            prefixIconColor: ColorPalette.orange,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: ColorPalette.orange,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Confirm Password Field
                      Container(
                        decoration: BoxDecoration(
                          color: ColorPalette.white,
                          borderRadius: BorderRadius.circular(10),
                          border: const Border(
                            bottom: BorderSide(
                              color: ColorPalette.salmon,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: TextFormField(
                          obscureText: !_isConfirmPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle:
                                const TextStyle(color: ColorPalette.orange),
                            prefixIconColor: ColorPalette.orange,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: ColorPalette.orange,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordVisible =
                                      !_isConfirmPasswordVisible;
                                });
                              },
                            ),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      // Register Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Container(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                // Add your sign in logic here
                              },
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      ColorPalette.orange,
                                      ColorPalette.orange.withRed(
                                          (ColorPalette.orange.red * 0.9)
                                              .round()),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          ColorPalette.orange.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(10),
                                      highlightColor:
                                          Colors.white.withOpacity(0.1),
                                      splashColor:
                                          Colors.white.withOpacity(0.2),
                                      onTap: () {
                                        context.pushWithTransition(
                                            const ConfirmationScreen(),
                                            type: TransitionType.slideUp);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Register',
                                              style: AppTextStyles.textSmall
                                                  .copyWith(
                                                      color:
                                                          ColorPalette.white),
                                            ),
                                            // SizedBox(width: 8),
                                            // Icon(
                                            //   Icons.arrow_forward,
                                            //   color: Colors.white,
                                            //   size: 20,
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: ColorPalette.secondary.withOpacity(0.5),
                                thickness: 1,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'Or sign in with',
                                style: TextStyle(
                                  color: ColorPalette.secondary,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: ColorPalette.secondary.withOpacity(0.5),
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildSocialButton('assets/images/google-icon.png'),
                            _buildSocialButton('assets/images/apple-icon.png'),
                            _buildSocialButton(
                                'assets/images/facebook-icon.png'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
