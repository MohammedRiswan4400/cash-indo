class ContactModel {
  final int? id;
  final String phoneNumber;
  final String name;
  final DateTime createdAt;

  ContactModel({
    this.id,
    required this.phoneNumber,
    required this.name,
    required this.createdAt,
  });
  factory ContactModel.fromMap(Map<String, dynamic> data) {
    return ContactModel(
      id: data['id'],
      name: data['name'] ?? '',
      phoneNumber: data['phone'] ?? '',
      createdAt: data['createdAt']?.toDate() ?? DateTime.now(),
    );
  }
}
