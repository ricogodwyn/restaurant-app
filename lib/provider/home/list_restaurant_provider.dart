import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class ListRestaurantProvider extends ChangeNotifier{
  final ApiServices _apiServices;

  ListRestaurantProvider(this._apiServices);
  ListRestaurantResultState _state = ListRestaurantResultNoneState();
  ListRestaurantResultState get state => _state;

  Future<void> fetchListRestaurantProvider() async{
    try{
      _state = ListRestaurantLoadingState();
      notifyListeners();

      final res = await _apiServices.getRestaurantList();
      if(res.error){
        _state = ListRestaurantErrorState(res.message);
        notifyListeners();
      } else {
        _state = ListRestaurantLoadedState(res.restaurants);
        notifyListeners();
      }
    } on Exception catch (e) {
    _state = ListRestaurantErrorState(e.toString());
    notifyListeners();
    }
  }
}