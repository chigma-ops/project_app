import 'dart:async';
import 'package:flutter/material.dart';
import 'password.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashLoginPage(),
    );
  }
}

class SplashLoginPage extends StatefulWidget {
  const SplashLoginPage({super.key});

  @override
  State<SplashLoginPage> createState() => _SplashLoginPageState();
}

class _SplashLoginPageState extends State<SplashLoginPage>
    with TickerProviderStateMixin {

  bool showLogin = false;

  late AnimationController _blueController;
  late AnimationController _whiteController;
  late Animation<double> _blueFade;
  late Animation<double> _whiteDrop;
  late Animation<double> _logo3Fade;
  late AnimationController _loginFadeController;

  final TextEditingController _phoneController = TextEditingController();
  String? _errorText;

  @override
  void initState() {
    super.initState();

    _blueController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _whiteController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _blueFade = CurvedAnimation(
      parent: _blueController,
      curve: Curves.easeIn,
    );

    // logo2 drops from above
    _whiteDrop = Tween<double>(begin: -200, end: 0).animate(
      CurvedAnimation(
        parent: _whiteController,
        curve: Curves.easeOutCubic,
      ),
    );

    // logo3 fades in at the same time as logo2 (same whiteController)
    _logo3Fade = CurvedAnimation(
      parent: _whiteController,
      curve: Curves.easeIn,
    );

    _loginFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _startAnimation();
  }

  Future<void> _startAnimation() async {
    _blueController.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    _whiteController.forward();
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => showLogin = true);
      _loginFadeController.forward();
    }
  }

  void _onNext() {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      setState(() => _errorText = "Утасны дугаараа оруулна уу");
      return;
    }
    setState(() => _errorText = null);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PasswordPage(phoneNumber: phone),
      ),
    );
  }

  @override
  void dispose() {
    _blueController.dispose();
    _whiteController.dispose();
    _loginFadeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 30,
              left: 24,
              right: 24,
              child: Column(
                children: [
                  // logo1 fades in (blue), logo2 drops in (white) — same as before
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      FadeTransition(
                        opacity: _blueFade,
                        child: Image.asset("assets/images/logo1.png", width: 150),
                      ),
                      AnimatedBuilder(
                        animation: _whiteController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _whiteDrop.value),
                            child: Image.asset("assets/images/logo2.png", width: 150),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // logo3 fades in at the same time as logo2, no drop
                  FadeTransition(
                    opacity: _logo3Fade,
                    child: Image.asset("assets/images/logo3.png", width: 150),
                  ),
                ],
              ),
            ),
            if (showLogin)
              FadeTransition(
                opacity: _loginFadeController,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 600),
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        onSubmitted: (_) => _onNext(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          prefixIcon: const Icon(Icons.person),
                          hintText: "Утасны дугаараа бичнэ үү",
                          errorText: _errorText,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 0, 113, 219),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: _onNext,
                          child: const Text(
                            "Үргэлжлүүлэх",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                          children: [
                            TextSpan(text: "Нэвтэрч орсноор та манай "),
                            TextSpan(
                              text: "Үйлчилгээний нөхцөл",
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 113, 219),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(text: " болон "),
                            TextSpan(
                              text: "Нууцлагийн бодлогыг",
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 113, 219),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(text: " зөвшөөрч байна"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}