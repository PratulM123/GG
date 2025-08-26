import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  final VoidCallback? onGoogle;
  final VoidCallback? onFacebook;
  final VoidCallback? onApple;

  const SocialButtons({super.key, this.onGoogle, this.onFacebook, this.onApple});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          tooltip: 'Continue with Google',
          icon: const Icon(Icons.g_mobiledata, size: 32, color: Colors.redAccent),
          onPressed: onGoogle,
        ),
        IconButton(
          tooltip: 'Continue with Facebook',
          icon: const Icon(Icons.facebook, size: 28, color: Colors.blue),
          onPressed: onFacebook,
        ),
        IconButton(
          tooltip: 'Continue with Apple',
          icon: const Icon(Icons.apple, size: 28, color: Colors.black87),
          onPressed: onApple,
        ),
      ],
    );
  }
}


