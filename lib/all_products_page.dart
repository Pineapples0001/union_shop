import 'package:flutter/material.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/product_page.dart';

class AllProductsPage extends StatefulWidget {
  final String? searchQuery;

  const AllProductsPage({super.key, this.searchQuery});

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  String selectedCategory = 'All';
  String selectedSort = 'Name (A-Z)';
  String searchQuery = '';

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  void initState() {
    super.initState();
    if (widget.searchQuery != null) {
      searchQuery = widget.searchQuery!;
    }
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  void showSearchDialog(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    searchController.text = searchQuery;

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
                    Navigator.of(context).pop();
                    setState(() {
                      searchQuery = value;
                    });
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
                        Navigator.of(context).pop();
                        setState(() {
                          searchQuery = searchController.text;
                        });
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

  List<Product> getFilteredAndSortedProducts() {
    // Get all visible products
    List<Product> products = productDatabase.where((p) => p.isVisible).toList();

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      products = products.where((p) {
        final query = searchQuery.toLowerCase();
        return p.name.toLowerCase().contains(query) ||
            p.description.toLowerCase().contains(query) ||
            p.category.toLowerCase().contains(query);
      }).toList();
    }

    // Filter by category
    if (selectedCategory != 'All') {
      products = products.where((p) => p.category == selectedCategory).toList();
    }

    // Sort products
    switch (selectedSort) {
      case 'Name (A-Z)':
        products.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Name (Z-A)':
        products.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 'Price (Low to High)':
        products.sort((a, b) {
          final priceA =
              a.isSale && a.salePrice != null ? a.salePrice! : a.price;
          final priceB =
              b.isSale && b.salePrice != null ? b.salePrice! : b.price;
          return priceA.compareTo(priceB);
        });
        break;
      case 'Price (High to Low)':
        products.sort((a, b) {
          final priceA =
              a.isSale && a.salePrice != null ? a.salePrice! : a.price;
          final priceB =
              b.isSale && b.salePrice != null ? b.salePrice! : b.price;
          return priceB.compareTo(priceA);
        });
        break;
      case 'On Sale':
        products = products.where((p) => p.isSale).toList();
        break;
    }

    return products;
  }

  List<String> getCategories() {
    final categories = productDatabase
        .where((p) => p.isVisible)
        .map((p) => p.category)
        .toSet()
        .toList();
    categories.sort();
    return ['All', ...categories];
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = getFilteredAndSortedProducts();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              height: 100,
              color: Colors.white,
              child: Column(
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
                  Expanded(
                    child: Container(
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
                                  onPressed: () => showSearchDialog(context),
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
                                  onPressed: placeholderCallbackForButtons,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.menu,
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Page Title and Filters
            Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  const Text(
                    'ALL PRODUCTS',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Search query display
                  if (searchQuery.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: const Color(0xFF4d2963)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.search,
                              size: 16, color: Color(0xFF4d2963)),
                          const SizedBox(width: 8),
                          Text(
                            'Search: "$searchQuery"',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF4d2963),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              setState(() {
                                searchQuery = '';
                              });
                            },
                            child: const Icon(Icons.close,
                                size: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 32),

                  // Filter and Sort Dropdowns
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      // Category Filter
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DropdownButton<String>(
                          value: selectedCategory,
                          underline: const SizedBox(),
                          items: getCategories().map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(
                                'Category: $category',
                                style: const TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value!;
                            });
                          },
                        ),
                      ),

                      // Sort Dropdown
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DropdownButton<String>(
                          value: selectedSort,
                          underline: const SizedBox(),
                          items: [
                            'Name (A-Z)',
                            'Name (Z-A)',
                            'Price (Low to High)',
                            'Price (High to Low)',
                            'On Sale',
                          ].map((sortOption) {
                            return DropdownMenuItem(
                              value: sortOption,
                              child: Text(
                                'Sort: $sortOption',
                                style: const TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedSort = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Results count
                  Text(
                    'Showing ${filteredProducts.length} product${filteredProducts.length != 1 ? 's' : ''}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Products Grid
            Container(
              color: Colors.grey[100],
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: filteredProducts.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(40),
                        child: Text(
                          'No products found with the selected filters.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 600 ? 3 : 1,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 48,
                        childAspectRatio: 0.7,
                        children: filteredProducts
                            .map((product) => _ProductCard(product: product))
                            .toList(),
                      ),
              ),
            ),

            // Footer
            Container(
              width: double.infinity,
              color: const Color(0xFF2c2c2c),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Column(
                children: [
                  // Footer content
                  Wrap(
                    spacing: 40,
                    runSpacing: 24,
                    alignment: WrapAlignment.center,
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
                        Text(
                          'Get updates on new products and special offers',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
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
                  Text(
                    '© 2025 Union Shop. All rights reserved.',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
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

class _ProductCard extends StatelessWidget {
  final Product product;

  const _ProductCard({
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
