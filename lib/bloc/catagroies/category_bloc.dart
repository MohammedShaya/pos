import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/bloc/catagroies/category_event.dart';
import 'package:pos/bloc/catagroies/category_state.dart';
import 'package:pos/repositories/category_repositry.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;
  int selectedCategoryIndex=1;
  CategoryBloc(this.categoryRepository) : super(CategoryIntial()) {
    // add(FetchCategory());
    on<FetchCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        final  response =
            await categoryRepository.getCategroy();
        if (response.success == true) {
          emit(CategoryLoaded(categoryList: response.data!));
        } else {
          emit(CategoryError(response.message.toString()));
        }
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });
    on<SelectCategory>((event, emit) async {
      emit(CategorySelected(indexCategory: event.indexCategory));
      try {
        // final  response =
        //     await categoryRepository.getCategroy();
        // if (response.success == true) {
        //   emit(CategoryLoaded(categoryList: response.data));
        // } else {
        //   emit(CategoryError(response.message.toString()));
        // }
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });
  }

}
