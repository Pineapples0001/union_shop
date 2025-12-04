import 'dart:async';
import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/all_products_page.dart';
import 'package:union_shop/cart_page.dart';
import 'package:union_shop/about_page.dart';

void main() {
  runApp(const UnionShopApp());
}

// Product Model Class
class Product {
  final String serial;
  final String name;
  final String category;
  final String description;
  final double price;
  final bool isSale;
  final double? salePrice;
  final String imageUrl;
  final bool isVisible;

  const Product({
    required this.serial,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.isSale,
    this.salePrice,
    required this.imageUrl,
    this.isVisible = true,
  });
}

// Sample Product Database
final List<Product> productDatabase = [
  Product(
    serial: 'PROD001',
    name: 'Portsmouth City Magnet',
    category: 'Souvenirs',
    description:
        'A beautiful commemorative magnet featuring Portsmouth City landmarks. Perfect souvenir for students and visitors.',
    price: 15.00,
    isSale: true,
    salePrice: 12.00,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: true,
  ),
  Product(
    serial: 'PROD002',
    name: 'Classic Hoodie',
    category: 'Clothing',
    description:
        'Comfortable and stylish university branded hoodie. Made from high-quality cotton blend material.',
    price: 25.00,
    isSale: true,
    salePrice: 18.00,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PurpleHoodieFinal.jpg?v=1742201957',
    isVisible: true,
  ),
  Product(
    serial: 'PROD003',
    name: 'Campus Cups',
    category: 'Accessories',
    description:
        'Plastic cups with university logo. Dishwasher safe and perfect for your morning coffee or tea.',
    price: 10.00,
    isSale: false,
    salePrice: null,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/products/IMG_0667_1024x1024@2x.jpg?v=1557218882',
    isVisible: true,
  ),
  Product(
    serial: 'PROD004',
    name: 'Student Notebook Set',
    category: 'Stationery',
    description:
        'Set of 3 ruled notebooks ideal for lectures and study sessions. Includes perforated pages for easy removal.',
    price: 8.00,
    isSale: false,
    salePrice: null,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/products/IMG_3406_1024x1024@2x.jpg?v=1581000944',
    isVisible: true,
  ),
  Product(
    serial: 'PROD005',
    name: 'University Bag',
    category: 'Accessories',
    description:
        'Durable backpack with laptop compartment. Features the university logo and water-resistant material.',
    price: 45.00,
    isSale: true,
    salePrice: 36.00,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/products/cottonshopper_1024x1024@2x.jpg?v=1657540427',
    isVisible: true,
  ),
  // Clothing - 5 items
  Product(
    serial: 'PROD006',
    name: 'University T-Shirt',
    category: 'Clothing',
    description:
        'Classic cotton t-shirt with university logo. Available in multiple colors and comfortable for everyday wear.',
    price: 18.00,
    isSale: false,
    salePrice: null,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: true,
  ),
  Product(
    serial: 'PROD007',
    name: 'University Sweatshirt',
    category: 'Clothing',
    description:
        'Warm fleece-lined sweatshirt perfect for cold campus days. Features embroidered university crest.',
    price: 32.00,
    isSale: true,
    salePrice: 25.60,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: true,
  ),
  Product(
    serial: 'PROD008',
    name: 'University Track Pants',
    category: 'Clothing',
    description:
        'Comfortable athletic track pants with university branding. Perfect for sports or casual wear.',
    price: 28.00,
    isSale: false,
    salePrice: null,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: true,
  ),
  Product(
    serial: 'PROD009',
    name: 'University Baseball Cap',
    category: 'Clothing',
    description:
        'Adjustable baseball cap with embroidered university logo. One size fits all.',
    price: 15.00,
    isSale: true,
    salePrice: 12.00,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: true,
  ),
  Product(
    serial: 'PROD010',
    name: 'University Scarf',
    category: 'Clothing',
    description:
        'Warm knitted scarf in university colors. Perfect for showing your school spirit in winter.',
    price: 20.00,
    isSale: false,
    salePrice: null,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: true,
  ),
  // Accessories - 5 items
  Product(
    serial: 'PROD011',
    name: 'University Water Bottle',
    category: 'Accessories',
    description:
        'Reusable stainless steel water bottle with university logo. Keeps drinks cold for 24 hours.',
    price: 22.00,
    isSale: false,
    salePrice: null,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: true,
  ),
  Product(
    serial: 'PROD012',
    name: 'University Tote Bag',
    category: 'Accessories',
    description:
        'Eco-friendly canvas tote bag with university branding. Perfect for carrying books and supplies.',
    price: 12.00,
    isSale: true,
    salePrice: 9.60,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: true,
  ),
  Product(
    serial: 'PROD013',
    name: 'University Keychain',
    category: 'Accessories',
    description:
        'Metal keychain featuring university crest. Durable and perfect for keeping your keys organized.',
    price: 6.00,
    isSale: false,
    salePrice: null,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: true,
  ),
  Product(
    serial: 'PROD014',
    name: 'University Lanyard',
    category: 'Accessories',
    description:
        'Durable lanyard with university colors and logo. Includes detachable buckle for ID cards.',
    price: 5.00,
    isSale: false,
    salePrice: null,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: true,
  ),
  Product(
    serial: 'PROD015',
    name: 'University Pin Badge Set',
    category: 'Accessories',
    description:
        'Set of 3 enamel pin badges with various university designs. Great for personalizing bags and jackets.',
    price: 8.00,
    isSale: true,
    salePrice: 6.40,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: true,
  ),
  // Souvenirs - 5 items
  Product(
    serial: 'PROD016',
    name: 'University Postcard Set',
    category: 'Souvenirs',
    description:
        'Beautiful set of 10 postcards featuring campus landmarks and university history.',
    price: 7.00,
    isSale: false,
    salePrice: null,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: true,
  ),
  Product(
    serial: 'PROD017',
    name: 'University Snow Globe',
    category: 'Souvenirs',
    description:
        'Decorative snow globe featuring miniature campus buildings. Perfect desk decoration and keepsake.',
    price: 18.00,
    isSale: true,
    salePrice: 14.40,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: true,
  ),
  Product(
    serial: 'PROD018',
    name: 'University Pennant Flag',
    category: 'Souvenirs',
    description:
        'Traditional felt pennant flag with university name and colors. Great for dorm room decoration.',
    price: 14.00,
    isSale: false,
    salePrice: null,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: true,
  ),
  Product(
    serial: 'PROD019',
    name: 'University Coaster Set',
    category: 'Souvenirs',
    description:
        'Set of 4 cork-backed coasters with university logo. Protects surfaces while showing school pride.',
    price: 10.00,
    isSale: false,
    salePrice: null,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: true,
  ),
  Product(
    serial: 'PROD020',
    name: 'University Commemorative Plate',
    category: 'Souvenirs',
    description:
        'Decorative ceramic plate featuring campus artwork. Perfect collectible for alumni and visitors.',
    price: 25.00,
    isSale: true,
    salePrice: 20.00,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: true,
  ),
  // Stationery - 5 items
  Product(
    serial: 'PROD021',
    name: 'University Pen Set',
    category: 'Stationery',
    description:
        'Set of 5 ballpoint pens with university logo. Smooth writing and perfect for note-taking.',
    price: 6.00,
    isSale: false,
    salePrice: null,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: true,
  ),
  Product(
    serial: 'PROD022',
    name: 'University Sticky Notes',
    category: 'Stationery',
    description:
        'Pack of sticky notes in university colors. Multiple sizes included for all your organizational needs.',
    price: 5.00,
    isSale: true,
    salePrice: 4.00,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: true,
  ),
  Product(
    serial: 'PROD023',
    name: 'University Planner',
    category: 'Stationery',
    description:
        'Academic year planner with university branding. Includes monthly and weekly views with space for notes.',
    price: 15.00,
    isSale: false,
    salePrice: null,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: true,
  ),
  Product(
    serial: 'PROD024',
    name: 'University Pencil Case',
    category: 'Stationery',
    description:
        'Durable zippered pencil case with university logo. Multiple compartments for organizing supplies.',
    price: 9.00,
    isSale: false,
    salePrice: null,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: true,
  ),
  Product(
    serial: 'PROD025',
    name: 'University Highlighter Set',
    category: 'Stationery',
    description:
        'Set of 6 vibrant highlighters in university colors. Perfect for studying and color-coding notes.',
    price: 7.00,
    isSale: true,
    salePrice: 5.60,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: true,
  ),
];

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(
            builder: (context) => const HomeScreen(),
            settings: settings,
          );
        } else if (settings.name == '/all_products') {
          final args = settings.arguments as Map<String, dynamic>?;
          return MaterialPageRoute(
            builder: (context) => AllProductsPage(
              searchQuery: args?['searchQuery'] ?? '',
            ),
            settings: settings,
          );
        } else if (settings.name == '/cart') {
          return MaterialPageRoute(
            builder: (context) => const CartPage(),
            settings: settings,
          );
        } else if (settings.name == '/about') {
          return MaterialPageRoute(
            builder: (context) => const AboutPage(),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentCategoryIndex = 0;
  late List<Product> _categoryProducts;
  Timer? _timer;
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    // Get one product from each category
    final categories = productDatabase
        .where((p) => p.isVisible)
        .map((p) => p.category)
        .toSet()
        .toList();

    _categoryProducts = categories
        .map((category) => productDatabase.firstWhere(
              (p) => p.category == category && p.isVisible,
            ))
        .toList();

    // Start slideshow timer
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentCategoryIndex =
            (_currentCategoryIndex + 1) % _categoryProducts.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _resetTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentCategoryIndex =
            (_currentCategoryIndex + 1) % _categoryProducts.length;
      });
    });
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  void toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
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

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top banner
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
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
                            navigateToHome(context);
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
                                  child: Icon(Icons.image_not_supported,
                                      color: Colors.grey),
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
                                onPressed: placeholderCallbackForButtons,
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
                    _buildMenuItem('The Print Shack', () {
                      toggleMenu();
                      // Placeholder for future Print Shack page
                    }),
                    _buildMenuItem('SALE!', () {
                      toggleMenu();
                      Navigator.pushNamed(context, '/all_products',
                          arguments: {'searchQuery': ''});
                    }),
                    _buildMenuItem('About', () {
                      toggleMenu();
                      Navigator.pushNamed(context, '/about');
                    }),
                  ],
                ),
              ),

            // Hero Section
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: _categoryProducts.isEmpty
                        ? Container(color: Colors.grey)
                        : AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: Container(
                              key: ValueKey<int>(_currentCategoryIndex),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    _categoryProducts[_currentCategoryIndex]
                                        .imageUrl,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.7),
                                ),
                              ),
                            ),
                          ),
                  ),
                  // Content overlay
                  Positioned(
                    left: 24,
                    right: 24,
                    top: 80,
                    child: _categoryProducts.isEmpty
                        ? const SizedBox.shrink()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Left Arrow
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _currentCategoryIndex =
                                        (_currentCategoryIndex -
                                                1 +
                                                _categoryProducts.length) %
                                            _categoryProducts.length;
                                  });
                                  _resetTimer();
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Content
                              Expanded(
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
                                  child: Column(
                                    key: ValueKey<int>(_currentCategoryIndex),
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        _categoryProducts[_currentCategoryIndex]
                                            .name,
                                        style: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          height: 1.2,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        _categoryProducts[_currentCategoryIndex]
                                            .category
                                            .toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white70,
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        _categoryProducts[_currentCategoryIndex]
                                            .description,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          height: 1.5,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 32),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/all_products');
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF4d2963),
                                          foregroundColor: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero,
                                          ),
                                        ),
                                        child: const Text(
                                          'BROWSE PRODUCTS',
                                          style: TextStyle(
                                              fontSize: 14, letterSpacing: 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Right Arrow
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _currentCategoryIndex =
                                        (_currentCategoryIndex + 1) %
                                            _categoryProducts.length;
                                  });
                                  _resetTimer();
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),

            // Products Section
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    const Text(
                      'PRODUCTS SECTION',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 48),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 600 ? 2 : 1,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 48,
                      children: productDatabase
                          .where((product) => product.isVisible)
                          .take(4)
                          .map((product) => ProductCard(product: product))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),

            // Footer
            Container(
              width: double.infinity,
              color: const Color(0xFF2c2c2c),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Column(
                crossAxisAlignment: MediaQuery.of(context).size.width > 600
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  // Footer content
                  Wrap(
                    spacing: 40,
                    runSpacing: 24,
                    alignment: MediaQuery.of(context).size.width > 600
                        ? WrapAlignment.center
                        : WrapAlignment.start,
                    children: [
                      // About section
                      SizedBox(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'ABOUT US',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Your official university shop for merchandise, stationery, and essentials.',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 13,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Quick Links
                      SizedBox(
                        width: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'QUICK LINKS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Shop All',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 13,
                                height: 1.8,
                              ),
                            ),
                            Text(
                              'Sale Items',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 13,
                                height: 1.8,
                              ),
                            ),
                            Text(
                              'Contact Us',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 13,
                                height: 1.8,
                              ),
                            ),
                            Text(
                              'FAQ',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 13,
                                height: 1.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Contact Info
                      SizedBox(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'CONTACT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Email: shop@university.ac.uk',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 13,
                                height: 1.8,
                              ),
                            ),
                            Text(
                              'Phone: 023 9284 3000',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 13,
                                height: 1.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Opening Hours
                      SizedBox(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'OPENING HOURS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Monday - Friday: 9:00 AM - 5:00 PM',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 13,
                                height: 1.8,
                              ),
                            ),
                            Text(
                              'Saturday: 10:00 AM - 4:00 PM',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 13,
                                height: 1.8,
                              ),
                            ),
                            Text(
                              'Sunday: Closed',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 13,
                                height: 1.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Newsletter subscription
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      children: [
                        const Text(
                          'SUBSCRIBE TO OUR NEWSLETTER',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Builder(
                          builder: (context) => Text(
                            'Get updates on new products and special offers',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                            textAlign: MediaQuery.of(context).size.width > 600
                                ? TextAlign.center
                                : TextAlign.left,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Enter your email',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 14,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: placeholderCallbackForButtons,
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
                                'SUBSCRIBE',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Divider
                  Divider(color: Colors.grey[700], thickness: 1),
                  const SizedBox(height: 16),
                  // Copyright
                  Builder(
                    builder: (context) => Text(
                      '© 2025 Union Shop. All rights reserved.',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                      textAlign: MediaQuery.of(context).size.width > 600
                          ? TextAlign.center
                          : TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(product: product),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              if (product.isSale && product.salePrice != null)
                Row(
                  children: [
                    Text(
                      '£${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '£${product.salePrice!.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              else
                Text(
                  '£${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
