import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  bool _isLogin = true; // Default to Login

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Bài tập 4',
           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.blue, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
         actions: [
          // Toggle button to switch between forms for testing
          TextButton(
            onPressed: () {
              setState(() {
                _isLogin = !_isLogin;
              });
            },
            child: Text(
              _isLogin ? 'Đăng ký' : 'Đăng nhập',
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Custom Header matching the image
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: const Color(0xFF4FC3F7), // Light blue color
              child: Center(
                child: Text(
                  _isLogin ? 'Form đăng nhập' : 'Form Đăng ký tài khoản',
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _isLogin ? const LoginForm() : const RegisterForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          _buildTextField(
            label: 'Tên người dùng',
            icon: Icons.person,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập tên người dùng';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildTextField(
            label: 'Mật khẩu',
            icon: Icons.lock,
            isPassword: true,
            obscureText: _obscurePassword,
            onToggleVisibility: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'Vui lòng nhập mật khẩu có >= 6 kí tự';
              }
              return null;
            },
          ),
          const SizedBox(height: 40),
          _buildButton(
            label: 'Đăng nhập',
            icon: Icons.login,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Handle login
              }
            },
          ),
        ],
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          _buildTextField(
            label: 'Họ tên',
            icon: Icons.person,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập Họ tên';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildTextField(
            label: 'Email',
            icon: Icons.email,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập Email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildTextField(
            label: 'Mật khẩu',
            icon: Icons.lock,
            isPassword: true,
            controller: _passwordController,
            obscureText: _obscurePassword,
            onToggleVisibility: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập Mật khẩu';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildTextField(
            label: 'Xác minh mật khẩu',
            icon: Icons.lock_outline,
            isPassword: true,
            obscureText: _obscureConfirmPassword,
            onToggleVisibility: () {
              setState(() {
                _obscureConfirmPassword = !_obscureConfirmPassword;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng xác nhận mật khẩu';
              }
              if (value != _passwordController.text) {
                return 'Mật khẩu không khớp';
              }
              return null;
            },
          ),
          const SizedBox(height: 40),
          _buildButton(
            label: 'Đăng ký',
            icon: Icons.person_add,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Handle registration
              }
            },
          ),
        ],
      ),
    );
  }
}

Widget _buildTextField({
  required String label,
  required IconData icon,
  bool isPassword = false,
  bool obscureText = false,
  VoidCallback? onToggleVisibility,
  String? Function(String?)? validator,
  TextEditingController? controller,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        prefixIcon: Icon(icon, color: Colors.blue),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.blue,
                ),
                onPressed: onToggleVisibility,
              )
            : null,
        border: InputBorder.none,
        errorStyle: const TextStyle(color: Colors.red),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      validator: validator,
    ),
  );
}

Widget _buildButton({
  required String label,
  required IconData icon,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    width: 200,
    height: 50,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4FC3F7), // Light Blue
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.indigo), // Icon color inside button
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.indigo, // Text color inside button
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}
