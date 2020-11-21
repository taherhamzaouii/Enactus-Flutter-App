import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:manageus_flutter/Models/Data.dart';
import 'package:manageus_flutter/Models/Project.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  String baseUrl = "http://192.168.1.17:3001";

  static final ApiClient _instance = ApiClient.internal();

  Dio baseDio = Dio();

  factory ApiClient() {
    return _instance;
  }

  ApiClient.internal(){

    baseDio.interceptors.add(PrettyDioLogger(requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  Future<dynamic> addProject(Map<String, dynamic> projects) async{
    final url = "/project/add";
    try {
      baseDio.options.headers['content-Type']='application/json';
      Response response = await baseDio.post(this.baseUrl + url, data: projects);
      return true;
  }on DioError catch (err){
     return false;
  }

  }

  Future<dynamic> getAllProjects()async {
    final url ="/project/";
    try{
      baseDio.options.headers['Content-Type']='application/json';
      Response <String> response = await baseDio.get(this.baseUrl+url);
      List<dynamic> map =jsonDecode(response.data);
      for (var u in map ){
        Project p =Project(u["id"],u["name"],u["description"],u["location"],u["category"],u["image"]);
        Data.projects.add(p);
      }
      return map;


    }on DioError catch(e){
      print(e);
      return e.error;
    }
  }




}
