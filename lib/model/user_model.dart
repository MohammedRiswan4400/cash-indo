class UserModel {
  final String name;
  final String email;
  final String phoneNumber;
  final DateTime createdAt;

  UserModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.createdAt,
  });

  // Factory method to create a UserModel from a Firestore document
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      createdAt: data['createdAt']?.toDate() ?? DateTime.now(),
    );
  }
}
