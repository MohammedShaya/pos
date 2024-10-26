
class ResponseModel<T> {
  final bool? success;
  final String? message;
  final T? data;
  final dynamic error;

  ResponseModel({
    required this.success,
    required this.message,
    required this.data,
    required this.error,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json,T Function (dynamic)? fromJsonT)  {
    return  ResponseModel<T>(
        success: json["success"],
        message: json["message"],
        data: json["data"] !=null && fromJsonT !=null? fromJsonT(json["data"]):null,
        error: json["error"],
      );
  }
  Map<String, dynamic> toJson(Map<String, dynamic> Function(T)? toJsonT ) {
  return  {
        "success": success,
        "message": message,
        "data": data!= null && toJsonT!= null ?toJsonT(data as T):null,
        // "data": data!= null && toJsonT!= null ?toJsonT(data!):null,
        "error": error,
      };
}
}
