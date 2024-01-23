import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:witness_project/src/models/AuthModel.dart';
import 'package:witness_project/src/models/ContributionsModel.dart';
import 'package:witness_project/src/repositories/user_repository.dart';
import '../helpers/Helper.dart';
import '../models/LoginResponse.dart';
import '../models/UserModel.dart';


Future<LoginResponseModel?> registerUser(Map map) async {
  print("#register user");
  final String url = '${GlobalConfiguration().getValue('api_base_url')}member/register';
  final client =  http.Client();
  try{
    final response = await client.post(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader:'Bearer ${auth.value?.token??''}'},
      body: json.encode(map),
    ).timeout(const Duration(seconds: 6));
    print(response.body);
    if(response.statusCode==200) {
      UserModel userModel=UserModel.fromJson(json.decode(response.body)['data']);
      return LoginResponseModel(userModel: userModel);
    }
    if(response.statusCode==403) {
      return  LoginResponseModel(userModel: null,message: "Account using this email already exists");

    }
    else{
      return  LoginResponseModel(userModel: null,message: "Something went wrong");
    }
  }on TimeoutException catch (e) {
    return  LoginResponseModel(message: "Network timout error",userModel: null);
  } on SocketException catch (e) {
    return   LoginResponseModel(message: "Check your network connection",userModel: null);
  } on Error catch (e) {
    return  null;
  }

}

Future<LoginResponseModel?> loginAppUser(Map map) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String url = '${GlobalConfiguration().getValue('api_base_url')}member/login';
  final client = new http.Client();
  try{
    final response = await client.post(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader:'Bearer ${auth.value?.token??''}'},
      body: json.encode(map),
    ).timeout(const Duration(seconds: 5));
    if(response.statusCode==200) {
      UserModel userModel=UserModel.fromJson(json.decode(response.body)['data']);
      await prefs.setString('user_details',response.body);
      return  LoginResponseModel(userModel: userModel);
    }
    else if(response.statusCode==202){
      UserModel userModel=UserModel.fromJson(json.decode(response.body)['data']);
      return  LoginResponseModel(userModel: userModel);
    }
    else if(response.statusCode==401){
      return   LoginResponseModel(message: "Incorrect username or password, please contact support",userModel: null);
    }
    else if(response.statusCode==402){
      return   LoginResponseModel(message: "Account does not exists.Please create one",userModel: null);
    }
    else{
      return  LoginResponseModel(message: "Something went wrong .Try again",userModel: null);
    }
  }on TimeoutException catch (e) {
    return   LoginResponseModel(message: "Check your network connection",userModel: null);
  } on SocketException catch (e) {
    return   LoginResponseModel(message: "Check your network connection",userModel: null);
  } on Error catch (e) {
    return   LoginResponseModel(message: "Something went wrong .Try again",userModel: null);

  }

}
Future<AuthModel?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String url = '${GlobalConfiguration().getValue('api_base_url')}signin';
  final client =  http.Client();
  try{
    final response = await client.post(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode({"email":appEmail,"password":appPassword}),
    ).timeout(const Duration(seconds: 5));
    print(response.body);
    if(response.statusCode==200) {
      AuthModel authModel=AuthModel.fromJson(json.decode(response.body)['data']);
      auth.value=authModel;
      auth.notifyListeners();
      await prefs.setString('token',response.body);
      return  authModel;
    }
    else{
      return  null;
    }
  }on TimeoutException catch (e) {
    return  null;
  } on SocketException catch (e) {
    return  null;
  } on Error catch (e) {
    return  null;
  }

}
Future<Stream<ContributionsModel>>get_contributions() async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}contributions/${user.value?.id}';
  Map<String, String> headers = {
    "Content-Type": "application/json",
  "Accept": "application/json",
  "Authorization": "Bearer ${auth.value?.token??''}",
};
  print(url);
  final client = http.Client();
 http.Request request= http.Request('get', Uri.parse(url))..headers.addAll(headers);
  final streamedRest = await client.send(request);
  return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data as Map<String,dynamic>)).expand((data) => (data as List)).map((data) {
    ContributionsModel contributionsModel=ContributionsModel.fromJson(data);
    return contributionsModel;
  });
}