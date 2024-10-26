import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/bloc/product/product_event.dart';
import 'package:pos/bloc/product/product_state.dart';
import 'package:pos/repositories/product_repository.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  ProductBloc(this.productRepository) : super(ProductIntial()) {
    // add(Petchproduct());
    on<FetchProduct>((event, emit) async {
      emit(ProductLoading());
      try {
        final  response =await productRepository.getProducts(catIndex:event.catIndex);
        if (response.success == true) {
          emit(ProductLoaded(productList:response.data!));
        } else {
          emit(ProductError(response.message.toString()));
        }
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
   
  }

}
