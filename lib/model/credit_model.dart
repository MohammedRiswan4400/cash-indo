class CreditModel {
  final int? id;
  final double amount;
  final String comment;
  final String currency;
  final DateTime? createdAt;
  final String contactName;
  final String contactPhone;
  final bool? isSend;

  CreditModel({
    this.id,
    required this.contactName,
    required this.contactPhone,
    required this.amount,
    required this.comment,
    required this.currency,
    this.isSend,
    this.createdAt,
  });

  factory CreditModel.fromMap(Map<String, dynamic> data) {
    return CreditModel(
      id: data['id'],
      contactName: data['contact_name'],
      contactPhone: data['contact_phone'],
      amount: (data['amount'] as num).toDouble(),
      isSend: data['is_send'] ?? '',
      comment: data['comment'] ?? '',
      currency: data['currency'] ?? '',
      createdAt: data['created_at'] != null
          ? DateTime.parse(data['created_at'])
          : null,
    );
  }
}
