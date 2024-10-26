
import 'dart:convert';

LoginPost loginPostFromJson(String str) => LoginPost.fromJson(json.decode(str));

String loginPostToJson(LoginPost data) => json.encode(data.toJson());

class LoginPost {
    String username;
    String password;

    LoginPost({
        required this.username,
        required this.password,
    });

    factory LoginPost.fromJson(Map<String, dynamic> json) => LoginPost(
        username: json["username"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
    };
}
