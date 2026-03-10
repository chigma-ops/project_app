import 'package:flutter/material.dart';

class PasswordPage extends StatefulWidget {
  final String phoneNumber;
  const PasswordPage({super.key, required this.phoneNumber});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;
  String? _errorText;

  void _onLogin() {
    final password = _passwordController.text.trim();
    if (password.isEmpty) {
      setState(() => _errorText = "Нууц үгээ оруулна уу");
      return;
    }
    setState(() => _errorText = null);
    // TODO: handle actual login logic here
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [

            /// LOGO at top
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset("assets/images/logo1.png", width: 150),
                  Image.asset("assets/images/logo2.png", width: 150),
                ],
              ),
            ),

            /// Pushes form to the bottom
            const Spacer(),

            /// FORM at bottom
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [

                  /// Phone number subtitle
                  Text(
                    widget.phoneNumber,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Password field
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscure,
                    onSubmitted: (_) => _onLogin(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      prefixIcon: const Icon(Icons.lock_outline),
                      hintText: "Нууц үгээ бичнэ үү",
                      errorText: _errorText,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  /// Forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Нууц үг мартсан?",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 113, 219),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Login button
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
                      onPressed: _onLogin,
                      child: const Text(
                        "Нэвтрэх",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Terms text
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
          ],
        ),
      ),
    );
  }
}