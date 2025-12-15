import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile_test/constants/app_colors.dart';
import '../widgets/app_drawer.dart';
import '../widgets/custom_menu_button.dart';

class PlaceItem {
  final String name;
  final String imagePath;

  PlaceItem({required this.name, required this.imagePath});
}

class WelcomeCharlieScreen extends StatefulWidget {
  const WelcomeCharlieScreen({super.key});

  @override
  State<WelcomeCharlieScreen> createState() => _WelcomeCharlieScreenState();
}

class _WelcomeCharlieScreenState extends State<WelcomeCharlieScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Dữ liệu mẫu với tên và đường dẫn ảnh
  final List<PlaceItem> _allPlaces = [
    PlaceItem(name: 'Xứ sở mùa đông', imagePath: 'assets/images/noel_1.png'),
    PlaceItem(
      name: 'Tuyết trắng phủ kín',
      imagePath: 'assets/images/noel_2.png',
    ),
    PlaceItem(name: 'Đêm thanh bình', imagePath: 'assets/images/noel_3.png'),
    PlaceItem(name: 'Căn gỗ ấm áp', imagePath: 'assets/images/noel_4.png'),
  ];

  List<PlaceItem> _filteredPlaces = [];

  @override
  void initState() {
    super.initState();
    _filteredPlaces = _allPlaces;
  }

  void _runFilter(String enteredKeyword) {
    List<PlaceItem> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allPlaces;
    } else {
      results = _allPlaces
          .where(
            (place) =>
                place.name.toLowerCase().contains(enteredKeyword.toLowerCase()),
          )
          .toList();
    }

    setState(() {
      _filteredPlaces = results;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const AppDrawer(activeIndex: 2),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 60,
              left: 24.0,
              right: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

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
                const SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => _runFilter(value),
                    decoration: const InputDecoration(
                      hintText: 'Tìm kiếm',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                      prefixIcon: Icon(
                        Iconsax.search_normal,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                const Text(
                  'Saved Places',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2D3436),
                  ),
                ),
                const SizedBox(height: 16), // Add spacing before grid
                Expanded(
                  child: _filteredPlaces.isEmpty
                      ? const Center(
                          child: Text(
                            'Không tìm thấy',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.only(bottom: 20),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio:
                                    1.0, // Adjusted for image + text
                              ),
                          itemCount: _filteredPlaces.length,
                          itemBuilder: (context, index) {
                            return _buildPlaceCard(
                              context,
                              place: _filteredPlaces[index],
                            );
                          },
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

  Widget _buildPlaceCard(BuildContext context, {required PlaceItem place}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                iconTheme: const IconThemeData(color: Colors.white),
                title: Text(
                  place.name,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              body: Center(
                child: Hero(
                  tag: place.imagePath,
                  child: InteractiveViewer(child: Image.asset(place.imagePath)),
                ),
              ),
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Hero(
              tag: place.imagePath,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(place.imagePath),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              place.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
