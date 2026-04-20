import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String description;
  final String color;
  final String icon;
  final bool isDefault;
  final String? userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  const Category({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
    required this.icon,
    this.isDefault = false,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
  });
  
  @override
  List<Object?> get props => [
    id, name, description, color, icon, isDefault, userId, createdAt, updatedAt
  ];
  
  Category copyWith({
    String? id,
    String? name,
    String? description,
    String? color,
    String? icon,
    bool? isDefault,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      isDefault: isDefault ?? this.isDefault,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'color': color,
      'icon': icon,
      'isDefault': isDefault,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
  
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      color: map['color'] ?? '#000000',
      icon: map['icon'] ?? 'category',
      isDefault: map['isDefault'] ?? false,
      userId: map['userId'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
