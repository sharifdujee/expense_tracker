import 'package:expense_tracker/screen/add_expense/blocs/income_bloc/get_income/get_income_bloc.dart';
import 'package:expense_tracker/screen/home/views/stats/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../expense_repository/src/firbase_expense_repo.dart';

class StatScreen extends StatelessWidget {
  const StatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIncomeBloc(FirebaseExpenseRepo())..add(GetIncome()),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Transactions',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(12, 20, 12, 12),
                    child: MyChart(),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
