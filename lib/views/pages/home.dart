import 'package:flutter/material.dart';
import 'package:project_kanso/auth/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService(); // access your auth service

    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),

      body: Center(
        child: ElevatedButton(
          onPressed: () {
            auth.signOut(); // 🔥 this logs the user out
          },
          child: const Text("Log Out"),
        ),
      ),
    );
  }
}
