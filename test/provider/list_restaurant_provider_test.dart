import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/list_restaurant_response.dart';
import 'package:restaurant_app/provider/home/list_restaurant_provider.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late MockApiServices mockApi;
  late ListRestaurantProvider provider;

  final dummyRestaurants = [
    Restaurant(
      id: "1",
      name: "Restoran A",
      description: "Desc",
      pictureId: "pic1",
      city: "Jakarta",
      rating: 4.5,
    ),
  ];

  setUp(() {
    mockApi = MockApiServices();
    provider = ListRestaurantProvider(mockApi);
  });

  group("ListRestaurantProvider Test", () {
    test("State awal -> NoneState", () {
      expect(provider.state, isA<ListRestaurantResultNoneState>());
    });

    test("Success -> LoadedState", () async {
      when(() => mockApi.getRestaurantList()).thenAnswer(
            (_) async => ListRestaurantResponse(
          error: false,
          message: "success",
          count: 1,
          restaurants: dummyRestaurants,
        ),
      );

      await provider.fetchListRestaurantProvider();

      expect(provider.state, isA<ListRestaurantLoadedState>());
      final state = provider.state as ListRestaurantLoadedState;
      expect(state.data.length, 1);
    });

    test("Error -> ErrorState", () async {
      when(() => mockApi.getRestaurantList())
          .thenThrow(Exception("API Error"));

      await provider.fetchListRestaurantProvider();

      expect(provider.state, isA<ListRestaurantErrorState>());
      final state = provider.state as ListRestaurantErrorState;
      expect(state.error, contains("API Error"));
    });
  });
}
