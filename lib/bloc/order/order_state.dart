import 'package:pos/models/order_model.dart';

abstract class OrderState {}

class OrderIntial extends OrderState {
  final OrderModel order;
  OrderIntial() : order = OrderModel(items: []);
}

class OrderUpdeted extends OrderState {
  final OrderModel order;
  OrderUpdeted({required this.order});
}

class OrderSaving extends OrderState {}

class OrderSaved extends OrderState {
  final OrderModel order;
  final String message;
  OrderSaved({required this.order, required this.message});
}

class OrderError extends OrderState {
  final String error;
  OrderError(this.error);
}
