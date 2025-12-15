import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:iconsax/iconsax.dart';
import '../../constants/app_colors.dart';
import '../main_screen.dart';
import '../bai1/home_classroom_screen.dart';
import '../bai2/welcome_charlie_screen.dart';
import '../bai3/timer_counter_screen.dart';
import '../bai4/login_register_screen.dart';
import '../bai5/bmi_feedback_screen.dart';
import '../bai6/ecommerce_screen.dart';
import '../bai7/new_api_screen.dart';
import '../bai8/login_profile_screen.dart';

class AppDrawer extends StatelessWidget {
  final int activeIndex;

  const AppDrawer({super.key, this.activeIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          // Header
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.textMuted,
                    AppColors.white.withOpacity(0.8),
                    AppColors.primary.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 50,
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/images/user.png'),
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nguyễn Thị Huyền",
                            style: TextStyle(
                              color: AppColors.text,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Welcome back",
                            style: TextStyle(
                              color: AppColors.text,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 20),
              children: [
                _buildDrawerItem(
                  icon: Iconsax.home,
                  title: "Trang chủ",
                  onTap: () {
                    if (activeIndex != 0) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(),
                        ),
                      );
                    } else {
                      Navigator.pop(context); // Close drawer if already on Home
                    }
                  },
                  isActive: activeIndex == 0,
                ),
                ...[
                  {'title': 'Classroom', 'icon': Iconsax.book},
                  {
                    'title': 'Welcome Charlie',
                    'icon': Iconsax.message_favorite,
                  },
                  {'title': 'Timer & Counter', 'icon': Iconsax.timer_1},
                  {'title': 'Login & Register', 'icon': Iconsax.login},
                  {'title': 'BMI & Feedback', 'icon': Iconsax.health},
                  {'title': 'E-Commerce', 'icon': Iconsax.shopping_cart},
                  {'title': 'News API', 'icon': Iconsax.global},
                  {'title': 'Login & Profile', 'icon': Iconsax.profile_circle},
                ].asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return _buildDrawerItem(
                    icon: item['icon'] as IconData,
                    title: item['title'] as String,
                    isActive: activeIndex == index + 1,
                    onTap: () {
                      if (activeIndex != index + 1) {
                        Navigator.pop(context); // Close drawer
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              switch (index) {
                                case 0:
                                  return const HomeClassroomScreen();
                                case 1:
                                  return const WelcomeCharlieScreen();
                                case 2:
                                  return const TimerCounterScreen();
                                case 3:
                                  return const LoginRegisterScreen();
                                case 4:
                                  return const BmiFeedbackScreen();
                                case 5:
                                  return const EcommerceScreen();
                                case 6:
                                  return const NewApiScreen();
                                case 7:
                                  return const LoginProfileScreen();
                                default:
                                  return const Scaffold(
                                    body: Center(child: Text("Error")),
                                  );
                              }
                            },
                          ),
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  );
                }),
                const SizedBox(height: 36),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isActive = false,
    bool isLogout = false,
  }) {
    if (isLogout) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(15),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Icon(icon, color: Colors.red, size: 24),
                  const SizedBox(width: 20),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ), // Added margin to match list spacing
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFFec003f).withOpacity(0.05)
              : Colors.white, // Highlight active item subtly
          borderRadius: BorderRadius.circular(12),
          border: Border(
            left: BorderSide(
              color: const Color(0xFFec003f),
              width: 1.8 * 1.618,
            ),
            bottom: BorderSide(
              color: const Color(0xFFec003f),
              width: 1.8 * 1.618,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFec003f).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: const Color(0xFFec003f), size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.textMuted.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Iconsax.arrow_right_1,
                color: AppColors.primary,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
