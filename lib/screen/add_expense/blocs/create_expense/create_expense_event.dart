part of 'create_expense_bloc.dart';

@immutable
sealed class CreateExpenseEvent {
  const CreateExpenseEvent();

  List<Object> get props => [];
}

class CreateExpense extends CreateExpenseEvent{
  final MyExpense expense;
  const CreateExpense (this.expense);
  @override
  List<Object> get props => [expense];
}
