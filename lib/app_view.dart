import 'package:expense_tracker/expense_repository/expense_repository.dart';
import 'package:expense_tracker/screen/add_expense/blocs/get_expense/get_expense_bloc.dart';
import 'package:expense_tracker/screen/add_expense/create_categorybloc/create_category_bloc.dart';
import 'package:expense_tracker/screen/home/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> CreateCategoryBloc(FirebaseExpenseRepo()),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.dark(
            surface: Colors.grey.shade400,
            onSurface: Colors.black,
            primary: const Color(0xFF00B2E7),
            secondary: const Color(0xFFE064F7),
            tertiary: const Color(0xFFFF8D6C),
            outline: Colors.grey,
          )
        ),

        debugShowCheckedModeBanner: false,
        title:  'Expense Tracker',
        home: BlocProvider(
            create: (context) => GetExpenseBloc(FirebaseExpenseRepo())..add(GetExpense()),
            child: const HomeScreen()),
      ),
    );
  }
}
