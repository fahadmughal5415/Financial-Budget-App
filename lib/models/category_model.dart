import 'package:budget_app/models/expense_model.dart';

class Category {
  final String name;
  final double maxAmount;
  final List<Expense> expenses;

  Category(
      {required this.name, required this.maxAmount, required this.expenses});
}
