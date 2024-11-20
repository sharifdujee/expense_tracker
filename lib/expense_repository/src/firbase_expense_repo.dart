import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/expense_repository/expense_repository.dart';

class FirebaseExpenseRepo implements ExpenseRepository {
  final categoryCollection = FirebaseFirestore.instance.collection('categories');
  final expenseCollection = FirebaseFirestore.instance.collection('expenses');
  final incomeCollection = FirebaseFirestore.instance.collection('income');

  @override
  Future<void> createCategory(MyCategory category) async {
    try {
      await categoryCollection
          .doc(category.categoryId)
          .set(category.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// fetch category
  @override
  Future<List<MyCategory>> getCategory() async {
    try {
      return await categoryCollection.get().then((value) => value.docs
          .map(
              (e) => MyCategory.fromEntity(CategoryEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// create expense
  @override
  Future<void> createExpense(MyExpense expense) async {
    try {
      await expenseCollection
          .doc(expense.expenseId)
          .set(expense.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// fetch expense
  @override
  Future<List<MyExpense>> getExpense() async {
    try {
      return await expenseCollection.get().then((value) => value.docs
          .map(
              (e) => MyExpense.fromEntity(ExpenseEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// create income
  @override
  Future<void> createIncome(Income income) async {
    try {
      await incomeCollection
          .doc(income.incomeId)
          .set(income.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
/// fetch income
  @override
  Future<List<Income>> getIncome() async {
    try {
      final snapshot = await incomeCollection.get();
      log('Fetched ${snapshot.docs.length} income entries');
      return snapshot.docs
          .map((e) => Income.fromEntity(IncomeEntity.fromDocument(e.data())))
          .toList();
    } catch (e) {
      log('Error in getIncome: $e');
      rethrow;
    }
  }

}
