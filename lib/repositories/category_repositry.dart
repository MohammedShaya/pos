
import 'package:dio/dio.dart';
import 'package:pos/models/category_model.dart';
import 'package:pos/models/respones_model.dart';
import 'package:pos/utls/urls.dart';

class CategoryRepository {
  Dio dio = Dio();
  Future<ResponseModel<List<CategoryModel>>> getCategroy() async {
    ResponseModel<List<CategoryModel>> response =
        ResponseModel(success: false, message: "", data: null, error: "");
    try {
      //   final res= await rootBundle.loadString('assets/cats.json');
      //    final Map<String, dynamic> data = json.decode(res);
      // response = ResponseModel.fromJson(data, (data) =>(data as List<dynamic>).map((item)=>CategoryModel.fromJson(item)).toList());
      final res = await dio.get(Urls.baseUrl + Urls.categoryUrl);
      if (res.statusCode == 200) {
        response = ResponseModel.fromJson(
            res.data,
            (data) => (data as List<dynamic>)
                .map((item) => CategoryModel.fromJson(item))
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
