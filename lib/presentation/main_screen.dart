import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'bai1/home_classroom_screen.dart';
import 'bai2/welcome_charlie_screen.dart';
import 'bai3/timer_counter_screen.dart';
import 'bai4/login_register_screen.dart';
import 'bai5/bmi_feedback_screen.dart';
import 'bai6/ecommerce_screen.dart';
import 'bai7/ecommerce_detail_screen.dart';
import 'bai8/login_profile_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Iconsax.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          'Danh sách bài tập',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: 80),
              _buildExerciseCard(
                icon: Iconsax.home,
                title: 'Bài tập 1: Home Classroom',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeClassroomScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              _buildExerciseCard(
                icon: Iconsax.user,
                title: 'Bài tập 2: Welcome Charlie',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeCharlieScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              _buildExerciseCard(
                icon: Iconsax.timer_1,
                title: 'Bài tập 3: Bộ đếm thời gian & Đếm số',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TimerCounterScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              _buildExerciseCard(
                icon: Iconsax.login,
                title: 'Bài tập 4: Form Login và Register',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginRegisterScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              _buildExerciseCard(
                icon: Iconsax.health,
                title: 'Bài tập 5: Bài tập BMI & Gửi phản hồi',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BmiFeedbackScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              _buildExerciseCard(
                icon: Iconsax.shopping_cart,
                title: 'Bài tập 6: Thương mại điện tử - WebAPI',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EcommerceScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              _buildExerciseCard(
                icon: Iconsax.box,
                title:
                    'Bài tập 7: Thương mại điện tử & Chi tiết sản phẩm - WebAPI',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EcommerceDetailScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              _buildExerciseCard(
                icon: Iconsax.profile_circle,
                title: 'Bài tập 8: Login & Profile',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
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
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey.withOpacity(0.015),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildExerciseCard(
                icon: Iconsax.home,
                title: 'Bài tập 1: Home Classroom',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeClassroomScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              _buildExerciseCard(
                icon: Iconsax.user,
                title: 'Bài tập 2: Welcome Charlie',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeCharlieScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              _buildExerciseCard(
                icon: Iconsax.timer_1,
                title: 'Bài tập 3: Bộ đếm thời gian & Đếm số',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TimerCounterScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              _buildExerciseCard(
                icon: Iconsax.login,
                title: 'Bài tập 4: Form Login và Register',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginRegisterScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              _buildExerciseCard(
                icon: Iconsax.health,
                title: 'Bài tập 5: Bài tập BMI & Gửi phản hồi',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BmiFeedbackScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              _buildExerciseCard(
                icon: Iconsax.shopping_cart,
                title: 'Bài tập 6: Thương mại điện tử - WebAPI',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EcommerceScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              _buildExerciseCard(
                icon: Iconsax.box,
                title:
                    'Bài tập 7: Thương mại điện tử & Chi tiết sản phẩm - WebAPI',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EcommerceDetailScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              _buildExerciseCard(
                icon: Iconsax.profile_circle,
                title: 'Bài tập 8: Login & Profile',
                onTap: () {
                  Navigator.push(
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
      ),
    );
  }

  Widget _buildExerciseCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.blue.withOpacity(0.5),
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.blue, size: 24),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(Iconsax.arrow_right_3, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}
