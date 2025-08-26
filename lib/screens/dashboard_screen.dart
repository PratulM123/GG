import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class DashboardScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () async {
              await _authService.signOut();
              if (!context.mounted) return;
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Welcome!'),
            const SizedBox(height: 12),
            if (user != null) ...[
              Text('UID: ${user.uid}'),
              const SizedBox(height: 6),
              Text('Name: ${user.displayName ?? '-'}'),
              const SizedBox(height: 6),
              Text('Email: ${user.email ?? '-'}'),
            ],
          ],
        ),
      ),
    );
  }
}


