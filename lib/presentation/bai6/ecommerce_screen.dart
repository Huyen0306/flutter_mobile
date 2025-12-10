import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EcommerceScreen extends StatelessWidget {
  const EcommerceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Bài tập 6: Thương mại điện tử',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.blue, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Text('Nội dung Bài tập 6'),
      ),
    );
  }
}
