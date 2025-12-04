import 'package:flutter/material.dart';
import 'package:union_shop/common_header.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CommonHeader(),

            // About Content
            Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About Union Shop',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4d2963),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Welcome to Union Shop',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Union Shop is your premier destination for quality university merchandise, stationery, and accessories. We are dedicated to providing students, staff, and visitors with the best products to represent and support their university experience.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Our Mission',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'To provide high-quality products and exceptional service to our university community. We strive to offer a diverse range of merchandise that reflects school spirit while maintaining affordable prices for students.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'What We Offer',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildOfferingItem('University branded clothing and apparel'),
                  _buildOfferingItem('Stationery and study essentials'),
                  _buildOfferingItem('Souvenirs and gift items'),
                  _buildOfferingItem('Accessories for everyday use'),
                  _buildOfferingItem('Exclusive student discounts and sales'),
                  const SizedBox(height: 32),
                  const Text(
                    'Visit Us',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Come visit our store or shop online for the best selection of university merchandise. Our friendly staff is always ready to help you find exactly what you need.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
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

  Widget _buildOfferingItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFF4d2963),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
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
