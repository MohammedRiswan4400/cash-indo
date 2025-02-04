class UserModel {
  // final int id;
  final String name;
  final String email;
  final String phoneNumber;
  // final DateTime createdAt;

  UserModel({
    // required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    // required this.createdAt,
  });

  // Factory method to create a UserModel from a Firestore document
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      // id: data['id'] as int,
      name: data['name'] as String,
      email: data['email'] as String,
      phoneNumber: data['phone'] as String,
      // createdAt: data['createdAt']?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'name': name,
      'email': email,
      'phone': phoneNumber,
    };
  }
}
