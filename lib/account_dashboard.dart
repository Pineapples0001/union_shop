import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/services/order_service.dart';
import 'package:union_shop/models/user_model.dart';
import 'package:union_shop/models/order_model.dart';
import 'package:union_shop/common_header.dart';
import 'package:union_shop/common_footer.dart';

class AccountDashboard extends StatefulWidget {
  final AuthService authService;

  const AccountDashboard({super.key, required this.authService});

  @override
  State<AccountDashboard> createState() => _AccountDashboardState();
}

class _AccountDashboardState extends State<AccountDashboard> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    // Wait for auth service to initialize
    if (!widget.authService.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final user = widget.authService.currentUser;

    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/login');
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CommonHeader(),
            SizedBox(height: MediaQuery.of(context).size.width < 768 ? 20 : 40),
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 768;

                return Container(
                  constraints: const BoxConstraints(maxWidth: 1210),
                  margin: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 20),
                  child: isMobile
                      ? Column(
                          children: [
                            // Mobile Menu Dropdown
                            _buildMobileMenu(user),
                            const SizedBox(height: 16),
                            // Content
                            Container(
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
                              padding: const EdgeInsets.all(16),
                              child: _buildContent(user),
                            ),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Sidebar
                            Container(
                              width: 280,
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
                                  // User Profile Section
                                  Container(
                                    padding: const EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4d2963),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundColor: Colors.white,
                                          backgroundImage: user.photoUrl != null
                                              ? NetworkImage(user.photoUrl!)
                                              : null,
                                          child: user.photoUrl == null
                                              ? Text(
                                                  user.name[0].toUpperCase(),
                                                  style: const TextStyle(
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF4d2963),
                                                  ),
                                                )
                                              : null,
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          user.name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          user.email,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                Colors.white.withOpacity(0.8),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Menu Items
                                  _buildMenuItem(
                                    icon: Icons.dashboard_outlined,
                                    title: 'Dashboard',
                                    index: 0,
                                  ),
                                  _buildMenuItem(
                                    icon: Icons.shopping_bag_outlined,
                                    title: 'My Orders',
                                    index: 1,
                                  ),
                                  _buildMenuItem(
                                    icon: Icons.person_outline,
                                    title: 'Profile Settings',
                                    index: 2,
                                  ),
                                  _buildMenuItem(
                                    icon: Icons.location_on_outlined,
                                    title: 'Addresses',
                                    index: 3,
                                  ),
                                  _buildMenuItem(
                                    icon: Icons.lock_outline,
                                    title: 'Change Password',
                                    index: 4,
                                  ),
                                  const Divider(),
                                  _buildLogoutButton(),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            // Main Content
                            Expanded(
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
                                padding: const EdgeInsets.all(32),
                                child: _buildContent(user),
                              ),
                            ),
                          ],
                        ),
                );
              },
            ),
            const SizedBox(height: 60),
            const CommonFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    final isSelected = _selectedTab == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4d2963).withOpacity(0.1) : null,
          border: Border(
            left: BorderSide(
              color: isSelected ? const Color(0xFF4d2963) : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF4d2963) : Colors.grey[600],
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? const Color(0xFF4d2963) : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return InkWell(
      onTap: () async {
        final confirm = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4d2963),
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
        );

        if (confirm == true && mounted) {
          await widget.authService.logout();
          if (mounted) {
            context.go('/');
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Icon(Icons.logout, color: Colors.red[600], size: 20),
            const SizedBox(width: 12),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 15,
                color: Colors.red[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileMenu(UserModel user) {
    final menuItems = [
      {'icon': Icons.dashboard_outlined, 'title': 'Dashboard', 'index': 0},
      {'icon': Icons.shopping_bag_outlined, 'title': 'My Orders', 'index': 1},
      {'icon': Icons.person_outline, 'title': 'Profile Settings', 'index': 2},
      {'icon': Icons.location_on_outlined, 'title': 'Addresses', 'index': 3},
      {'icon': Icons.lock_outline, 'title': 'Change Password', 'index': 4},
    ];

    return Container(
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
          // User Profile Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF4d2963),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white,
                  backgroundImage: user.photoUrl != null
                      ? NetworkImage(user.photoUrl!)
                      : null,
                  child: user.photoUrl == null
                      ? Text(
                          user.name[0].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4d2963),
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Navigation Menu
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<int>(
              value: _selectedTab,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(),
              ),
              items: menuItems.map((item) {
                return DropdownMenuItem<int>(
                  value: item['index'] as int,
                  child: Row(
                    children: [
                      Icon(item['icon'] as IconData, size: 20),
                      const SizedBox(width: 12),
                      Text(item['title'] as String),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedTab = value;
                  });
                }
              },
            ),
          ),
          // Logout Button
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4d2963),
                          ),
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true && mounted) {
                    await widget.authService.logout();
                    if (mounted) {
                      context.go('/');
                    }
                  }
                },
                icon: Icon(Icons.logout, color: Colors.red[600]),
                label: Text(
                  'Logout',
                  style: TextStyle(color: Colors.red[600]),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red[600]!),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(UserModel user) {
    switch (_selectedTab) {
      case 0:
        return _buildDashboard(user);
      case 1:
        return _buildOrders(user);
      case 2:
        return _buildProfileSettings(user);
      case 3:
        return _buildAddresses(user);
      case 4:
        return _buildChangePassword();
      default:
        return _buildDashboard(user);
    }
  }

  Widget _buildDashboard(UserModel user) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: TextStyle(
                fontSize: isMobile ? 22 : 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isMobile ? 16 : 24),
            const Text(
              'Recent Orders',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (context.watch<OrderService>().getUserOrders(user.id).isEmpty)
              Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No orders yet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Start shopping to see your orders here!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              )
            else
              ...context
                  .watch<OrderService>()
                  .getRecentOrders(user.id, limit: 3)
                  .map((order) => _buildOrderCard(order))
                  .toList(),
          ],
        );
      },
    );
  }

  Widget _buildOrders(UserModel user) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Orders',
              style: TextStyle(
                fontSize: isMobile ? 22 : 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isMobile ? 16 : 24),
            if (context.watch<OrderService>().getUserOrders(user.id).isEmpty)
              Center(
                child: Container(
                  padding: const EdgeInsets.all(60),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'No orders yet',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'You haven\'t placed any orders yet.\nStart shopping to see your order history here!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          context.go('/');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4d2963),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: const Text(
                          'START SHOPPING',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              ...context
                  .watch<OrderService>()
                  .getUserOrders(user.id)
                  .map((order) => _buildOrderCard(order))
                  .toList(),
          ],
        );
      },
    );
  }

  Widget _buildOrderCard(OrderModel order) {
    Color statusColor;
    switch (order.status) {
      case 'delivered':
        statusColor = Colors.green;
        break;
      case 'shipped':
        statusColor = Colors.blue;
        break;
      case 'processing':
        statusColor = Colors.orange;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order #${order.id}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order.status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...order.items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Padding(
              padding: EdgeInsets.only(top: index > 0 ? 12 : 0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      item.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[200],
                          child: const Icon(Icons.image),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.productName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Size: ${item.size} | Qty: ${item.quantity}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '£${(item.price * item.quantity).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          const SizedBox(height: 12),
          Divider(color: Colors.grey[300]),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (order.trackingNumber != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Tracking: ${order.trackingNumber}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
              Text(
                'Total: £${order.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSettings(UserModel user) {
    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);
    final phoneController = TextEditingController(text: user.phoneNumber ?? '');

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile Settings',
              style: TextStyle(
                fontSize: isMobile ? 22 : 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isMobile ? 16 : 24),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final updatedUser = user.copyWith(
                  name: nameController.text,
                  email: emailController.text,
                  phoneNumber: phoneController.text.isEmpty
                      ? null
                      : phoneController.text,
                );

                final success =
                    await widget.authService.updateProfile(updatedUser);
                if (success && mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4d2963),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAddresses(UserModel user) {
    final addressController = TextEditingController(text: user.address ?? '');
    final cityController = TextEditingController(text: user.city ?? '');
    final postalController = TextEditingController(text: user.postalCode ?? '');
    final countryController = TextEditingController(text: user.country ?? '');

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shipping Address',
              style: TextStyle(
                fontSize: isMobile ? 22 : 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isMobile ? 16 : 24),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Street Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: postalController,
              decoration: InputDecoration(
                labelText: 'Postal Code',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: countryController,
              decoration: InputDecoration(
                labelText: 'Country',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final updatedUser = user.copyWith(
                  address: addressController.text,
                  city: cityController.text,
                  postalCode: postalController.text,
                  country: countryController.text,
                );

                final success =
                    await widget.authService.updateProfile(updatedUser);
                if (success && mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Address updated successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4d2963),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Save Address'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildChangePassword() {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Change Password',
              style: TextStyle(
                fontSize: isMobile ? 22 : 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isMobile ? 16 : 24),
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Current Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                if (newPasswordController.text !=
                    confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Passwords do not match!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                final success = await widget.authService.changePassword(
                  currentPasswordController.text,
                  newPasswordController.text,
                );

                if (success && mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password changed successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  currentPasswordController.clear();
                  newPasswordController.clear();
                  confirmPasswordController.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4d2963),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Change Password'),
            ),
          ],
        );
      },
    );
  }
}
