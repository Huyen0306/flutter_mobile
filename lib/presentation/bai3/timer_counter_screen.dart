import 'dart:async';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile_test/constants/app_colors.dart';
import '../widgets/app_drawer.dart';
import '../widgets/custom_menu_button.dart';

const Color kPrimaryColor = Color(0xFFec003f);

class TimerCounterScreen extends StatefulWidget {
  const TimerCounterScreen({super.key});

  @override
  State<TimerCounterScreen> createState() => _TimerCounterScreenState();
}

class _TimerCounterScreenState extends State<TimerCounterScreen> {
  int _selectedIndex = 0;
  Color _selectedColor = Colors.pinkAccent;
  String _selectedColorName = 'HỒNG';

  void _onColorChanged(Color color, String name) {
    setState(() {
      _selectedColor = color;
      _selectedColorName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const AppDrawer(activeIndex: 3),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          color: _selectedIndex == 2 ? _selectedColor : Colors.white,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 60,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _selectedIndex == 2
                            ? Colors.white.withOpacity(0.2)
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _selectedIndex = 0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: _selectedIndex == 0
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: _selectedIndex == 0
                                      ? [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                      : [],
                                ),
                                child: Center(
                                  child: Text(
                                    'Timer',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: _selectedIndex == 0
                                          ? kPrimaryColor
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _selectedIndex = 1),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: _selectedIndex == 1
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: _selectedIndex == 1
                                      ? [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                      : [],
                                ),
                                child: Center(
                                  child: Text(
                                    'Counter',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: _selectedIndex == 1
                                          ? kPrimaryColor
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _selectedIndex = 2),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: _selectedIndex == 2
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: _selectedIndex == 2
                                      ? [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                      : [],
                                ),
                                child: Center(
                                  child: Text(
                                    'Màu sắc',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: _selectedIndex == 2
                                          ? kPrimaryColor
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: _selectedIndex == 0
                          ? const TimerWidget()
                          : _selectedIndex == 1
                          ? const CounterWidget()
                          : ColorChangerWidget(
                              color: _selectedColor,
                              name: _selectedColorName,
                              onChanged: _onColorChanged,
                            ),
                    ),
                  ],
                ),
              ),
              const FloatingMenuButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int _seconds = 0;
  Timer? _timer;
  bool _isRunning = false;
  final TextEditingController _controller = TextEditingController();
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
  }

  void _startTimer() {
    FocusScope.of(context).unfocus();
    if (_seconds > 0 && !_isRunning) {
      setState(() {
        _isRunning = true;
      });
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_seconds > 0) {
          setState(() {
            _seconds--;
          });
        } else {
          _stopTimer();
          _controller.clear();
          _confettiController.play();
          _showCompletionDialog();
        }
      });
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => Stack(
        alignment: Alignment.center,
        children: [
          Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Animated Icon or Image
                  Container(
                    width: 400,
                    height: 200,
                    child: Image.asset(
                      'assets/images/happy.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    'Chúc mừng!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      decoration: TextDecoration.none,
                      fontFamily: '.SF UI Display',
                    ),
                  ),
                  const SizedBox(height: 12),

                  const Text(
                    'Bạn đã hoàn thành đếm ngược.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.text,
                      height: 1.5,
                      decoration: TextDecoration.none,
                      fontFamily: '.SF UI Text',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Hãy tiếp tục phát huy nhé!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textMuted,
                      decoration: TextDecoration.none,
                      fontFamily: '.SF UI Text',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Tuyệt vời!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              emissionFrequency: 0.05,
              numberOfParticles: 50,
              maxBlastForce: 60,
              minBlastForce: 10,
              gravity: 0.1,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _seconds = 0;
      _controller.clear();
    });
  }

  String _formatTime(int seconds) {
    int m = seconds ~/ 60;
    int s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Nhập số giây cần đếm:',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  hintText: 'Nhập số giây',
                ),
                onChanged: (value) {
                  setState(() {
                    _seconds = int.tryParse(value) ?? 0;
                  });
                },
              ),
            ),
            const SizedBox(height: 40),
            Text(
              _formatTime(_seconds),
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _buildButton(
                    label: 'Bắt đầu',
                    icon: Iconsax.play,
                    onTap: _startTimer,
                    isActive: !_isRunning && _seconds > 0,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildButton(
                    label: 'Đặt lại',
                    icon: Iconsax.refresh,
                    onTap: _resetTimer,
                    isActive: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    bool isActive = true,
  }) {
    return InkWell(
      onTap: isActive ? onTap : null,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? kPrimaryColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    setState(() {
      _count--;
    });
  }

  void _reset() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  const Text(
                    'Đếm số lượng',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: 180,
                    height: 180,
                    child: Center(
                      child: Text(
                        '$_count',
                        style: const TextStyle(
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildControlBtn(
                        icon: Iconsax.minus,
                        onTap: _decrement,
                        color: Colors.orange,
                        label: 'Giảm',
                      ),
                      const SizedBox(width: 20),
                      _buildControlBtn(
                        icon: Iconsax.refresh,
                        onTap: _reset,
                        color: Colors.grey,
                        label: 'Đặt lại',
                      ),
                      const SizedBox(width: 20),
                      _buildControlBtn(
                        icon: Iconsax.add,
                        onTap: _increment,
                        color: AppColors.primary,
                        label: 'Tăng',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlBtn({
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
    required String label,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color.withOpacity(0.3), width: 1.5),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class ColorChangerWidget extends StatelessWidget {
  final Color color;
  final String name;
  final Function(Color, String) onChanged;

  const ColorChangerWidget({
    super.key,
    required this.color,
    required this.name,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = color.computeLuminance() < 0.5;

    final List<Map<String, dynamic>> colorOptions = [
      {'label': 'Hồng', 'name': 'HỒNG', 'color': Colors.pinkAccent},
      {'label': 'Tím', 'name': 'TÍM', 'color': Colors.deepPurpleAccent},
      {'label': 'Vàng', 'name': 'VÀNG', 'color': Colors.yellow},
      {'label': 'Xanh lá', 'name': 'XANH LÁ', 'color': Colors.green},
      {'label': 'Xanh dương', 'name': 'XANH DƯƠNG', 'color': Colors.blue},
      {'label': 'Cam', 'name': 'CAM', 'color': Colors.orangeAccent},
      {'label': 'Đen', 'name': 'ĐEN', 'color': const Color(0xFF2D3436)},
      {'label': 'Xanh ngọc', 'name': 'XANH NGỌC', 'color': Colors.teal},
    ];

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          // Background pattern or decoration
          Positioned(
            top: 40,
            right: -20,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: isDark ? Colors.white : Colors.black87,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Màu sắc hiện tại",
                  style: TextStyle(
                    fontSize: 16,
                    color: (isDark ? Colors.white : Colors.black87).withOpacity(
                      0.6,
                    ),
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 60), // Space for control panel
              ],
            ),
          ),

          // Control Panel at Bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Đổi màu hình nền",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3436),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 60,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: colorOptions.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final option = colorOptions[index];
                        final optionColor = option['color'] as Color;
                        final optionName = option['name'] as String;
                        final isSelected = name == optionName;

                        return GestureDetector(
                          onTap: () => onChanged(optionColor, optionName),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: isSelected ? 60 : 50,
                            height: isSelected ? 60 : 50,
                            decoration: BoxDecoration(
                              color: optionColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.black
                                    : Colors.transparent,
                                width: isSelected ? 3 : 0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: optionColor.withOpacity(0.4),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
