import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/common_footer.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/services/order_service.dart';
import 'package:union_shop/cart_manager.dart';
import 'package:union_shop/router/app_router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => OrderService()),
      ],
      child: const UnionShopApp(),
    ),
  );
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
        'https://shop.upsu.net/cdn/shop/products/BlackTshirtFinal_1024x1024@2x.png?v=1669713197',
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
        'https://shop.upsu.net/cdn/shop/products/BlackSweatshirtFinal_1024x1024@2x.png?v=1741965433',
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
        'https://shop.upsu.net/cdn/shop/files/HeavyWeightShortspng_1024x1024@2x.png?v=1683815389',
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
        'https://shop.upsu.net/cdn/shop/products/Cap-Purple_1024x1024@2x.jpg?v=1742201981',
    isVisible: true,
  ),
  Product(
    serial: 'PROD010',
    name: 'University Beanie',
    category: 'Clothing',
    description:
        'Warm knitted scarf in university colors. Perfect for showing your school spirit in winter.',
    price: 20.00,
    isSale: false,
    salePrice: null,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/products/Beanie-White_1024x1024@2x.jpg?v=1742201998',
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
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityWaterBottle5_1024x1024@2x.jpg?v=1755251995',
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
        'https://shop.upsu.net/cdn/shop/products/cottonshopper_1024x1024@2x.jpg?v=1657540427',
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
        'https://shop.upsu.net/cdn/shop/files/Fidget_Keyring_1024x1024@2x.png?v=1719226889',
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
        'https://shop.upsu.net/cdn/shop/products/IMG_0645_1024x1024@2x.jpg?v=1557218961',
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
        'https://shop.upsu.net/cdn/shop/files/lapelpins_1024x1024@2x.webp?v=1704879504',
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
        'https://shop.upsu.net/cdn/shop/products/IMG_3454_b13bdf10-3a11-42d0-90ea-55cdd9314f48_1024x1024@2x.jpg?v=1648635743',
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
  // Graduation - 3 items (hidden from homepage)
  Product(
    serial: 'PROD026',
    name: 'Graduation Teddy Bear',
    category: 'Graduation',
    description:
        'Adorable graduation bear wearing cap and gown. Perfect gift for celebrating academic achievement.',
    price: 24.00,
    isSale: false,
    salePrice: null,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/Bear_1_-_right_size_1024x1024@2x.jpg?v=1750064318',
    isVisible: false,
  ),
  Product(
    serial: 'PROD027',
    name: 'Graduation Photo Frame',
    category: 'Graduation',
    description:
        'Elegant photo frame with graduation motif. Holds 5x7 photo and features university crest.',
    price: 18.00,
    isSale: true,
    salePrice: 14.40,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: false,
  ),
  Product(
    serial: 'PROD028',
    name: 'Graduation Keepsake Box',
    category: 'Graduation',
    description:
        'Wooden keepsake box with engraved university logo. Perfect for storing graduation memories and mementos.',
    price: 32.00,
    isSale: false,
    salePrice: null,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: false,
  ),
  // Essentials - 3 items (hidden from homepage)
  Product(
    serial: 'PROD029',
    name: 'Student Essentials Bundle',
    category: 'Essentials',
    description:
        'Complete starter pack including notebook, pens, highlighters, and sticky notes. Everything you need for classes.',
    price: 28.00,
    isSale: true,
    salePrice: 22.40,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: false,
  ),
  Product(
    serial: 'PROD030',
    name: 'Laundry Essentials Kit',
    category: 'Essentials',
    description:
        'Student laundry kit with detergent pods, mesh bag, and stain remover. Essential for dorm living.',
    price: 22.00,
    isSale: false,
    salePrice: null,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: false,
  ),
  Product(
    serial: 'PROD031',
    name: 'Study Essentials Pack',
    category: 'Essentials',
    description:
        'Includes desk lamp, calculator, USB drive, and notebook. Everything for productive study sessions.',
    price: 45.00,
    isSale: true,
    salePrice: 36.00,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: false,
  ),
  // Pride Collection - 3 items (hidden from homepage)
  Product(
    serial: 'PROD032',
    name: 'Pride Rainbow Lanyard',
    category: 'Pride Collection',
    description:
        'Vibrant rainbow lanyard with university logo. Show your pride and support for LGBTQ+ community.',
    price: 8.00,
    isSale: false,
    salePrice: null,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/products/RainbowLanyard_540x.jpg?v=1657031493',
    isVisible: false,
  ),
  Product(
    serial: 'PROD033',
    name: 'Pride Pin Badge Collection',
    category: 'Pride Collection',
    description:
        'Set of 5 pride-themed enamel pins featuring various pride flags. Celebrate diversity and inclusion.',
    price: 12.00,
    isSale: true,
    salePrice: 9.60,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/Pin_1024x1024@2x.jpg?v=1749118523',
    isVisible: false,
  ),
  Product(
    serial: 'PROD034',
    name: 'Pride Tote Bag',
    category: 'Pride Collection',
    description:
        'Canvas tote bag with rainbow university logo design. Eco-friendly and perfect for showing your support.',
    price: 15.00,
    isSale: false,
    salePrice: null,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: false,
  ),
  // Summer Collection - 3 items (hidden from homepage)
  Product(
    serial: 'PROD035',
    name: 'Summer Beach Towel',
    category: 'Summer Collection',
    description:
        'Large beach towel with university logo and summer design. Quick-dry microfiber material, perfect for beach days.',
    price: 28.00,
    isSale: true,
    salePrice: 22.40,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: false,
  ),
  Product(
    serial: 'PROD036',
    name: 'Summer Sunglasses',
    category: 'Summer Collection',
    description:
        'UV protection sunglasses with university branding. Stylish and protective for sunny campus days.',
    price: 18.00,
    isSale: false,
    salePrice: null,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: false,
  ),
  Product(
    serial: 'PROD037',
    name: 'Summer Flip Flops',
    category: 'Summer Collection',
    description:
        'Comfortable flip flops in university colors with logo. Perfect for dorm showers or casual summer wear.',
    price: 14.00,
    isSale: true,
    salePrice: 11.20,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    isVisible: false,
  ),
];

class UnionShopApp extends StatefulWidget {
  const UnionShopApp({super.key});

  @override
  State<UnionShopApp> createState() => _UnionShopAppState();
}

class _UnionShopAppState extends State<UnionShopApp> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    final authService = Provider.of<AuthService>(context, listen: false);
    _appRouter = AppRouter(authService);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      routerConfig: _appRouter.router,
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
    context.go('/');
  }

  void navigateToProduct(BuildContext context) {
    // Product navigation handled by product cards
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
                      context.go(
                          '/all_products?searchQuery=${Uri.encodeComponent(value)}');
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
                          context.go(
                              '/all_products?searchQuery=${Uri.encodeComponent(searchController.text)}');
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
                                onPressed: () {
                                  context.go('/login');
                                },
                              ),
                              ValueListenableBuilder<int>(
                                valueListenable:
                                    CartManager().itemCountNotifier,
                                builder: (context, itemCount, child) {
                                  return Stack(
                                    clipBehavior: Clip.none,
                                    children: [
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
                                          context.go('/cart');
                                        },
                                      ),
                                      if (itemCount > 0)
                                        Positioned(
                                          right: 2,
                                          top: 2,
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                            constraints: const BoxConstraints(
                                              minWidth: 16,
                                              minHeight: 16,
                                            ),
                                            child: Text(
                                              '$itemCount',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 9,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
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
                      context.go('/');
                    }),
                    _buildMenuItem('Shop', () {
                      toggleMenu();
                      context.go('/all_products');
                    }),
                    _buildMenuItem('Collections', () {
                      toggleMenu();
                      context.go('/collections');
                    }),
                    _buildMenuItem('The Print Shack', () {
                      toggleMenu();
                      context.go('/print_shack_page');
                    }),
                    _buildMenuItem('SALE!', () {
                      toggleMenu();
                      context.go('/sales');
                    }),
                    _buildMenuItem('About', () {
                      toggleMenu();
                      context.go('/about');
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
                                          context.go('/all_products');
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
            const CommonFooter(),
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
        // Using Navigator.push for ProductPage since it requires product parameter
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
