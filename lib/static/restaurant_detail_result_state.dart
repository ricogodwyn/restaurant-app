import 'package:restaurant_app/data/model/detail_restaurant_response.dart';

sealed class DetailRestaurantResultState {}
class DetailRestaurantResultNoneState extends DetailRestaurantResultState {}

class DetailRestaurantLoadingState extends DetailRestaurantResultState {}

class DetailRestaurantErrorState extends DetailRestaurantResultState {
  final String error;
  DetailRestaurantErrorState(this.error);
}

class DetailRestaurantLoadedState extends DetailRestaurantResultState {
  final Restaurant data;
  DetailRestaurantLoadedState(this.data);
}
