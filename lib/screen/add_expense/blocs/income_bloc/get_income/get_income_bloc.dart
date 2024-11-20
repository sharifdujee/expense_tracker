import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:expense_tracker/expense_repository/expense_repository.dart';
import 'package:meta/meta.dart';

part 'get_income_event.dart';
part 'get_income_state.dart';

class GetIncomeBloc extends Bloc<GetIncomeEvent, GetIncomeState> {
  final ExpenseRepository expenseRepository;
  GetIncomeBloc(this.expenseRepository) : super(GetIncomeInitial()) {
    on<GetIncome>((event, emit) async {
      emit(GetIncomeLoading());
      try {
        List<Income> income = await expenseRepository.getIncome();
        emit(GetIncomeSuccess(income));
      } catch (e) {
        log('Error in GetIncomeBloc: $e');
        emit(GetIncomeFailure()); // Include error details
      }
    });

  }
}


