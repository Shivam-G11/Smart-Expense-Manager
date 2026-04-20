import 'package:equatable/equatable.dart';
import '../../../categories/domain/entities/category.dart';

class Expense extends Equatable {
  final String id;
  final String title;
  final String description;
  final double amount;
  final Category category;
  final DateTime date;
  final String? userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  const Expense({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
  });
  
  @override
  List<Object?> get props => [
    id, title, description, amount, category, date, userId, createdAt, updatedAt
  ];
  
  Expense copyWith({
    String? id,
    String? title,
    String? description,
    double? amount,
    Category? category,
    DateTime? date,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Expense(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'amount': amount,
      'category': category.toMap(),
      'date': date.toIso8601String(),
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
  
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      category: Category.fromMap(map['category']),
      date: DateTime.parse(map['date']),
      userId: map['userId'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
