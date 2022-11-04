import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'IslandAPI.dart';
import 'ItemInfo.dart';

//https://blog.naver.com/nsm4421/222610870141
//https://docs.flutter.dev/coo  kbook/networking/background-parsing
//https://api.flutter.dev/flutter/dart-async/Future-class.html
//https://namu.wiki/w/HTTP/%EC%9D%91%EB%8B%B5%20%EC%BD%94%EB%93%9C#s-5

Future<Island> fetchIsland() async {
  final response =
  await http.get('https://jejunu-capston-1.herokuapp.com/island',
      headers: {
        "Accept": "application/json",
      });

  print(response.statusCode);
  print(response.body);


  if (response.statusCode == 200) {
    // 만약 서버로의 요청이 성공하면, JSON을 파싱합니다.
    print("JSON 파싱 성공");
    return Island.fromJson(json.decode(response.body));
    //return islandFromJson(json.decode(response.body));
  } else {
    // 만약 요청이 실패하면, 에러를 던집니다.
    throw Exception('Failed to load island');
  }
}


Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemOUTPToJson(ItemOutput data) => json.encode(data.toJson());


/*
class IslandRepository extends GetConnect {

//  @override
 // void onInit(){
//httpClient.defaultDecoder = Island.fromJson;
//httpClient.addRequestModifier((request) {
//  request.headers['Authorization'] = 'Bearer sdfsdfgsdfsdsdf12345678';
//  return request;
//});
//    httpClient.baseUrl = 'https://jejunu-capston-1.herokuapp.com';


 // }




  Future<Response<Island>>getIsland() =>
       get<Island>('https://jejunu-capston-1.herokuapp.com/island',
           decoder: (obj) => Island.fromJson(obj)
       );



}*/