part of 'add_income_bloc.dart';

@immutable
sealed class AddIncomeState {
  const AddIncomeState();
}

final class AddIncomeInitial extends AddIncomeState {}
final class AddIncomeFailure extends AddIncomeState {}
final class AddIncomeLoading extends AddIncomeState {}
final class AddIncomeSuccess extends AddIncomeState {}


