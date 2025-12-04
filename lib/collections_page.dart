import 'package:flutter/material.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/common_footer.dart';
import 'package:union_shop/common_header.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  // Get all unique categories with their first product image
  Map<String, String> getCategoryImages() {
    final Map<String, String> categoryImages = {};

    for (var product in productDatabase) {
      if (!categoryImages.containsKey(product.category)) {
        categoryImages[product.category] = product.imageUrl;
      }
    }

    return categoryImages;
  }

  @override
  Widget build(BuildContext context) {
    final categoryImages = getCategoryImages();
    final categories = categoryImages.keys.toList()..sort();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            const CommonHeader(),
            // Header Section
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
                  const Text(
                    'COLLECTIONS',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Browse our curated collections',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),

            // Collections Grid
            Container(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final imageUrl = categoryImages[category]!;

                      return _buildCategoryCard(
                        context,
                        category,
                        imageUrl,
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

  Widget _buildCategoryCard(
      BuildContext context, String category, String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/category/$category',
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.grey[300]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Product image
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[900],
                  child: Center(
                    child: Icon(
                      Icons.category,
                      size: 64,
                      color: Colors.grey[600],
                    ),
                  ),
                );
              },
            ),
            // Black transparent overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            // Category name centered on image
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  category.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
