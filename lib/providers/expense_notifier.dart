// lib/providers/expense_notifier.dart
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/repository/expense_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  final box = Hive.box<Expense>('expensesBox');
  return ExpenseRepository(box);
});

final expenseListProvider =
    StateNotifierProvider<ExpenseListNotifier, AsyncValue<List<Expense>>>(
      (ref) => ExpenseListNotifier(ref),
    );

class ExpenseListNotifier extends StateNotifier<AsyncValue<List<Expense>>> {
  final Ref ref;
  ExpenseListNotifier(this.ref) : super(const AsyncValue.loading()) {
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    try {
      final repo = ref.read(expenseRepositoryProvider);
      final items = await repo.getAllExpenses();
      state = AsyncValue.data(items);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addExpense(Expense e) async {
    state = const AsyncValue.loading();
    await ref.read(expenseRepositoryProvider).addExpense(e);
    await loadExpenses();
  }

  Future<void> updateExpense(Expense e) async {
    state = const AsyncValue.loading();
    await ref.read(expenseRepositoryProvider).updateExpense(e);
    await loadExpenses();
  }

  Future<void> deleteExpense(String id) async {
    state = const AsyncValue.loading();
    await ref.read(expenseRepositoryProvider).deleteExpense(id);
    await loadExpenses();
  }
}
