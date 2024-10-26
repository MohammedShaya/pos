import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/bloc/order/order_event.dart';
import 'package:pos/bloc/order/order_state.dart';
import 'package:pos/models/order_model.dart';
import 'package:pos/repositories/order_repository.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;
  bool checkoutDone = true;
  OrderBloc(this.orderRepository) : super(OrderUpdeted(order: OrderModel(items: []))) {
    on<AddToOrder>((event, emit) async {
      if (state is OrderIntial) {
        final order = (state as OrderIntial).order;
        final OrderModel updateOrder = _addOrUpdeteOrder(order, event);
        emit(OrderUpdeted(order: updateOrder));
      } else if (state is OrderUpdeted) {
        final order = (state as OrderUpdeted).order;
        final OrderModel updateOrder = _addOrUpdeteOrder(order, event);
        emit(OrderUpdeted(order: updateOrder));
      }
    });
    on<ClearOrder>((event, emit) async {
      if (state is OrderIntial) {
        final order = (state as OrderIntial).order;
        order.discount=0;
        order.items?.clear();
        emit(OrderUpdeted(order: order));
      } else if (state is OrderUpdeted) {
        final order = (state as OrderUpdeted).order;
         order.discount=0;
        order.items?.clear();
        emit(OrderUpdeted(order: order));
      } else if (state is OrderSaved) {
        final order = (state as OrderSaved).order;
         order.discount=0;
        order.items?.clear();
        emit(OrderUpdeted(order: order));
      }
    });
    on<SaveOrder>((event, emit) async {
      if (state is OrderUpdeted) {
        final order = (state as OrderUpdeted).order;
        if (order.items!.isNotEmpty) {
          emit(OrderSaving());
          try {
            final response = await orderRepository.addOrder(order: order);
            if (response.success == true) {
              checkoutDone = true;
              emit(OrderSaved(order: order,message: response.message!));
            } else {
              emit(OrderError(response.message.toString()));
              emit(OrderUpdeted(order: order));
            }
          } catch (e) {
            emit(OrderError(e.toString()));
            emit(OrderUpdeted(order: order));
          }
        } else {
          emit(OrderError('Must be add Product'));
          emit(OrderUpdeted(order: order));
        }
      } else {
        emit(OrderError('Must be add Product'));
      }
    });
    on<AddDiscountOrder>((event, emit) async {
      if (state is OrderUpdeted) {
        final order = (state as OrderUpdeted).order;
        if (order.items!.isNotEmpty) {
          order.discount=event.discount;
          emit(OrderUpdeted(order: order));
        } 
      }
    });
  }

  OrderModel _addOrUpdeteOrder(order, event) {
    final isExsist = order.items.indexWhere((p) => p.id == event.product.id);
    if (isExsist != -1) {
      if (event.type == '-') {
        if (order.items[isExsist].quantity > 1) {
          order.items[isExsist].quantity -= 1;
        } else {
          order.items.removeAt(isExsist);
        }
      } else if (event.type == 'd') {
        order.items.removeAt(isExsist);
      } else {
        order.items[isExsist].quantity += 1;
      }
    } else {
      event.product.quantity = 1;
      order.items.add(event.product);
    }
    return OrderModel(items: List.from(order.items));
  }
}
