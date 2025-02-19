class DebitModel {
  final int? id;
  final double amount;
  final String comment;
  final String currency;
  final DateTime? createdAt;
  final String contactName;
  final String contactPhone;
  final bool? isSend;
  final bool? isAdding;

  DebitModel({
    this.id,
    this.isAdding,
    required this.contactName,
    required this.contactPhone,
    required this.amount,
    required this.comment,
    required this.currency,
    this.isSend,
    this.createdAt,
  });

  factory DebitModel.fromMap(Map<String, dynamic> data) {
    return DebitModel(
      id: data['id'] != null
          ? int.tryParse(data['id'].toString())
          : null, // ✅ Ensure id is int
      isAdding: data['is_adding'] is bool
          ? data['is_adding']
          : false, // ✅ Ensure boolean
      contactName: data['contact_name'] ?? '',
      contactPhone: data['contact_phone'] ?? '',
      amount: (data['amount'] as num).toDouble(), // ✅ Ensure double
      isSend:
          data['is_send'] is bool ? data['is_send'] : false, // ✅ Ensure boolean
      comment: data['comment'] ?? '',
      currency: data['currency'] ?? '',
      createdAt: data['created_at'] != null
          ? DateTime.parse(data['created_at'])
          : null,
    );
  }
}
