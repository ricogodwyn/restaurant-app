import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';

class DetailRestaurantProvider extends ChangeNotifier{
  final ApiServices _apiServices;

  DetailRestaurantProvider(this._apiServices);

  DetailRestaurantResultState _state = DetailRestaurantResultNoneState();

  DetailRestaurantResultState get state => _state;

  Future<void> fetchDetailRestaurant(String id) async{
    try{
      _state = DetailRestaurantLoadingState();
      notifyListeners();

      final res = await _apiServices.getRestaurant(id);
      if(res.error){
        _state = DetailRestaurantErrorState(res.message);
        notifyListeners();
      } else {
        _state = DetailRestaurantLoadedState(res.restaurant);
        notifyListeners();
      }
    } on Exception catch (e){
      _state = DetailRestaurantErrorState(e.toString());
      notifyListeners();
    }
  }
}