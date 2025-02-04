import 'package:cloud_firestore/cloud_firestore.dart';

class IncomeModel {
  final double amount;
  final String category;
  final String comment;
  final String currency;
  final DateTime createdAt;

  IncomeModel({
    required this.amount,
    required this.category,
    required this.comment,
    required this.currency,
    required this.createdAt,
  });

  factory IncomeModel.fromMap(Map<String, dynamic> map) {
    return IncomeModel(
      amount: (map['amount'] as num).toDouble(), // Ensure it's double
      category: map['category'] ?? '',
      comment: map['comment'] ?? '',
      currency: map['currency'] ?? '',
      createdAt: (map['createdAt'] as Timestamp)
          .toDate(), // Convert Firestore Timestamp
    );
  }
}
