class UserModel {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final String? phoneNumber;
  final String? address;
  final String? city;
  final String? postalCode;
  final String? country;
  final DateTime createdAt;
  final String authProvider; // 'email', 'google', 'facebook'

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.phoneNumber,
    this.address,
    this.city,
    this.postalCode,
    this.country,
    required this.createdAt,
    required this.authProvider,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? phoneNumber,
    String? address,
    String? city,
    String? postalCode,
    String? country,
    DateTime? createdAt,
    String? authProvider,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      createdAt: createdAt ?? this.createdAt,
      authProvider: authProvider ?? this.authProvider,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
      'address': address,
      'city': city,
      'postalCode': postalCode,
      'country': country,
      'createdAt': createdAt.toIso8601String(),
      'authProvider': authProvider,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      city: json['city'],
      postalCode: json['postalCode'],
      country: json['country'],
      createdAt: DateTime.parse(json['createdAt']),
      authProvider: json['authProvider'],
    );
  }
}
