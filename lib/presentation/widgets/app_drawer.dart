import 'package:flutter/material.dart';
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.white,
                  AppColors.primary.withOpacity(0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: const Icon(
                    Iconsax.user,
                    color: AppColors.text,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 15),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, User",
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Welcome back",
                      style: TextStyle(color: AppColors.text, fontSize: 14),
                    ),
                  ],
                ),
              ],
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
                ...List.generate(8, (index) {
                  return _buildDrawerItem(
                    icon: Iconsax.task_square,
                    title: "Bài tập ${index + 1}",
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
              ],
            ),
          ),

          // Logout Item
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _buildDrawerItem(
              icon: Iconsax.logout,
              title: "Đăng xuất",
              onTap: () {
                // Handle logout logic here
                Navigator.pop(context); // Just close drawer for now
              },
              isLogout: true,
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Material(
        color: isActive ? Colors.blue.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isLogout
                      ? Colors.red
                      : (isActive ? Colors.blue : Colors.grey),
                  size: 24,
                ),
                const SizedBox(width: 20),
                Text(
                  title,
                  style: TextStyle(
                    color: isLogout
                        ? Colors.red
                        : (isActive ? Colors.blue : Colors.black87),
                    fontSize: 16,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
