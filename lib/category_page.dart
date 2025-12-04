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

  List<Product> getCategoryProducts() {
    return productDatabase
        .where((product) => product.category == widget.categoryName)
        .toList();
  }

  List<Product> getSortedProducts() {
    final products = getCategoryProducts();

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

  @override
  Widget build(BuildContext context) {
    final products = getSortedProducts();

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
                    '${products.length} ${products.length == 1 ? 'Product' : 'Products'}',
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
                  // Sort Filter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

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
                                'No products found in this category',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
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
                            crossAxisCount: 4,
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
