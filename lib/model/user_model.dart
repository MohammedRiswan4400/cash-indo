class UserModel {
  final String name;
  final String email;
  final String phone;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'title': phone,
      'email': email,
    };
  }
}
