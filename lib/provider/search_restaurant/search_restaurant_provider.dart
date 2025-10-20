import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/search_restaurant_result_state.dart';

class RestaurantSearchResultProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantSearchResultProvider(this._apiServices);

  RestaurantSearchResultState _state = RestaurantSearchResultStateNoneState();

  RestaurantSearchResultState get state => _state;

  Future<void> fetchSearchRestaurant(String params) async {
    try {
      _state = RestaurantSearchResultStateLoadingState();
      notifyListeners();

      final res = await _apiServices.getRestaurantByName(params);
      if (res.error) {
        _state = RestaurantSearchResultStateErrorState(
            'Failed to fetch restaurant data');
        notifyListeners();
      } else {
        _state = RestaurantSearchResultStateLoadedState(res.restaurants);
        notifyListeners();
      }
    } on Exception catch (e) {
      _state = RestaurantSearchResultStateErrorState(e.toString());

      notifyListeners();
    }
  }
}
