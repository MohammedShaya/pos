import 'package:pos/models/product_model.dart';

abstract class OrderEvent {}

class AddToOrder extends OrderEvent {
  final ProductModel product;
  final String type;
  AddToOrder(this.type, {required this.product});
}

class ClearOrder extends OrderEvent {}

class SaveOrder extends OrderEvent {}

class AddDiscountOrder extends OrderEvent {
  final int discount;
  AddDiscountOrder(this.discount);
}
