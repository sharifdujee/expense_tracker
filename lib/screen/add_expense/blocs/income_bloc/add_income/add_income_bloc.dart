import 'package:bloc/bloc.dart';
import 'package:expense_tracker/expense_repository/expense_repository.dart';
import 'package:meta/meta.dart';

import '../../../../../expense_repository/src/model/income_model.dart';

part 'add_income_event.dart';
part 'add_income_state.dart';

class AddIncomeBloc extends Bloc<AddIncomeEvent, AddIncomeState> {
  final ExpenseRepository expenseRepository;
  AddIncomeBloc(this.expenseRepository) : super(AddIncomeInitial()) {
    on<AddIncome>((event, emit) async{
      emit(AddIncomeLoading());
      try{
        await expenseRepository.createIncome(event.income);
        emit(AddIncomeSuccess());

      }
      catch(e){
        emit(AddIncomeFailure());
      }


    });
  }
}


