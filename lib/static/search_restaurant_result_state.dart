
import 'package:restaurant_app/data/model/search_restaurant_response.dart';

sealed class RestaurantSearchResultState {}
class RestaurantSearchResultStateNoneState extends RestaurantSearchResultState {}

class RestaurantSearchResultStateLoadingState extends RestaurantSearchResultState {}

class RestaurantSearchResultStateErrorState extends RestaurantSearchResultState {
  final String error;
  RestaurantSearchResultStateErrorState(this.error);
}

class RestaurantSearchResultStateLoadedState extends RestaurantSearchResultState {
  final List<Restaurant> data;
  RestaurantSearchResultStateLoadedState(this.data);
}
