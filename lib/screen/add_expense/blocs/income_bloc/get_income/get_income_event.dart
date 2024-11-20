part of 'get_income_bloc.dart';

@immutable
sealed class GetIncomeEvent {
  const GetIncomeEvent();

  List<Object> get props => [];
}

class GetIncome extends GetIncomeEvent {}

