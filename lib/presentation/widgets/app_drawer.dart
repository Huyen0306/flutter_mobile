import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../bai1/home_classroom_screen.dart';
import '../bai2/welcome_charlie_screen.dart';
import '../bai3/timer_counter_screen.dart';
import '../bai4/login_register_screen.dart';
import '../bai5/bmi_feedback_screen.dart';
import '../bai6/ecommerce_screen.dart';
import '../bai7/new_api_screen.dart';
import '../bai8/login_profile_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 50),
            _buildExerciseCard(
              context,
              icon: Iconsax.home,
              title: 'Bài tập 1: Home Classroom',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeClassroomScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildExerciseCard(
              context,
              icon: Iconsax.user,
              title: 'Bài tập 2: Welcome Charlie',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomeCharlieScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildExerciseCard(
              context,
              icon: Iconsax.timer_1,
              title: 'Bài tập 3: Bộ đếm thời gian & Đếm số',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TimerCounterScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildExerciseCard(
              context,
              icon: Iconsax.login,
              title: 'Bài tập 4: Form Login và Register',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginRegisterScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildExerciseCard(
              context,
              icon: Iconsax.health,
              title: 'Bài tập 5: Bài tập BMI & Gửi phản hồi',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BmiFeedbackScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildExerciseCard(
              context,
              icon: Iconsax.shopping_cart,
              title: 'Bài tập 6: Thương mại điện tử',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EcommerceScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildExerciseCard(
              context,
              icon: Iconsax.global,
              title: 'Bài tập 7: Tin Tức - WebAPI',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const NewApiScreen()),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildExerciseCard(
              context,
              icon: Iconsax.profile_circle,
              title: 'Bài tập 8: Login & Profile',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginProfileScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border(
            left: BorderSide(
              color: const Color(0xFFec003f).withOpacity(0.5),
              width: 2 * 1.618,
            ),
            bottom: BorderSide(
              color: const Color(0xFFec003f).withOpacity(0.5),
              width: 2 * 1.618,
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
                color: const Color(0xFFec003f).withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Iconsax.arrow_right_1,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
