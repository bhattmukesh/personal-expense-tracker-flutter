// lib/repository/expense_repository.dart
import 'package:expense_tracker/model/expense.dart';
import 'package:hive/hive.dart';

class ExpenseRepository {
  final Box<Expense> box;

  ExpenseRepository(this.box);

  Future<List<Expense>> getAllExpenses() async {
    final list = box.values.toList();
    list.sort((a, b) => b.date.compareTo(a.date)); // newest first
    return list;
  }

  Future<void> addExpense(Expense e) async {
    await box.put(e.id, e);
  }

  Future<void> updateExpense(Expense e) async {
    await box.put(e.id, e);
  }

  Future<void> deleteExpense(String id) async {
    await box.delete(id);
  }

  Future<void> clearAll() async {
    await box.clear();
  }
}
