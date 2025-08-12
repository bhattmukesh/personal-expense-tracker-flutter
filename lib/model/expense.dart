// lib/models/expense.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

//spart 'expense.g.dart'; // Optional if using codegen (we won't use it here)

@immutable
class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  Expense copyWith({
    String? id,
    String? title,
    double? amount,
    DateTime? date,
    String? category,
  }) {
    return Expense(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
    );
  }
}

/// Manual Hive TypeAdapter (typeId must be unique for your app)
class ExpenseAdapter extends TypeAdapter<Expense> {
  @override
  final int typeId = 0;

  @override
  Expense read(BinaryReader reader) {
    final id = reader.readString();
    final title = reader.readString();
    final amount = reader.readDouble();
    final dateMillis = reader.readInt();
    final category = reader.readString();
    return Expense(
      id: id,
      title: title,
      amount: amount,
      date: DateTime.fromMillisecondsSinceEpoch(dateMillis),
      category: category,
    );
  }

  @override
  void write(BinaryWriter writer, Expense obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeDouble(obj.amount);
    writer.writeInt(obj.date.millisecondsSinceEpoch);
    writer.writeString(obj.category);
  }
}
