import 'dart:convert';
import 'package:dio/dio.dart';
//import 'package:http/http.dart' as http;

class AuthRepository{
  login(String email,String password) async {

  final Dio dio = new Dio();
  Response res = await dio.post("http://127.0.0.1:8000/auth/student/login",
      data: {
        "email": email,
        "password": password,
        "fcm_code": "abc-123456"
      },
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        },
        headers: {},
      ));

  if (res.statusCode == 200) {

    return res.data;
  }
  else {
    return res.data;
  }



  }
}