import 'package:expense_tracker/expense_repository/expense_repository.dart';
import 'package:expense_tracker/screen/home/views/stats/stat_screen.dart';
import 'package:expense_tracker/screen/home/views/widget/header.dart';
import 'package:expense_tracker/screen/home/views/widget/individual_expense.dart';
import 'package:expense_tracker/screen/home/views/widget/summary.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.expenses, required this.income});
  final List<MyExpense> expenses;
  final List<Income> income;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: [
            /// user info
            const Header(),
            const SizedBox(
              height: 20,
            ),

            /// summary
             Summary(expenses: expenses,),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transaction',
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const StatScreen()));
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.outline,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            IndividualExpense(expenses: expenses)
          ],
        ),
      ),
    );
  }
}



/// total exp
