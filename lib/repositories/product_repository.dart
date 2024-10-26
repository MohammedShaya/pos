
import 'package:dio/dio.dart';
import 'package:pos/models/product_model.dart';
import 'package:pos/models/respones_model.dart';
import 'package:pos/utls/urls.dart';


class ProductRepository {
  Dio dio = Dio();
  Future<ResponseModel<List<ProductModel>>> getProducts(
      {required int catIndex}) async {
    ResponseModel<List<ProductModel>> response =
        ResponseModel(success: false, message: "", data: null, error: "");
    try {
      // final
      // final res = await rootBundle.loadString('assets/products.json');
      // final Map<String, dynamic> data = json.decode(res);
      // response = ResponseModel.fromJson(
      //     data,
      //     (data) => (data as List<dynamic>)
      //         .map((item) => ProductModel.fromJson(item))
      //         .toList());
     final res = await dio
          .get(Urls.baseUrl + Urls.itemUrl, queryParameters: {"categoryId": catIndex});
      if (res.statusCode == 200) {
        response = ResponseModel.fromJson(
            res.data,
            (data) => (data as List<dynamic>)
                .map((item) => ProductModel.fromJson(item))
                .toList());
      } else {
        response = ResponseModel(
            success: false,
            message: res.statusMessage,
            data: null,
            error: res.statusCode);
      }
    } catch (e) {
      response = ResponseModel(
          success: false, message: e.toString(), data: null, error: e.toString);
    }
    return response;
  }
}
