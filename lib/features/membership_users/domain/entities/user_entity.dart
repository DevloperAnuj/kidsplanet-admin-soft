class UserEntity {
  final String name;
  final String phone;
  final String address;
  final String email;
  final String payId;
  final String expDate;
  final DateTime crtDate;

  const UserEntity({
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
    required this.payId,
    required this.expDate,
    required this.crtDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'email': email,
      'payId': payId,
      'expDate': expDate,
      'crtDate': crtDate,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      name: map['name'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      email: map['email'] as String,
      payId: map['payId'] as String,
      expDate: map['expDate'] as String,
      crtDate: map['crtDate'] as DateTime,
    );
  }
}