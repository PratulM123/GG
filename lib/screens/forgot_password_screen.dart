import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final AuthService _authService = AuthService();
  bool _loading = false;

  Future<void> _sendReset() async {
    setState(() => _loading = true);
    try {
      await _authService.sendPasswordResetEmail(_emailCtrl.text.trim());
      Fluttertoast.showToast(msg: 'Password reset email sent');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to send reset email');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 360,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Enter your email to reset password'),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: _loading ? null : _sendReset,
                  style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48), backgroundColor: Colors.teal),
                  child: _loading ? const CircularProgressIndicator(color: Colors.white) : const Text('Send Reset Email'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


