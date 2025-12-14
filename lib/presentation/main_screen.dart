import 'package:flutter/material.dart';
import 'widgets/app_drawer.dart';
import 'widgets/custom_menu_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: Builder(
        builder: (context) => Stack(
          children: [
            // 3 phần ảnh, mỗi phần 33%
            Column(
              children: [
                // Phần 1 - 33%
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/flutter1.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                // Phần 2 - 33%
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/flutter2.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                // Phần 3 - 33%
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/flutter3.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
            // Menu button at top left
            const FloatingMenuButton(),
          ],
        ),
      ),
    );
  }
}
