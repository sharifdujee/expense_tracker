import 'package:bloc/bloc.dart';
import 'package:expense_tracker/expense_repository/expense_repository.dart';
import 'package:meta/meta.dart';

part 'get_expense_event.dart';
part 'get_expense_state.dart';

class GetExpenseBloc extends Bloc<GetExpenseEvent, GetExpenseState> {
  ExpenseRepository expenseRepository;
  GetExpenseBloc(this.expenseRepository) : super(GetExpenseInitial()) {
    on<GetExpense>((event, emit)async {
      emit(GetExpenseLoading());
      try{
        List<MyExpense> expenses = await expenseRepository.getExpense();
        emit(GetExpenseSuccess(expenses));

      }
      catch(e){
        emit(GetExpenseFailure());
      }
    });
  }
}
