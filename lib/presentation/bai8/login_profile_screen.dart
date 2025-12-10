import 'package:flutter/material.dart';

class LoginProfileScreen extends StatelessWidget {
  const LoginProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài tập 8: Login & Profile'),
      ),
      body: const Center(
        child: Text('Nội dung Bài tập 8'),
      ),
    );
  }
}
