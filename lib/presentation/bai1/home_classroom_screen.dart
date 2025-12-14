import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../widgets/app_drawer.dart';
import '../widgets/custom_menu_button.dart';

class HomeClassroomScreen extends StatelessWidget {
  const HomeClassroomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> courses = [
      {
        'title': 'XML và ứng dụng - Nhóm 1',
        'code': '2025-2026.1.TIN4583.001',
        'students': '58 học viên',
        'imageUrl': 'assets/images/background_classroom_1.png',
        'gradientColors': [const Color(0xFF333333), const Color(0xFF454545)],
      },
      {
        'title': 'Lập trình Mobile Đa Nền Tảng',
        'code': '2025-2026.1.TIN4403.006',
        'students': '55 học viên',
        'imageUrl': 'assets/images/background_classroom_2.png',
        'gradientColors': [const Color(0xFF37474F), const Color(0xFF455A64)],
      },
      {
        'title': 'Phát triển Ứng dụng Web',
        'code': '2025-2026.1.TIN4403.005',
        'students': '52 học viên',
        'imageUrl': 'assets/images/background_classroom_3.png',
        'gradientColors': [const Color(0xFF263238), const Color(0xFF37474F)],
      },
      {
        'title': 'Nhập môn Trí tuệ Nhân tạo',
        'code': '2025-2026.1.TIN4403.004',
        'students': '50 học viên',
        'imageUrl': 'assets/images/background_classroom_4.png',
        'gradientColors': [const Color(0xFF1565C0), const Color(0xFF1976D2)],
      },
      {
        'title': 'Cấu trúc Dữ liệu và Giải thuật',
        'code': '2025-2026.1.TIN4403.003',
        'students': '52 học viên',
        'imageUrl': 'assets/images/background_classroom_1.png',
        'gradientColors': [const Color(0xFF212121), const Color(0xFF424242)],
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          // Content
          Positioned.fill(
            child: ListView.separated(
              padding: EdgeInsets.only(
                top:
                    MediaQuery.of(context).padding.top +
                    80, // Space for button/header
                left: 10,
                right: 10,
                bottom: 10,
              ),
              itemCount: courses.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final course = courses[index];
                return CourseCard(
                  title: course['title'],
                  code: course['code'],
                  studentCount: course['students'],
                  imageUrl: course['imageUrl'],
                  gradientColors: course['gradientColors'],
                );
              },
            ),
          ),
          const FloatingMenuButton(),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String title;
  final String code;
  final String studentCount;
  final String imageUrl;
  final List<Color> gradientColors;

  const CourseCard({
    super.key,
    required this.title,
    required this.code,
    required this.studentCount,
    required this.imageUrl,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[300],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // 1. Full Background Image
          Positioned.fill(
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.grey);
              },
            ),
          ),
          // 2. Gradient Overlay (Semi-transparent)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  // Use opacity to let the image show through as a background
                  colors: gradientColors
                      .map((c) => c.withOpacity(0.70))
                      .toList(),
                ),
              ),
            ),
          ),
          // 3. Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.more_horiz, color: Colors.white),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  code,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const Spacer(),
                Text(
                  studentCount,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
