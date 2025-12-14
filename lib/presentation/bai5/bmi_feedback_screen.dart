import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../widgets/app_drawer.dart';
import '../widgets/custom_menu_button.dart';

const Color kPrimaryColor = Color(0xFFec003f);

class BmiFeedbackScreen extends StatefulWidget {
  const BmiFeedbackScreen({super.key});

  @override
  State<BmiFeedbackScreen> createState() => _BmiFeedbackScreenState();
}

class _BmiFeedbackScreenState extends State<BmiFeedbackScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 60,
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Toggle Menu (Tab Selector)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildTabButton(
                          index: 0,
                          label: 'Tính BMI',
                          isSelected: _selectedIndex == 0,
                          onTap: () => setState(() => _selectedIndex = 0),
                        ),
                      ),
                      Expanded(
                        child: _buildTabButton(
                          index: 1,
                          label: 'Gửi Phản hồi',
                          isSelected: _selectedIndex == 1,
                          onTap: () => setState(() => _selectedIndex = 1),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _selectedIndex == 0
                        ? const BmiCalculatorWidget()
                        : const FeedbackWidget(),
                  ),
                ),
              ],
            ),
          ),
          const FloatingMenuButton(),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required int index,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isSelected ? kPrimaryColor : Colors.black54,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// UI COMPONENTS
// -----------------------------------------------------------------------------

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[50],
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        prefixIcon: Icon(icon, color: kPrimaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: kPrimaryColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
      validator: validator,
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.label,
    this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// BMI CALCULATOR
// -----------------------------------------------------------------------------

class BmiCalculatorWidget extends StatefulWidget {
  const BmiCalculatorWidget({super.key});

  @override
  State<BmiCalculatorWidget> createState() => _BmiCalculatorWidgetState();
}

class _BmiCalculatorWidgetState extends State<BmiCalculatorWidget> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  double? _bmi;
  String _message = '';

  void _calculateBMI() {
    if (_formKey.currentState!.validate()) {
      double height = double.parse(_heightController.text);
      double weight = double.parse(_weightController.text);

      setState(() {
        _bmi = weight / (height * height);

        if (_bmi! < 18.5) {
          _message = 'Gầy - Cần bổ sung dinh dưỡng!';
        } else if (_bmi! < 24.9) {
          _message = 'Bình thường - Hãy duy trì nhé!';
        } else if (_bmi! < 29.9) {
          _message = 'Thừa cân - Cần tập luyện hơn!';
        } else {
          _message = 'Béo phì - Cần chế độ ăn kiêng!';
        }
      });
    }
  }

  Color _getResultColor() {
    if (_bmi == null) return Colors.black;
    if (_bmi! < 18.5) return Colors.orange;
    if (_bmi! < 24.9) return Colors.green;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(Iconsax.health5, size: 50, color: kPrimaryColor),
                  const SizedBox(height: 10),
                  const Text(
                    "Kiểm tra chỉ số cơ thể",
                    style: TextStyle(
                      fontSize: 16,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            CustomTextField(
              label: 'Chiều cao (m)',
              icon: Iconsax.ruler,
              controller: _heightController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Nhập chiều cao';
                if (double.tryParse(value) == null) return 'Phải là số';
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Cân nặng (kg)',
              icon: Iconsax.weight,
              controller: _weightController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Nhập cân nặng';
                if (double.tryParse(value) == null) return 'Phải là số';
                return null;
              },
            ),
            const SizedBox(height: 30),
            CustomButton(
              label: 'Tính BMI',
              icon: Iconsax.calculator,
              onPressed: _calculateBMI,
            ),
            const SizedBox(height: 40),
            if (_bmi != null) ...[
              Text(
                'Chỉ số BMI: ${_bmi!.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _getResultColor(),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: _getResultColor(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// FEEDBACK WIDGET
// -----------------------------------------------------------------------------

class FeedbackWidget extends StatefulWidget {
  const FeedbackWidget({super.key});

  @override
  State<FeedbackWidget> createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  final _formKey = GlobalKey<FormState>();
  double _rating = 5;
  final _nameController = TextEditingController();
  final _feedbackController = TextEditingController();

  void _sendFeedback() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Cảm ơn ${_nameController.text} đã gửi đánh giá $_rating sao!',
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(
                    Iconsax.message_favorite,
                    size: 50,
                    color: kPrimaryColor,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Gửi ý kiến đóng góp",
                    style: TextStyle(
                      fontSize: 16,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            CustomTextField(
              label: 'Họ và tên',
              icon: Iconsax.user,
              controller: _nameController,
              validator: (v) => v!.isEmpty ? 'Vui lòng nhập tên' : null,
            ),
            const SizedBox(height: 20),
            // Star Rating
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50], // Match input fill color
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Đánh giá của bạn",
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _rating = index + 1;
                          });
                        },
                        child: Icon(
                          index < _rating ? Iconsax.star1 : Iconsax.star,
                          color: index < _rating
                              ? Colors.amber
                              : Colors.grey[300],
                          size: 32,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Nội dung góp ý',
              icon: Iconsax.edit,
              controller: _feedbackController,
              maxLines: 4,
              validator: (v) => v!.isEmpty ? 'Vui lòng nhập nội dung' : null,
            ),
            const SizedBox(height: 30),
            CustomButton(
              label: 'Gửi Phản hồi',
              icon: Iconsax.send_2,
              onPressed: _sendFeedback,
            ),
          ],
        ),
      ),
    );
  }
}
