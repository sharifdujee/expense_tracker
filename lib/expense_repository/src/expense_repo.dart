
import 'package:expense_tracker/expense_repository/expense_repository.dart';

abstract class ExpenseRepository {

  /// category creation
  Future<void> createCategory (MyCategory category);

  /// fetch category
  Future<List<MyCategory>> getCategory();

  /// create Expense
  Future<void> createExpense(MyExpense expense);

  /// fetch expense
  Future<List<MyExpense>> getExpense();

  /// create income
  Future<void> createIncome(Income income);

  ///fetch income
  Future<List<Income>> getIncome();

}