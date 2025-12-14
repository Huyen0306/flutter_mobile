import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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
                // Sliding Segmented Control
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedIndex = 0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _selectedIndex == 0
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: _selectedIndex == 0
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
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
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _selectedIndex == 1
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: _selectedIndex == 1
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
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
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _selectedIndex == 2
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: _selectedIndex == 2
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
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
                      : const ColorChangerWidget(),
                ),
              ],
            ),
          ),
          const FloatingMenuButton(),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// TIMER WIDGET
// -----------------------------------------------------------------------------
class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int _seconds = 0;
  int _initialSeconds = 0;
  Timer? _timer;
  bool _isRunning = false;
  final TextEditingController _controller = TextEditingController();

  void _startTimer() {
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
        }
      });
    }
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
                    _initialSeconds = _seconds;
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

// -----------------------------------------------------------------------------
// COUNTER WIDGET
// -----------------------------------------------------------------------------
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Giá trị hiện tại:',
          style: TextStyle(fontSize: 18, color: Colors.black54),
        ),
        const SizedBox(height: 20),
        Text(
          '$_count',
          style: const TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
        ),
        const SizedBox(height: 80),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCircleButton(
              icon: Iconsax.minus,
              onTap: _decrement,
              color: kPrimaryColor,
            ),
            const SizedBox(width: 30),
            _buildCircleButton(
              icon: Icons.refresh,
              onTap: _reset,
              color: Colors.grey,
            ),
            const SizedBox(width: 30),
            _buildCircleButton(
              icon: Iconsax.add,
              onTap: _increment,
              color: kPrimaryColor,
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Chú thích button để giống layout ảnh hơn
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(width: 60, child: Center(child: Text("Giảm"))),
            SizedBox(width: 30),
            SizedBox(width: 60, child: Center(child: Text("Đặt lại"))),
            SizedBox(width: 30),
            SizedBox(width: 60, child: Center(child: Text("Tăng"))),
          ],
        ),
      ],
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COLOR CHANGER WIDGET
// -----------------------------------------------------------------------------
class ColorChangerWidget extends StatefulWidget {
  const ColorChangerWidget({super.key});

  @override
  State<ColorChangerWidget> createState() => _ColorChangerWidgetState();
}

class _ColorChangerWidgetState extends State<ColorChangerWidget> {
  Color _backgroundColor = Colors.pinkAccent;
  String _colorName = 'HỒNG';

  final List<Map<String, dynamic>> _colorOptions = [
    {'label': 'Hồng', 'name': 'HỒNG', 'color': Colors.pinkAccent},
    {'label': 'Tím', 'name': 'TÍM', 'color': Colors.deepPurpleAccent},
    {'label': 'Vàng', 'name': 'VÀNG', 'color': Colors.yellow},
    {'label': 'Xanh lá', 'name': 'XANH LÁ', 'color': Colors.green},
    {'label': 'Xanh dương', 'name': 'XANH DƯƠNG', 'color': Colors.blue},
  ];

  void _changeColor(Color color, String name) {
    setState(() {
      _backgroundColor = color;
      _colorName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: double.infinity,
      color: _backgroundColor,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Màu hiện tại',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _colorName,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: _backgroundColor,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "Chọn màu yêu thích",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: _colorOptions.map((option) {
                  final color = option['color'] as Color;
                  final name = option['name'] as String;
                  final isSelected = _colorName == name;

                  return GestureDetector(
                    onTap: () => _changeColor(color, name),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(color: Colors.black, width: 3)
                            : Border.all(color: Colors.black12, width: 1),
                      ),
                      child: isSelected
                          ? const Icon(Icons.check, color: Colors.white)
                          : null,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
