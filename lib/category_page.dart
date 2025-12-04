import 'package:flutter/material.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/common_header.dart';
import 'package:union_shop/common_footer.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;

  const CategoryPage({super.key, required this.categoryName});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String selectedSort = 'Name (A-Z)';
  double minPrice = 0.0;
  double maxPrice = 100.0;
  double filterMinPrice = 0.0;
  double filterMaxPrice = 100.0;
  bool showPriceFilter = false;
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  int currentPage = 1;
  final int productsPerPage = 3;

  @override
  void initState() {
    super.initState();
    _initializePriceRange();
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  void _initializePriceRange() {
    final products = productDatabase
        .where((product) => product.category == widget.categoryName)
        .toList();

    if (products.isEmpty) return;

    minPrice = products
        .map((p) => p.isSale && p.salePrice != null ? p.salePrice! : p.price)
        .reduce((a, b) => a < b ? a : b);
    maxPrice = products
        .map((p) => p.isSale && p.salePrice != null ? p.salePrice! : p.price)
        .reduce((a, b) => a > b ? a : b);

    // Round to nearest dollar
    minPrice = minPrice.floorToDouble();
    maxPrice = maxPrice.ceilToDouble();
    filterMinPrice = minPrice;
    filterMaxPrice = maxPrice;

    setState(() {
      _minPriceController.text = minPrice.toStringAsFixed(0);
      _maxPriceController.text = maxPrice.toStringAsFixed(0);
    });
  }

  List<Product> getCategoryProducts() {
    return productDatabase
        .where((product) => product.category == widget.categoryName)
        .toList();
  }

  List<Product> getFilteredProducts() {
    final products = getCategoryProducts();

    return products.where((product) {
      final price = product.isSale && product.salePrice != null
          ? product.salePrice!
          : product.price;
      return price >= filterMinPrice && price <= filterMaxPrice;
    }).toList();
  }

  void _applyPriceFilter() {
    setState(() {
      filterMinPrice = double.tryParse(_minPriceController.text) ?? minPrice;
      filterMaxPrice = double.tryParse(_maxPriceController.text) ?? maxPrice;

      // Ensure min is not greater than max
      if (filterMinPrice > filterMaxPrice) {
        final temp = filterMinPrice;
        filterMinPrice = filterMaxPrice;
        filterMaxPrice = temp;
        _minPriceController.text = filterMinPrice.toStringAsFixed(0);
        _maxPriceController.text = filterMaxPrice.toStringAsFixed(0);
      }

      currentPage = 1;
      showPriceFilter = false;
    });
  }

  void _resetPriceFilter() {
    setState(() {
      filterMinPrice = minPrice;
      filterMaxPrice = maxPrice;
      _minPriceController.text = minPrice.toStringAsFixed(0);
      _maxPriceController.text = maxPrice.toStringAsFixed(0);
      currentPage = 1;
      showPriceFilter = false;
    });
  }

  List<Product> getSortedProducts() {
    final products = getFilteredProducts();

    switch (selectedSort) {
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
      case 'Name (Z-A)':
        products.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 'Name (A-Z)':
      default:
        products.sort((a, b) => a.name.compareTo(b.name));
        break;
    }

    return products;
  }

  List<Product> getPaginatedProducts() {
    final allProducts = getSortedProducts();
    final startIndex = (currentPage - 1) * productsPerPage;
    final endIndex =
        (startIndex + productsPerPage).clamp(0, allProducts.length);

    if (startIndex >= allProducts.length) return [];
    return allProducts.sublist(startIndex, endIndex);
  }

  int getTotalPages() {
    final totalProducts = getSortedProducts().length;
    return (totalProducts / productsPerPage).ceil();
  }

  @override
  Widget build(BuildContext context) {
    final allProducts = getSortedProducts();
    final products = getPaginatedProducts();
    final totalPages = getTotalPages();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            const CommonHeader(),

            // Page Title Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF4d2963),
                    const Color(0xFF4d2963).withOpacity(0.8),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Text(
                    widget.categoryName.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${allProducts.length} ${allProducts.length == 1 ? 'Product' : 'Products'}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),

            // Filters and Products Section
            Container(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  // Filters Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price Range Filter Dropdown
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {
                              setState(() {
                                showPriceFilter = !showPriceFilter;
                              });
                            },
                            icon: const Icon(Icons.filter_list),
                            label: Text(
                              'Price: \$${filterMinPrice.toStringAsFixed(0)} - \$${filterMaxPrice.toStringAsFixed(0)}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF4d2963),
                              side: BorderSide(color: Colors.grey[300]!),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                          if (showPriceFilter)
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              padding: const EdgeInsets.all(16),
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Price Range',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: _minPriceController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText: 'Min',
                                            prefixText: '\$',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 8,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Text('—'),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: _maxPriceController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText: 'Max',
                                            prefixText: '\$',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: _resetPriceFilter,
                                        child: const Text('Reset'),
                                      ),
                                      const SizedBox(width: 8),
                                      ElevatedButton(
                                        onPressed: _applyPriceFilter,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF4d2963),
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Text('Apply'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const Spacer(),
                      // Sort Filter
                      Row(
                        children: [
                          const Text(
                            'Sort by:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              color: Colors.white,
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
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedSort = newValue;
                                    currentPage = 1; // Reset to first page
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Results Info
                  if (allProducts.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Showing ${((currentPage - 1) * productsPerPage) + 1}-${((currentPage - 1) * productsPerPage) + products.length} of ${allProducts.length} products',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          if (totalPages > 1)
                            Text(
                              'Page $currentPage of $totalPages',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                    ),

                  // Products Grid
                  products.isEmpty
                      ? Container(
                          padding: const EdgeInsets.all(60),
                          child: Column(
                            children: [
                              Icon(
                                Icons.inventory_2_outlined,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No products found in this price range',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Try adjusting the price filter',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: 24,
                            mainAxisSpacing: 24,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProductPage(product: product),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey[300]!),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product Image
                                    AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[300]!),
                                          ),
                                        ),
                                        child: Image.network(
                                          product.imageUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey[200],
                                              child: const Center(
                                                child: Icon(
                                                  Icons.image_not_supported,
                                                  size: 48,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    // Product Details
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.name,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 8),
                                            if (product.isSale &&
                                                product.salePrice != null)
                                              Row(
                                                children: [
                                                  Text(
                                                    '\$${product.salePrice!.toStringAsFixed(2)}',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    '\$${product.price.toStringAsFixed(2)}',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[600],
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            else
                                              Text(
                                                '\$${product.price.toStringAsFixed(2)}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                  // Pagination Controls
                  if (totalPages > 1) ...[
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Previous Button
                        IconButton(
                          onPressed: currentPage > 1
                              ? () {
                                  setState(() {
                                    currentPage--;
                                  });
                                }
                              : null,
                          icon: const Icon(Icons.chevron_left),
                          style: IconButton.styleFrom(
                            backgroundColor: currentPage > 1
                                ? const Color(0xFF4d2963)
                                : Colors.grey[300],
                            foregroundColor: currentPage > 1
                                ? Colors.white
                                : Colors.grey[500],
                            padding: const EdgeInsets.all(12),
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Page Numbers
                        ...List.generate(totalPages, (index) {
                          final pageNumber = index + 1;
                          final isCurrentPage = pageNumber == currentPage;

                          // Show first page, last page, current page, and pages around current
                          if (pageNumber == 1 ||
                              pageNumber == totalPages ||
                              (pageNumber >= currentPage - 1 &&
                                  pageNumber <= currentPage + 1)) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    currentPage = pageNumber;
                                  });
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: isCurrentPage
                                        ? const Color(0xFF4d2963)
                                        : Colors.white,
                                    border: Border.all(
                                      color: isCurrentPage
                                          ? const Color(0xFF4d2963)
                                          : Colors.grey[300]!,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$pageNumber',
                                      style: TextStyle(
                                        color: isCurrentPage
                                            ? Colors.white
                                            : Colors.black87,
                                        fontWeight: isCurrentPage
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else if (pageNumber == currentPage - 2 ||
                              pageNumber == currentPage + 2) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                '...',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }),

                        const SizedBox(width: 16),
                        // Next Button
                        IconButton(
                          onPressed: currentPage < totalPages
                              ? () {
                                  setState(() {
                                    currentPage++;
                                  });
                                }
                              : null,
                          icon: const Icon(Icons.chevron_right),
                          style: IconButton.styleFrom(
                            backgroundColor: currentPage < totalPages
                                ? const Color(0xFF4d2963)
                                : Colors.grey[300],
                            foregroundColor: currentPage < totalPages
                                ? Colors.white
                                : Colors.grey[500],
                            padding: const EdgeInsets.all(12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
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
