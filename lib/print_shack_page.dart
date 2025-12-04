import 'package:flutter/material.dart';
import 'package:union_shop/common_header.dart';
import 'package:union_shop/common_footer.dart';
import 'package:union_shop/cart_manager.dart';
import 'package:union_shop/main.dart';

class PrintShackPage extends StatefulWidget {
  const PrintShackPage({super.key});

  @override
  State<PrintShackPage> createState() => _PrintShackPageState();
}

class _PrintShackPageState extends State<PrintShackPage> {
  final List<TextEditingController> _textControllers = [
    TextEditingController(),
  ];
  final double basePrice = 7.0;
  final double pricePerLine = 3.0;
  String selectedSize = 'M';

  double get totalPrice {
    return basePrice + (_textControllers.length * pricePerLine);
  }

  void _addLine() {
    setState(() {
      _textControllers.add(TextEditingController());
    });
  }

  void _removeLine(int index) {
    if (_textControllers.length > 1) {
      setState(() {
        _textControllers[index].dispose();
        _textControllers.removeAt(index);
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addToCart() {
    // Check if at least one line has text
    bool hasText =
        _textControllers.any((controller) => controller.text.trim().isNotEmpty);

    if (!hasText) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter at least one line of text'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Create custom product for print
    final customText = _textControllers
        .asMap()
        .entries
        .where((entry) => entry.value.text.trim().isNotEmpty)
        .map((entry) => 'Line ${entry.key + 1}: ${entry.value.text.trim()}')
        .join('\n');

    final customProduct = Product(
      serial: 'CUSTOM_PRINT_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Custom Print - ${_textControllers.length} line(s)',
      category: 'Custom Print',
      description: customText,
      price: totalPrice,
      isSale: false,
      salePrice: null,
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      isVisible: true,
    );

    CartManager().addToCart(customProduct, selectedSize, 1);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Custom print added to cart!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // Clear the form
    setState(() {
      for (var controller in _textControllers) {
        controller.dispose();
      }
      _textControllers.clear();
      _textControllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CommonHeader(),

            // Main Content
            Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side - Preview
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(20),
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
                        children: [
                          const Text(
                            'Preview',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: 400,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[400]!),
                            ),
                            padding: const EdgeInsets.all(40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  _textControllers.asMap().entries.map((entry) {
                                final text = entry.value.text.trim();
                                if (text.isEmpty)
                                  return const SizedBox.shrink();
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    text,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 40),

                  // Right side - Form
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(32),
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
                          const Text(
                            'Print Shack',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Customize your print with text',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Price Display
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4d2963).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Base Price: £${basePrice.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Text(
                                      '+ £${pricePerLine.toStringAsFixed(2)} per line',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '£${totalPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4d2963),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Text Lines
                          const Text(
                            'Your Text Lines',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),

                          ..._textControllers.asMap().entries.map((entry) {
                            final index = entry.key;
                            final controller = entry.value;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: controller,
                                      decoration: InputDecoration(
                                        labelText: 'Line ${index + 1}',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF4d2963),
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {}); // Refresh preview
                                      },
                                    ),
                                  ),
                                  if (_textControllers.length > 1)
                                    IconButton(
                                      icon: const Icon(Icons.close,
                                          color: Colors.red),
                                      onPressed: () => _removeLine(index),
                                    ),
                                ],
                              ),
                            );
                          }).toList(),

                          // Add Line Button
                          TextButton.icon(
                            onPressed: _addLine,
                            icon: const Icon(Icons.add),
                            label: const Text('Add Another Line'),
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF4d2963),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Size Selection
                          const Text(
                            'Size',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: ['S', 'M', 'L', 'XL'].map((size) {
                              final isSelected = selectedSize == size;
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedSize = size;
                                    });
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFF4d2963)
                                          : Colors.white,
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFF4d2963)
                                            : Colors.grey[400]!,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        size,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 32),

                          // Add to Cart Button
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: _addToCart,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4d2963),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'ADD TO CART',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const CommonFooter(),
          ],
        ),
      ),
    );
  }
}
