import 'package:flutter/material.dart';

class CommonFooter extends StatelessWidget {
  const CommonFooter({super.key});

  void placeholderCallbackForButtons() {}

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
