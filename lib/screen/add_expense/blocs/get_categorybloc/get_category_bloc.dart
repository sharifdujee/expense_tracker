import 'package:bloc/bloc.dart';
import 'package:expense_tracker/expense_repository/expense_repository.dart';
import 'package:meta/meta.dart';

part 'get_category_event.dart';
part 'get_category_state.dart';

class GetCategoryBloc extends Bloc<GetCategoryEvent, GetCategoryState> {
  ExpenseRepository expenseRepository;
  GetCategoryBloc(this.expenseRepository) : super(GetCategoryInitial()) {
    on<GetCategoryEvent>((event, emit)  async{
      emit(GetCategoryLoading());
      try{
       List<MyCategory> categories =  await expenseRepository.getCategory();
        emit(GetCategorySuccess(categories));

      }
      catch(e){
        emit(GetCategoryFailure());
      }


    });
  }
}
