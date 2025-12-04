import 'package:flutter/material.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/common_header.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  List<Product> getSaleProducts() {
    return productDatabase.where((product) => product.isSale).toList();
  }

  @override
  Widget build(BuildContext context) {
    final saleProducts = getSaleProducts();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CommonHeader(),

            // Sale Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4d2963), Color(0xFF6d3983)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'SALE!',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Amazing deals on selected items',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${saleProducts.length} items on sale',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 150),

            // Products Grid
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 600;
                return Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 4 : 20,
                    vertical: isMobile ? 8 : 20,
                  ),
                  child: saleProducts.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_offer_outlined,
                                size: 80,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'No sale items available at the moment',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Builder(
                          builder: (context) {
                            final isWideScreen = constraints.maxWidth > 800;
                            final isMobile = constraints.maxWidth < 600;
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: isWideScreen ? 3 : 1,
                                childAspectRatio: isWideScreen
                                    ? 0.75
                                    : (isMobile ? 0.75 : 1.2),
                                crossAxisSpacing: isMobile ? 8 : 12,
                                mainAxisSpacing: isMobile ? 8 : 12,
                              ),
                              itemCount: saleProducts.length,
                              itemBuilder: (context, index) {
                                final product = saleProducts[index];
                                return _SaleProductCard(product: product);
                              },
                            );
                          },
                        ),
                );
              },
            ),

            // Footer
            Container(
              width: double.infinity,
              color: const Color(0xFF2c2c2c),
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 800) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildAboutSection()),
                            const SizedBox(width: 40),
                            Expanded(child: _buildQuickLinksSection(context)),
                            const SizedBox(width: 40),
                            Expanded(child: _buildContactSection()),
                            const SizedBox(width: 40),
                            Expanded(child: _buildOpeningHoursSection()),
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildAboutSection(),
                            const SizedBox(height: 32),
                            _buildQuickLinksSection(context),
                            const SizedBox(height: 32),
                            _buildContactSection(),
                            const SizedBox(height: 32),
                            _buildOpeningHoursSection(),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Subscribe to our newsletter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
                            hintStyle: TextStyle(color: Colors.grey[500]),
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
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4d2963),
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                        ),
                        child: const Text('SUBSCRIBE'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Divider(color: Colors.grey[700], thickness: 1),
                  const SizedBox(height: 16),
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

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Your trusted source for quality university merchandise and student essentials.',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickLinksSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Links',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildFooterLink('Home', () => Navigator.pushNamed(context, '/')),
        _buildFooterLink(
            'Shop', () => Navigator.pushNamed(context, '/all_products')),
        _buildFooterLink('Sale', () => Navigator.pushNamed(context, '/sales')),
        _buildFooterLink('About', () => Navigator.pushNamed(context, '/about')),
        _buildFooterLink('Cart', () => Navigator.pushNamed(context, '/cart')),
      ],
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Email: shop@union.ac.uk',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
            height: 1.8,
          ),
        ),
        Text(
          'Phone: +44 123 456 7890',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
            height: 1.8,
          ),
        ),
      ],
    );
  }

  Widget _buildOpeningHoursSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Opening Hours',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Mon - Fri: 9:00 AM - 6:00 PM',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
            height: 1.8,
          ),
        ),
        Text(
          'Saturday: 10:00 AM - 4:00 PM',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
            height: 1.8,
          ),
        ),
        Text(
          'Sunday: Closed',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
            height: 1.8,
          ),
        ),
      ],
    );
  }

  Widget _buildFooterLink(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

class _SaleProductCard extends StatelessWidget {
  final Product product;

  const _SaleProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final discount = product.salePrice != null
        ? ((product.price - product.salePrice!) / product.price * 100).round()
        : 0;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with Sale Badge
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(8)),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.image_not_supported,
                                color: Colors.grey, size: 50),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '-$discount%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Product Details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '£${product.salePrice?.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '£${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Save £${(product.price - (product.salePrice ?? product.price)).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF4d2963),
                      fontWeight: FontWeight.w500,
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
