import 'package:flutter/material.dart';
import 'package:union_shop/common_header.dart';
import 'package:union_shop/common_footer.dart';

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
            const CommonFooter(),
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
}
