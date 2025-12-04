import 'package:flutter/material.dart';

class CommonHeader extends StatefulWidget {
  const CommonHeader({super.key});

  @override
  State<CommonHeader> createState() => _CommonHeaderState();
}

class _CommonHeaderState extends State<CommonHeader> {
  bool _isMenuOpen = false;

  void toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  void showSearchDialog(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          child: Container(
            padding: const EdgeInsets.all(32),
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Search Products',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Enter product name, category, or description...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                        color: Color(0xFF4d2963),
                        width: 2,
                      ),
                    ),
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(
                        context,
                        '/all_products',
                        arguments: {'searchQuery': value},
                      );
                    }
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        if (searchController.text.isNotEmpty) {
                          Navigator.of(context).pop();
                          Navigator.pushNamed(
                            context,
                            '/all_products',
                            arguments: {'searchQuery': searchController.text},
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4d2963),
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        'SEARCH',
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[300]!),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          color: const Color(0xFF4d2963),
          child: const Text(
            'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),
        // Main header
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Image.network(
                  'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                  height: 18,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      width: 18,
                      height: 18,
                      child: const Center(
                        child:
                            Icon(Icons.image_not_supported, color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        size: 18,
                        color: Colors.grey,
                      ),
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                      onPressed: () {
                        showSearchDialog(context);
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.person_outline,
                        size: 18,
                        color: Colors.grey,
                      ),
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.shopping_bag_outlined,
                        size: 18,
                        color: Colors.grey,
                      ),
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/cart');
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        _isMenuOpen ? Icons.close : Icons.menu,
                        size: 18,
                        color: Colors.grey,
                      ),
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                      onPressed: toggleMenu,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Dropdown Menu Overlay
        if (_isMenuOpen)
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                _buildMenuItem('Home', () {
                  toggleMenu();
                  Navigator.pushNamed(context, '/');
                }),
                _buildMenuItem('Shop', () {
                  toggleMenu();
                  Navigator.pushNamed(context, '/all_products',
                      arguments: {'searchQuery': ''});
                }),
                _buildMenuItem('Collections', () {
                  toggleMenu();
                  Navigator.pushNamed(context, '/collections');
                }),
                _buildMenuItem('The Print Shack', () {
                  toggleMenu();
                  // Placeholder for future Print Shack page
                }),
                _buildMenuItem('SALE!', () {
                  toggleMenu();
                  Navigator.pushNamed(context, '/sales');
                }),
                _buildMenuItem('About', () {
                  toggleMenu();
                  Navigator.pushNamed(context, '/about');
                }),
              ],
            ),
          ),
      ],
    );
  }
}
