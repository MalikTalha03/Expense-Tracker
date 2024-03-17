import "package:flutter/material.dart";
import "package:expensetracker/models/expense.dart";
import "package:expensetracker/widgets/expenses_list/expense_item.dart";

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {required this.deleteExpense, required this.expenses, super.key});
  final List<Expense> expenses;
  final void Function(Expense expense) deleteExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        onDismissed: (direction) {
          deleteExpense(expenses[index]);
        },
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}