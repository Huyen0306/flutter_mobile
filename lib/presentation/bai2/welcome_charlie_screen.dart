import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class WelcomeCharlieScreen extends StatelessWidget {
  const WelcomeCharlieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.notification, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Iconsax.element_plus,
              color: Colors.black,
            ), // Giống hình mảnh ghép/menu
            onPressed: () {},
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Header Title
            const Text(
              'Welcome,\nCharlie',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                height: 1.2,
                color: Color(0xFF2D3436),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 30),

            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  prefixIcon: Icon(Iconsax.search_normal, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Saved Places Header
            const Text(
              'Saved Places',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D3436),
              ),
            ),

            const SizedBox(height: 20),

            // Grid of Places
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio:
                    1.4, // Điều chỉnh tỷ lệ để phù hợp với hình ảnh hơn
                children: [
                  _buildPlaceCard(imagePath: 'assets/images/noel_1.png'),
                  _buildPlaceCard(imagePath: 'assets/images/noel_2.png'),
                  _buildPlaceCard(imagePath: 'assets/images/noel_3.png'),
                  _buildPlaceCard(imagePath: 'assets/images/noel_4.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceCard({required String imagePath}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
    );
  }
}
