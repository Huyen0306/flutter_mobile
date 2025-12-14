import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:ui';
import 'package:iconsax/iconsax.dart';

const Color kPrimaryColor = Color(0xFFec003f);

// -----------------------------------------------------------------------------
// MODEL
// -----------------------------------------------------------------------------
class User {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      gender: json['gender'] ?? '',
      image: json['image'] ?? 'https://robohash.org/placeholder.png',
    );
  }

  String get fullName => '$firstName $lastName';
}

// -----------------------------------------------------------------------------
// SCREEN
// -----------------------------------------------------------------------------
class LoginProfileScreen extends StatefulWidget {
  const LoginProfileScreen({super.key});

  @override
  State<LoginProfileScreen> createState() => _LoginProfileScreenState();
}

class _LoginProfileScreenState extends State<LoginProfileScreen> {
  final Dio _dio = Dio();

  // State
  bool _isLoading = false;
  User? _currentUser;
  String? _accessToken;
  String? _refreshToken;

  // Controllers
  final TextEditingController _usernameController = TextEditingController(
    text: 'emilys',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: 'emilyspass',
  );
  bool _obscurePassword = true;

  // ---------------------------------------------------------------------------
  // API METHODS
  // ---------------------------------------------------------------------------

  Future<void> _login() async {
    setState(() => _isLoading = true);
    try {
      final response = await _dio.post(
        'https://dummyjson.com/auth/login',
        data: {
          'username': _usernameController.text,
          'password': _passwordController.text,
          'expiresInMins': 30,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
          _accessToken =
              data['token']; // DummyJSON returns 'token' or 'accessToken'? Docs say accessToken but sometimes it's token. Let's check response structure usually.
          // Actually dummyjson returns 'token' (jwt) AND 'refreshToken'.
          // Wait, recent docs say 'accessToken' and 'refreshToken'. Let's trust standard but handle flexibility if needed.
          // For safety, let's grab 'accessToken' ?? 'token'.
          _accessToken = data['accessToken'] ?? data['token'];
          _refreshToken = data['refreshToken'];

          _currentUser = User.fromJson(data);
        });
        _showSnackBar('Đăng nhập thành công!', Colors.green);
      }
    } catch (e) {
      _showSnackBar('Đăng nhập thất bại: ${e.toString()}', Colors.red);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _refreshTokenFunc() async {
    if (_refreshToken == null) return;
    setState(() => _isLoading = true);
    try {
      final response = await _dio.post(
        'https://dummyjson.com/auth/refresh',
        data: {'refreshToken': _refreshToken, 'expiresInMins': 30},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
          _accessToken = data['accessToken'] ?? data['token'];
          _refreshToken = data['refreshToken'];
        });
        _showSnackBar('Đã làm mới Token!', Colors.green);
      }
    } catch (e) {
      _showSnackBar(
        'Làm mới thất bại: Phiên đăng nhập có thể đã hết hạn',
        Colors.red,
      );
      _logout();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _logout() {
    setState(() {
      _accessToken = null;
      _refreshToken = null;

      _currentUser = null;
      _usernameController.text = 'emilys';
      _passwordController.text = 'emilyspass';
    });
    _showSnackBar('Đã đăng xuất', Colors.black54);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // UI BUILD
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    // Determine screen content based on login state
    final isLogged = _currentUser != null && _accessToken != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isLogged
          ? null
          : AppBar(
              title: const Text(
                'Bài tập 8',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(
                  Iconsax.arrow_left_2,
                  color: Colors.black,
                  size: 22,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
      body: isLogged ? _buildProfileView() : SafeArea(child: _buildLoginView()),
    );
  }

  // --- Login View ---
  // --- Login View ---
  Widget _buildLoginView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Đăng nhập",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Chào mừng trở lại, chúng tôi rất nhớ bạn",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 40),

          // Username
          const Text(
            "Tên đăng nhập",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _usernameController,
            decoration: _inputDecoration("Nhập tên đăng nhập"),
          ),
          const SizedBox(height: 20),

          // Password
          const Text("Mật khẩu", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: _inputDecoration("Nhập mật khẩu").copyWith(
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Iconsax.eye_slash : Iconsax.eye,
                  color: Colors.grey,
                  size: 20,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
          ),

          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Checkbox(
                  value: true, // Dummy value for demonstration
                  activeColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  onChanged: (val) {},
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "Ghi nhớ đăng nhập",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "Quên mật khẩu?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Login Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      "Đăng nhập",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),

          const SizedBox(height: 30),

          const SizedBox(height: 24),

          // Demo Hint
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                "Demo: emilys / emilyspass",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ),

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(color: Colors.grey[600]),
              ),
              GestureDetector(
                onTap: () {
                  _showSnackBar(
                    "Chức năng đăng ký chưa được thực hiện",
                    Colors.black54,
                  );
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Profile View ---
  Widget _buildProfileView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          // Avatar & Info
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/flutter1.png'),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _currentUser!.fullName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Iconsax.edit, size: 20, color: Colors.black),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  _currentUser!.email,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _logout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFF0F3), // Light Red
                    foregroundColor: const Color(0xFFFF3B30), // Red Text
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Log out",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _refreshTokenFunc,
                  icon: const Icon(Iconsax.refresh, size: 20),
                  label: const Text("Refresh Token"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Colors.grey.shade300),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Sections
          _buildSectionCard(
            title: "CONTACT",
            icon: Iconsax.user,
            children: [
              _buildRowItem(_currentUser!.email),
              const SizedBox(height: 12),
              _buildRowItem("+62 893 9999 9999"),
            ],
          ),
          const SizedBox(height: 20),
          _buildSectionCard(
            title: "PASSWORD",
            icon: Iconsax.lock,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "••••••••",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const Icon(Iconsax.eye_slash, size: 20, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "2FA Authentication",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Switch(
                    value: true,
                    onChanged: (val) {},
                    activeColor: const Color(0xFF5D3FD3), // Purple
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Colors.green[800]),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildRowItem(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const Icon(Icons.more_vert, size: 20, color: Colors.grey),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// HELPER WIDGETS (Shared styling)
// -----------------------------------------------------------------------------

InputDecoration _inputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: kPrimaryColor, width: 1.2),
    ),
  );
}
