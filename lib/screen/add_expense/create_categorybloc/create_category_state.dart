part of 'create_category_bloc.dart';

@immutable
sealed class CreateCategoryState {
  const CreateCategoryState();

}

final class CreateCategoryInitial extends CreateCategoryState {}
final class CreateCategoryFailure extends CreateCategoryState {}
final class CreateCategoryLoading extends CreateCategoryState {}
final class CreateCategorySuccess extends CreateCategoryState {}

