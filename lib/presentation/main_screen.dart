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
            
            Column(
              children: [
                
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/flutter1.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/flutter2.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                
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
            
            const FloatingMenuButton(),
          ],
        ),
      ),
    );
  }
}
