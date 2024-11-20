part of 'get_category_bloc.dart';

@immutable
sealed class GetCategoryEvent {
  const GetCategoryEvent();

  List<Object> get props => [];
}

class GetCategories extends GetCategoryEvent{

}

