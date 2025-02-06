class ExpenseModel {
  final double amount;
  final String category;
  final String comment;
  final String? today;
  final String currency;
  final DateTime? createdAt;
  final String paymentMethode;

  ExpenseModel({
    required this.paymentMethode,
    required this.amount,
    required this.category,
    required this.comment,
    this.today,
    required this.currency,
    this.createdAt,
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> data) {
    return ExpenseModel(
      paymentMethode: data['payment_methode'],
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
