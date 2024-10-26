
import 'package:dio/dio.dart';
import 'package:pos/models/order_model.dart';
import 'package:pos/models/respones_model.dart';
import 'package:pos/utls/urls.dart';

class OrderRepository {
  Dio dio = Dio();
  Future<ResponseModel> addOrder( {required OrderModel order}) async{
     ResponseModel response= ResponseModel(success: false,message: "",data: null,error: "");
      try {
      final res =  await dio
        .post(Urls.baseUrl + Urls.checkoutUrl, data: orderModelToJson(order));
      if (res.statusCode == 200) {
        response = ResponseModel.fromJson(
            res.data,
            (data) =>data);
      } else {
        response = ResponseModel(
            success: false,
            message: res.statusMessage,
            data: null,
            error: res.statusCode);
      }
    } catch (e) {
      // print(e.)
      response = ResponseModel(
          success: false, message: e.toString(), data: null, error: e.toString);
    }
    return response;
 
  
  }
}
