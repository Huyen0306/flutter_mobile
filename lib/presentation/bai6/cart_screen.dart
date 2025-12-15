import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dio/dio.dart';
import '../../constants/app_colors.dart';

class CartScreen extends StatefulWidget {
  final List<dynamic>? cartItemIds;
  const CartScreen({super.key, this.cartItemIds});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = true;
  List<dynamic> _cartItems = [];

  bool _isAllChecked = false;
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    if (widget.cartItemIds != null && widget.cartItemIds!.isNotEmpty) {
      _fetchProductsByIds();
    } else {
      _fetchCart();
    }
  }

  Future<void> _fetchProductsByIds() async {
    try {
      List<dynamic> loadedItems = [];
      // Fetch details for each item id (Parallel)
      final requests = widget.cartItemIds!.map((item) {
        return _dio.get('https://dummyjson.com/products/${item['id']}');
      }).toList();

      final responses = await Future.wait(requests);

      for (int i = 0; i < responses.length; i++) {
        final productData = responses[i].data;
        // Merge with locally stored quantity
        productData['quantity'] = widget.cartItemIds![i]['quantity'];
        productData['checked'] = false; // Add local state
        loadedItems.add(productData);
      }

      setState(() {
        _cartItems = loadedItems;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Lỗi tải sản phẩm: $e')));
    }
  }

  Future<void> _fetchCart() async {
    try {
      // Simulate fetching cart for user 1
      final response = await _dio.get('https://dummyjson.com/carts/1');
      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
          _cartItems = (data['products'] as List).map((item) {
            item['checked'] = false; // Add local state for checkbox
            return item;
          }).toList();

          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Lỗi tải giỏ hàng: $e')));
    }
  }

  void _toggleAll(bool? value) {
    setState(() {
      _isAllChecked = value ?? false;
      for (var item in _cartItems) {
        item['checked'] = _isAllChecked;
      }
    });
  }

  void _updateCheckState() {
    bool allChecked = true;
    for (var item in _cartItems) {
      if (item['checked'] == false) {
        allChecked = false;
        break;
      }
    }
    setState(() {
      _isAllChecked = allChecked;
    });
  }

  double _calculateSelectedTotal() {
    double total = 0;
    for (var item in _cartItems) {
      if (item['checked']) {
        total += (item['price'] as num).toDouble() * (item['quantity'] as num);
      }
    }
    return total;
  }

  int _calculateTotalItems() {
    int count = 0;
    for (var item in _cartItems) {
      if (item['checked']) {
        count += (item['quantity'] as num).toInt();
      }
    }
    return count;
  }

  Future<void> _updateQuantity(int itemId, int newQuantity) async {
    // Optimistic update for UI
    final index = _cartItems.indexWhere((item) => item['id'] == itemId);
    if (index != -1) {
      setState(() {
        _cartItems[index]['quantity'] = newQuantity;
      });
    }

    // In a real app, we would call the API here.
    // Since this is dummyjson, we just simulate success.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: AppBar(
        title: Text(
          'Giỏ hàng (${_cartItems.length})',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Sửa',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          IconButton(
            icon: const Icon(Iconsax.message, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 100),
                    children: [_buildStoreSection()],
                  ),
                ),
                _buildBottomBar(),
              ],
            ),
    );
  }

  Widget _buildStoreSection() {
    // API returns flat list, so we wrap all in one "Store" section usually,
    // or just list them. We'll use a dummy store name for consistency with UI.
    return Container(
      margin: const EdgeInsets.only(top: 12),
      color: Colors.white,
      child: Column(
        children: [
          // Store Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                _buildCheckbox(false), // Store checkbox placeholder
                const SizedBox(width: 8),
                Container(
                  margin: const EdgeInsets.only(right: 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD0011B),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: const Text(
                    'Mall',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Text(
                  'DummyJSON Store',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
                const Spacer(),
                const Text(
                  'Sửa',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF5F5F5)),

          // Items
          ..._cartItems.map((item) => _buildCartItem(item)).toList(),

          // Store Footer (Vouchers, etc)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFF5F5F5))),
            ),
            child: Row(
              children: [
                const Icon(
                  Iconsax.ticket_discount,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Voucher giảm đến 100kđ',
                    style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                  ),
                ),
                const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  item['checked'] = !item['checked'];
                  _updateCheckState();
                });
              },
              child: _buildCheckbox(item['checked']),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Image.network(
              item['thumbnail'],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.image_not_supported, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Phân loại hàng',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 14,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${(item['price'] as num).toDouble().toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: [
                        _buildQtyBtn(
                          icon: Icons.remove,
                          onTap: () {
                            int qty = (item['quantity'] as num).toInt();
                            if (qty > 1) {
                              _updateQuantity(item['id'], qty - 1);
                            }
                          },
                        ),
                        Container(
                          width: 32,
                          height: 24,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.symmetric(
                              horizontal: BorderSide(color: Colors.grey[300]!),
                            ),
                          ),
                          child: Text(
                            item['quantity'].toString(),
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                        _buildQtyBtn(
                          icon: Icons.add,
                          onTap: () {
                            int qty = (item['quantity'] as num).toInt();
                            _updateQuantity(item['id'], qty + 1);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQtyBtn({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
        child: Icon(icon, size: 14, color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildCheckbox(bool checked) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: checked ? AppColors.primary : Colors.white,
        border: Border.all(
          color: checked ? AppColors.primary : Colors.grey[400]!,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: checked
          ? const Icon(Icons.check, size: 14, color: Colors.white)
          : null,
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            GestureDetector(
              onTap: () => _toggleAll(!_isAllChecked),
              child: Row(
                children: [
                  _buildCheckbox(_isAllChecked),
                  const SizedBox(width: 8),
                  const Text('Tất cả', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Text(
                      'Tổng thanh toán ',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      '\$${_calculateSelectedTotal().toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Mua hàng (${_calculateTotalItems()})',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
