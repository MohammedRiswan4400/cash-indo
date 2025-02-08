class IncomeModel {
  final int? id;
  final double amount;
  final String category;
  final String comment;
  final String? today;
  final String currency;
  final DateTime? createdAt;

  IncomeModel({
    this.id,
    required this.amount,
    required this.category,
    required this.comment,
    this.today, // Allow null values
    required this.currency,
    this.createdAt,
  });

  factory IncomeModel.fromMap(Map<String, dynamic> data) {
    return IncomeModel(
      id: data['id'],
      today: data['today'],
      amount: (data['amount'] as num).toDouble(),
      category: data['category'] ?? '',
      comment: data['comment'] ?? '',
      currency: data['currency'] ?? '',
      // createdAt: data['createdAt']?.toDate() ?? DateTime.now(),
      createdAt: data['created_at'] != null
          ? DateTime.parse(data['created_at'])
          : null,
    );
  }
}
