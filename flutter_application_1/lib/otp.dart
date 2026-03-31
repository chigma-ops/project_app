import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'retype.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  const OtpPage({super.key, required this.phoneNumber});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final int _otpLength = 4;
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  // ── Correct OTP ───────────────────────────────────────────────────────────
  static const String _correctOtp = '1234';

  String? _errorText;

  int _secondsRemaining = 120;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(_otpLength, (_) => FocusNode());
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.unfocus();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _canResend = false;
      _secondsRemaining = 120;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  String get _timerText {
    final m = _secondsRemaining ~/ 60;
    final s = _secondsRemaining % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  void _onChanged(String value, int index) {
    setState(() => _errorText = null);
    if (value.length == 1) {
      if (index < _otpLength - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        _onVerify();
      }
    }
  }

  void _onKeyPress(RawKeyEvent event, int index) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].clear();
    }
  }

  void _onVerify() {
    final otp = _controllers.map((c) => c.text).join();
    if (otp.length < _otpLength) return;

    if (otp == _correctOtp) {
      // ✅ Navigate to retype password page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RetypePasswordPage(phoneNumber: widget.phoneNumber),
        ),
      );
    } else {
      setState(() => _errorText = "Код буруу байна. Дахин оруулна уу.");
      // Clear all boxes and re-focus first
      for (final c in _controllers) c.clear();
      _focusNodes[0].requestFocus();
    }
  }

  void _onResend() {
    _startTimer();
    setState(() => _errorText = null);
    for (final c in _controllers) c.clear();
    _focusNodes[0].requestFocus();
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
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              '1/2',
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
            child: const Icon(Icons.sms_outlined,
                color: Color(0xFF007AFF), size: 32),
          ),

          const SizedBox(height: 20),

          // Instruction
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF007AFF),
                height: 1.5,
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFF007AFF),
              ),
              children: [
                TextSpan(
                  text:
                      '${widget.phoneNumber} дугаарт илгээсэн 4 оронтой баталгаажуулах кодыг оруулна уу.',
                ),
              ],
            ),
          ),

          const SizedBox(height: 36),

          // OTP boxes
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_otpLength, (i) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 60,
                height: 60,
                child: RawKeyboardListener(
                  focusNode: FocusNode(),
                  onKey: (event) => _onKeyPress(event, i),
                  child: TextField(
                    controller: _controllers[i],
                    focusNode: _focusNodes[i],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Color(0xFF007AFF), width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Color(0xFF007AFF), width: 2.5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                      ),
                    ),
                    onChanged: (value) => _onChanged(value, i),
                  ),
                ),
              );
            }),
          ),

          // Error message
          if (_errorText != null) ...[
            const SizedBox(height: 12),
            Text(
              _errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],

          const SizedBox(height: 32),

          // Timer / resend
          _canResend
              ? GestureDetector(
                  onTap: _onResend,
                  child: const Text(
                    'Код дахин авах',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF007AFF),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : RichText(
                  text: TextSpan(
                    style:
                        const TextStyle(fontSize: 15, color: Colors.black45),
                    children: [
                      const TextSpan(text: 'Код дахин авах '),
                      TextSpan(
                        text: _timerText,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}