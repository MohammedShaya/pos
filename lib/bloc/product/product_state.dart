import 'package:pos/models/product_model.dart';

abstract class ProductState {}

class ProductIntial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> productList;
  ProductLoaded({required this.productList});
}

class ProductError extends ProductState {
  final String error;
  ProductError(this.error);
}
