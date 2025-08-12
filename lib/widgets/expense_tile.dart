// lib/widgets/expense_tile.dart
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const ExpenseTile({
    required this.expense,
    this.onTap,
    this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.simpleCurrency();
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        child: Text(expense.category.substring(0, 1).toUpperCase()),
      ),
      title: Text(expense.title),
      subtitle: Text(
        '${DateFormat.yMMMd().format(expense.date)} • ${expense.category}',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            formatter.format(expense.amount),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
    );
  }
}
