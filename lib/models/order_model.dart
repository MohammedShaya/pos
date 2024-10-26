// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

import 'package:pos/models/product_model.dart';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  int? discount=0;
  List<ProductModel>? items;
  double get subTotal=>items!.fold(0,(sum,item)=>sum+item.price*item.quantity!);
  double get vat=>(subTotal-(discount??0))*15/100;
  double get total=>subTotal-(discount??0)+vat;
  OrderModel({
    this.discount,
    this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        discount: json["discount"],
        items: json["items"] == null
            ? []
            : List<ProductModel>.from(
                json["items"]!.map((x) => ProductModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subTotal": subTotal,
        "discount": discount??0,
        "vat": vat,
        "total": total,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}
