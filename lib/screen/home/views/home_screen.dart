import 'dart:math';

import 'package:expense_tracker/expense_repository/expense_repository.dart';
import 'package:expense_tracker/screen/add_expense/blocs/create_expense/create_expense_bloc.dart';
import 'package:expense_tracker/screen/add_expense/blocs/get_categorybloc/get_category_bloc.dart';
import 'package:expense_tracker/screen/add_expense/blocs/get_expense/get_expense_bloc.dart';
import 'package:expense_tracker/screen/add_expense/blocs/income_bloc/add_income/add_income_bloc.dart';
import 'package:expense_tracker/screen/add_expense/blocs/income_bloc/get_income/get_income_bloc.dart';
import 'package:expense_tracker/screen/add_expense/create_categorybloc/create_category_bloc.dart';
import 'package:expense_tracker/screen/add_expense/views/add_expense.dart';
import 'package:expense_tracker/screen/home/views/main_screen.dart';
import 'package:expense_tracker/screen/home/views/stats/stat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  int index = 0;
  late Color selectedItem = Colors.blue;
  Color unselectedItem = Colors.grey;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExpenseBloc, GetExpenseState>(
      builder: (context, state){
        if(state is GetExpenseSuccess){
          return  Scaffold(
            appBar: AppBar(
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              child: BottomNavigationBar(
                  onTap: (value){
                    setState(() {
                      index = value;
                    });
                  },
                  //selectedItemColor: Colors.yellow,
                  /* //fixedColor: Colors.red,
              selectedItemColor: Colors.red,
              backgroundColor: Colors.white,
              showSelectedLabels: false,
              showUnselectedLabels: false,*/
                  showUnselectedLabels: false,
                  showSelectedLabels: false,
                  elevation: 3,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(
                          CupertinoIcons.home,
                          color: index == 0? selectedItem: unselectedItem,
                        ),

                        label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.graph_square_fill,
                          color: index == 1? selectedItem: unselectedItem,), label: 'Stats'),

                  ]),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                var newExpense = await Navigator.push(context, MaterialPageRoute<MyExpense>(builder: (context)=>MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context)=> CreateCategoryBloc(FirebaseExpenseRepo()),),
                      BlocProvider(create: (context)=> GetCategoryBloc(FirebaseExpenseRepo())..add(GetCategories())),
                      BlocProvider(create: (context)=> CreateExpenseBloc(FirebaseExpenseRepo()),),
                      BlocProvider(create: (context)=> AddIncomeBloc(FirebaseExpenseRepo())),
                      BlocProvider(create: (_) => GetIncomeBloc(FirebaseExpenseRepo())..add(GetIncome()),
                      ),


                    ],

                    child: const AddExpense(),
                ),
                ),

                );
                if(newExpense !=null){
                  setState(() {
                    state.expenses.insert(0, newExpense);
                  });
                }
              },
              shape: const CircleBorder(),
              child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [
                        Theme.of(context).colorScheme.tertiary,
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.primary,
                      ], transform: const GradientRotation(pi / 4),
                      )),
                  child: const Icon(CupertinoIcons.add)),
            ),
            body: index == 0?
            MainScreen(expenses: state.expenses, income: [],): const StatScreen(),
          );
        }
        else{
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );

        }
      },

    );
  }
}
