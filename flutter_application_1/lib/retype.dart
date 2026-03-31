import 'package:flutter/material.dart';
import 'accepted.dart';

class RetypePasswordPage extends StatefulWidget {
  final String phoneNumber;
  const RetypePasswordPage({super.key, required this.phoneNumber});

  @override
  State<RetypePasswordPage> createState() => _RetypePasswordPageState();
}

class _RetypePasswordPageState extends State<RetypePasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  String? _passwordError;
  String? _confirmError;

  void _onSave() {
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    setState(() {
      _passwordError = null;
      _confirmError = null;
    });

    if (password.isEmpty) {
      setState(() => _passwordError = "Нууц үгээ оруулна уу");
      return;
    }
    if (password.length < 6) {
      setState(() => _passwordError = "Нууц үг хамгийн багадаа 6 тэмдэгт байна");
      return;
    }
    if (confirm.isEmpty) {
      setState(() => _confirmError = "Нууц үгийг давтана уу");
      return;
    }
    if (password != confirm) {
      setState(() => _confirmError = "Нууц үг таарахгүй байна");
      return;
    }

    // ✅ Navigate to AcceptedPage (replaces this page so back won't return here)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const AcceptedPage()),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
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
            _buildAppBar(context),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF007AFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.chevron_left,
                    color: Colors.white, size: 24),
              ),
            ),
          ),
          const Text(
            'Бүртгүүлэх',
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              '2/2',
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),

          // Icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0FE),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.password_outlined,
                color: Color(0xFF007AFF), size: 32),
          ),

          const SizedBox(height: 20),

          // Hint text
          const Text(
            'Аюулгүй байдлын үүднээс тоо болон\nтэмдэгт ашиглахыг зөвлөж байна.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black54, height: 1.6),
          ),

          const SizedBox(height: 36),

          // New password field
          TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.password_outlined,
                  color: Colors.black45, size: 20),
              hintText: 'Нууц үг',
              hintStyle: const TextStyle(color: Colors.black38),
              errorText: _passwordError,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black54,
                  size: 22,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Color(0xFFCCCCCC), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:
                    const BorderSide(color: Color(0xFF007AFF), width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Confirm password field
          TextField(
            controller: _confirmController,
            obscureText: _obscureConfirm,
            onSubmitted: (_) => _onSave(),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.password_outlined,
                  color: Colors.black45, size: 20),
              hintText: 'Нууц үг давтах',
              hintStyle: const TextStyle(color: Colors.black38),
              errorText: _confirmError,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                  color: Colors.black54,
                  size: 22,
                ),
                onPressed: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Color(0xFFCCCCCC), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:
                    const BorderSide(color: Color(0xFF007AFF), width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Save button
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF007AFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              onPressed: _onSave,
              child: const Text(
                'Хадаглах',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}