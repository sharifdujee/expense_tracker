

import 'package:expense_tracker/expense_repository/expense_repository.dart';

class MyExpense{
  String expenseId;
  MyCategory category;
  DateTime date;
  int amount;


  MyExpense({
    required this.expenseId,
    required this.category,
    required this.date,
    required this.amount
});

  static final empty = MyExpense(expenseId: '', category: MyCategory.empty, date: DateTime.now(), amount: 0);
  ExpenseEntity toEntity(){
    return ExpenseEntity(
      expenseId: expenseId,
      category : category,
      date: date,
      amount: amount
    );
  }

  static MyExpense fromEntity(ExpenseEntity entity){
    return MyExpense(
        expenseId: entity.expenseId,
        category: entity.category,
        date: entity.date,
        amount: entity.amount);
  }
}