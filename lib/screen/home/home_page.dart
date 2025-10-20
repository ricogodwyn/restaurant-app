import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/home/list_restaurant_provider.dart';
import 'package:restaurant_app/screen/home/card_restaurant.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String _urlHead =
      "https://restaurant-api.dicoding.dev/images/small/";
  @override
  void initState() {
    Future.microtask(
      () {
        context.read<ListRestaurantProvider>().fetchListRestaurantProvider();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Restaurants",
          style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: Consumer<ListRestaurantProvider>(
          builder: (context, value, child) {
            return switch (value.state) {
              ListRestaurantLoadingState() =>
                Center(child: CircularProgressIndicator()),
              ListRestaurantErrorState(error: var message) =>
                Center(child: Text(message)),
              ListRestaurantLoadedState(data: var restaurants) =>
                ListView.builder(
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = restaurants[index];
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CardRestaurant(urlHead: _urlHead,
                            restaurant: restaurant),
                      );
                    }),
              _ => const SizedBox()
            };
          },
        ));
  }
}


