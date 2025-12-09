import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String? username;

  const HomePage({super.key, this.username});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'مرحباً ${username ?? 'مستخدم'} 👋',
        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      ),
    );
  }
}
