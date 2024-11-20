part of 'add_income_bloc.dart';

@immutable
sealed class AddIncomeEvent {
  const AddIncomeEvent();
  List<Object> get props => [];
}
class AddIncome extends AddIncomeEvent{
  final Income income;
  const AddIncome(this.income);

  @override
  List<Object> get props => [income];
}


