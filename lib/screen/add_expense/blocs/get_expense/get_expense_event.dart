part of 'get_expense_bloc.dart';

@immutable
sealed class GetExpenseEvent {
  const GetExpenseEvent();

  List<Object> get props => [];
}

class GetExpense extends GetExpenseEvent{}
