# Authentication System Documentation

## Overview

The Union Shop now has a complete authentication and account management system with support for email/password login, Google Sign-In, and Facebook Sign-In.

## Features Implemented

### 1. **Authentication Methods**

- **Email/Password**: Traditional signup and login
- **Google Sign-In**: One-click authentication with Google
- **Facebook Sign-In**: One-click authentication with Facebook

### 2. **Account Dashboard**

Accessible at `/account` route after login, includes:

#### Dashboard Tab

- Overview statistics: Total Orders, Shipped, Delivered
- Recent orders summary
- Quick stats cards with color coding

#### My Orders Tab

- Complete order history
- Order status tracking (Pending, Processing, Shipped, Delivered, Cancelled)
- Order details with product images
- Tracking numbers
- Order dates and amounts

#### Profile Settings Tab

- Edit full name
- Update email address
- Update phone number
- Save changes functionality

#### Addresses Tab

- Manage shipping address
- Street address
- City
- Postal code
- Country
- Save address functionality

#### Change Password Tab

- Current password verification
- New password entry
- Password confirmation
- Secure password update

### 3. **User Model**

Located in `lib/models/user_model.dart`:

```dart
- id: Unique user identifier
- name: Full name
- email: Email address
- photoUrl: Profile picture URL
- phoneNumber: Contact number
- address: Street address
- city: City
- postalCode: Postal code
- country: Country
- createdAt: Account creation date
- authProvider: 'email', 'google', or 'facebook'
```

### 4. **Order Model**

Located in `lib/models/order_model.dart`:

```dart
- id: Order number
- userId: Associated user
- items: List of OrderItem
- totalAmount: Order total
- status: Order status
- orderDate: Purchase date
- trackingNumber: Shipping tracking
- shippingAddress: Delivery address
- paymentMethod: Payment type
```

### 5. **Authentication Service**

Located in `lib/services/auth_service.dart`:

#### Methods:

- `loginWithEmail(email, password)`: Email/password login
- `signupWithEmail(name, email, password)`: Create new account
- `signInWithGoogle()`: Google OAuth login
- `signInWithFacebook()`: Facebook OAuth login
- `updateProfile(user)`: Update user information
- `changePassword(current, new)`: Change password
- `resetPassword(email)`: Password reset
- `logout()`: Sign out user

#### State Management:

- Extends `ChangeNotifier` for reactive state updates
- `currentUser`: Currently authenticated user
- `isLoading`: Loading state indicator
- `isAuthenticated`: Auth status boolean

## User Flow

### Registration Flow:

1. User visits `/signup`
2. Options:
   - Fill email/password form + agree to terms → Create account
   - Click "Sign up with Google" → Google auth → Account created
   - Click "Sign up with Facebook" → Facebook auth → Account created
3. Redirect to `/account` dashboard

### Login Flow:

1. User visits `/login`
2. Options:
   - Enter email/password → Authenticate → Redirect to dashboard
   - Click "Continue with Google" → Google auth → Redirect to dashboard
   - Click "Continue with Facebook" → Facebook auth → Redirect to dashboard

### Account Management Flow:

1. User authenticated and on `/account`
2. Navigate between tabs:
   - Dashboard: View stats and recent orders
   - My Orders: Browse full order history
   - Profile Settings: Update personal information
   - Addresses: Manage shipping addresses
   - Change Password: Update security credentials
3. Logout: Confirm → Sign out → Redirect to home

## Navigation Integration

### Common Header Updates:

- Account icon navigates to `/login` if not authenticated
- Account icon navigates to `/account` if authenticated
- Shows user state throughout the app

### Protected Routes:

- `/account` automatically redirects to `/login` if user not authenticated
- After login/signup, redirects to `/account` dashboard

## Implementation Notes

### Current State (Demo/Development):

- AuthService uses simulated API calls with delays
- All login attempts with valid format succeed (demo mode)
- User data stored in memory (resets on app restart)
- Order data is mocked for demonstration

### Production Ready Features:

- Full user model with all relevant fields
- Complete CRUD operations for profile management
- Order history tracking structure
- Multi-provider authentication architecture
- Proper error handling and validation
- Loading states for async operations
- Logout confirmation dialogs
- Form validation on all inputs

## To Make Production Ready:

### 1. Backend Integration:

- Replace simulated API calls with actual HTTP requests
- Connect to Firebase Auth for Google/Facebook OAuth
- Implement proper JWT token management
- Add secure password hashing
- Set up email verification

### 2. Data Persistence:

- Connect to database for user profiles
- Implement order management system
- Add shopping cart integration with auth
- Save user preferences

### 3. Security Enhancements:

- Add rate limiting for login attempts
- Implement 2FA (two-factor authentication)
- Add session management
- Secure token storage
- Password strength requirements

### 4. Additional Features:

- Email verification on signup
- Password reset via email
- Social profile picture sync
- Remember me functionality
- Account deletion option
- Export user data (GDPR compliance)

## File Structure:

```
lib/
├── models/
│   ├── user_model.dart          # User data model
│   └── order_model.dart         # Order data model
├── services/
│   └── auth_service.dart        # Authentication service
├── account_dashboard.dart        # Main dashboard UI
├── login_page.dart              # Login page (updated)
├── signup_page.dart             # Signup page (updated)
├── common_header.dart           # Header (updated)
└── main.dart                    # App entry (updated)
```

## Usage Example:

```dart
// Access auth service in any widget
final authService = AuthService();

// Check if user is logged in
if (authService.isAuthenticated) {
  // User is logged in
  final user = authService.currentUser;
  print('Welcome ${user.name}!');
}

// Login
await authService.loginWithEmail('user@example.com', 'password');

// Logout
await authService.logout();
```

## Testing the System:

1. **Test Email Login**:

   - Go to login page
   - Enter any email format and password (6+ chars)
   - Click LOGIN
   - Should redirect to dashboard

2. **Test Social Login**:

   - Click "Continue with Google" or Facebook
   - Should create demo account and redirect to dashboard

3. **Test Dashboard**:

   - View all tabs
   - Edit profile information
   - Check order history
   - Update addresses
   - Change password
   - Logout

4. **Test Registration**:
   - Go to signup page
   - Fill form and accept terms
   - Create account
   - Should redirect to dashboard

## Support:

For any authentication issues or feature requests, check the console logs which include detailed error messages and state changes.
