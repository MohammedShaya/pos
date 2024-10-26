import 'package:pos/models/category_model.dart';

abstract class CategoryState {}

class CategoryIntial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categoryList;
  
  CategoryLoaded({required this.categoryList});
}
class CategorySelected extends CategoryState{
   final int indexCategory;
   CategorySelected({required this.indexCategory});
}
class CategoryError extends CategoryState {
  final String error;
  CategoryError(this.error);
}
