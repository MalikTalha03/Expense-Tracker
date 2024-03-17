import "package:flutter/material.dart";
import "package:expensetracker/models/expense.dart";
import "package:expensetracker/widgets/expenses_list/expenses_list.dart";
import "package:expensetracker/widgets/new_expense.dart";
import "package:expensetracker/widgets/chart/chat.dart";

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expenses> {
  final List<Expense> _expenses = [
    Expense(
      title: "Groceries",
      amount: 89.99,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: "Fuel",
      amount: 49.99,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];
  void _openAddExpense() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(addExpense: _addExpense);
        });
  }

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  void _deleteExpense(Expense expense) {
    final index = _expenses.indexOf(expense);
    setState(() {
      _expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Deleted Expense: ${expense.title}"),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _expenses.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text("No expenses added yet!"),
    );

    if (_expenses.isNotEmpty) {
      mainContent =
          ExpenseList(expenses: _expenses, deleteExpense: _deleteExpense);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpense,
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _expenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _expenses)),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
