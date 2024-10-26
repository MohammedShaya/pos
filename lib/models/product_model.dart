
import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    int id;
    int categoryId;
    String name;
    int price;
    String imagePath;
    int? quantity;

    ProductModel({
        required this.id,
        required this.categoryId,
        required this.name,
        required this.price,
        required this.imagePath,
         this.quantity,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        categoryId: json["categoryId"],
        name: json["name"],
        price: json["price"],
        imagePath: json["imagePath"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "categoryId": categoryId,
        "name": name,
        "price": price,
        "imagePath": imagePath,
        "quantity": quantity,
    };
}
