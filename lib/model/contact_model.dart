class ContactModel {
  final String phoneNumber;
  final String name;
  final DateTime createdAt;

  ContactModel({
    required this.phoneNumber,
    required this.name,
    required this.createdAt,
  });
  factory ContactModel.fromMap(Map<String, dynamic> data) {
    return ContactModel(
      name: data['name'] ?? '',
      phoneNumber: data['phone'] ?? '',
      createdAt: data['createdAt']?.toDate() ?? DateTime.now(),
    );
  }
}
