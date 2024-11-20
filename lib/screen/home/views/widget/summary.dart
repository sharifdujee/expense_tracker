import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../expense_repository/src/firbase_expense_repo.dart';
import '../../../../expense_repository/src/model/expense_model.dart';
import '../../../add_expense/blocs/income_bloc/get_income/get_income_bloc.dart';


class Summary extends StatelessWidget {
  const Summary({super.key, required this.expenses});

  final List<MyExpense> expenses;

  // Method to calculate total expense
  double calculateTotalExpense() {
    return expenses.fold(0.0, (sum, item) {
      return sum + item.amount.toDouble();
    });
  }

  // Method to calculate total balance
  double calculateTotalBalance(double income, double expenses) {
    return income - expenses;
  }

  @override
  Widget build(BuildContext context) {
    double totalExpense = calculateTotalExpense();

    return BlocProvider(
      create: (_) => GetIncomeBloc(FirebaseExpenseRepo())..add(GetIncome()),
      child: BlocBuilder<GetIncomeBloc, GetIncomeState>(
        builder: (context, state) {
          double totalIncome = 0.0;

          if (state is GetIncomeSuccess) {
            // Ensure the income list is not null and contains valid entries
            totalIncome = state.income.fold<double>(
              0.0,
                  (sum, income) {
                // Log each income for debugging
                //print("Processing income: ${income.totalIncome}");
                return sum + (income.totalIncome ?? 0.0);
              },
            );

            // Log the final calculated total income
            //print("Total Income: $totalIncome");
          }


          // Calculate total balance
          double totalBalance =
              calculateTotalBalance(totalIncome, totalExpense);

          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.tertiary,
                ],
                transform: const GradientRotation(pi / 4),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Colors.grey.shade300,
                  offset: const Offset(5, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Total Balance',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '৳${totalBalance.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: Colors.white30,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                CupertinoIcons.arrow_down,
                                size: 12,
                                color: Colors.greenAccent,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),

                          /// income
                          Column(
                            children: [
                              const Text(
                                'Income:',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '৳ ${totalIncome.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: Colors.white30,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                CupertinoIcons.arrow_down,
                                size: 12,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),

                          /// expense
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Expenses',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '৳ ${totalExpense.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
