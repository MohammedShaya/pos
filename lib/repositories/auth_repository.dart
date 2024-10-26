import 'package:dio/dio.dart';
import 'package:pos/models/login_model.dart';
import 'package:pos/models/user_model.dart';
import 'package:pos/models/respones_model.dart';
import 'package:pos/utls/urls.dart';

class AuthRepository{
  Dio dio = Dio();
  Future<ResponseModel<UserModel>> login(LoginPost login) async{
     ResponseModel<UserModel> response= ResponseModel(success: false,message: "",data: null,error: "");
      try {
      final res =  await dio
        .post(Urls.baseUrl + Urls.loginUrl, data: loginPostToJson(login));
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
      response = ResponseModel(
          success: false, message: e.toString(), data: null, error: e.toString);
    }
    return response;
 
  
  }
}