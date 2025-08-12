// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/expense_notifier.dart';
import '../screens/add_edit_expense_screen.dart';
import '../widgets/expense_tile.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesAsync = ref.watch(expenseListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Expense Tracker'), centerTitle: true),
      body: expensesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
        data: (expenses) {
          final total = expenses.fold<double>(0.0, (p, e) => p + e.amount);
          return Column(
            children: [
              // Top summary
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  elevation: 2,
                  child: ListTile(
                    title: const Text('Total Expenses'),
                    subtitle: Text(
                      '${DateFormat.yMMM().format(DateTime.now())}',
                    ),
                    trailing: Text(
                      NumberFormat.simpleCurrency().format(total),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // List
              Expanded(
                child:
                    expenses.isEmpty
                        ? const Center(
                          child: Text('No expenses yet. Tap + to add one.'),
                        )
                        : ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          itemCount: expenses.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, idx) {
                            final e = expenses[idx];
                            return ExpenseTile(
                              expense: e,
                              onDelete: () async {
                                final confirmed = await showDialog<bool>(
                                  context: context,
                                  builder:
                                      (c) => AlertDialog(
                                        title: const Text('Delete'),
                                        content: const Text(
                                          'Delete this expense?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed:
                                                () => Navigator.pop(c, false),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed:
                                                () => Navigator.pop(c, true),
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      ),
                                );
                                if (confirmed == true) {
                                  await ref
                                      .read(expenseListProvider.notifier)
                                      .deleteExpense(e.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Deleted')),
                                  );
                                }
                              },
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => AddEditExpenseScreen(expense: e),
                                  ),
                                );
                              },
                            );
                          },
                        ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditExpenseScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
