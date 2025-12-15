import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/custom_menu_button.dart';
import 'login_form.dart';
import 'register_form.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  bool _isLogin = true;

  void _toggleForm() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const AppDrawer(activeIndex: 4),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: MediaQuery.of(context).padding.top + 80,
              bottom: 10,
            ),
            child: _isLogin
                ? LoginForm(onRegisterTap: _toggleForm)
                : RegisterForm(onLoginTap: _toggleForm),
          ),
          const FloatingMenuButton(),
        ],
      ),
    );
  }
}
