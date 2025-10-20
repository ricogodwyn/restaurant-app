import 'package:restaurant_app/data/model/list_restaurant_response.dart';

sealed class ListRestaurantResultState {}
class ListRestaurantResultNoneState extends ListRestaurantResultState {}

class ListRestaurantLoadingState extends ListRestaurantResultState {}

class ListRestaurantErrorState extends ListRestaurantResultState {
  final String error;
  ListRestaurantErrorState(this.error);
}

class ListRestaurantLoadedState extends ListRestaurantResultState {
  final List<Restaurant> data;
  ListRestaurantLoadedState(this.data);
}
