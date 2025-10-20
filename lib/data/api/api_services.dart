import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:restaurant_app/data/model/list_restaurant_response.dart';
import 'package:restaurant_app/data/model/search_restaurant_response.dart';

class ApiServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<ListRestaurantResponse> getRestaurantList() async{
    final res = await http.get(Uri.parse("$_baseUrl/list"));
    if(res.statusCode == 200){
      return ListRestaurantResponse.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<DetailRestaurantResponse> getRestaurant(String id) async{
    final res = await http.get(Uri.parse("$_baseUrl/detail/$id"));
    if (res.statusCode == 200){
      return DetailRestaurantResponse.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load restaurant details');
    }
  }
  Future<SearchRestaurantResponse> getRestaurantByName(String params) async{
    final res = await http.get(Uri.parse("$_baseUrl/search?q=$params"));
    if (res.statusCode == 200){
      return SearchRestaurantResponse.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load restaurant details');
    }
  }
}