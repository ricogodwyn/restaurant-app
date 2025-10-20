import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search_restaurant/result_state.dart';
import 'package:restaurant_app/provider/search_restaurant/search_restaurant_provider.dart';
import 'package:restaurant_app/screen/search/search_card.dart';
import 'package:restaurant_app/static/search_restaurant_result_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _controller;
  Timer? _debounce;
  static const String _urlHead =
      "https://restaurant-api.dicoding.dev/images/small/";
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Restaurant",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Consumer<ResultState>(
              builder: (context, resultState, child) {
                final controller =
                    TextEditingController(text: resultState.value);

                controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length),
                );

                return TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                  ),
                  onChanged: (value) {
                    resultState.value = value; // 🔄 Update provider value

                    // Optional debounce logic
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      context
                          .read<RestaurantSearchResultProvider>()
                          .fetchSearchRestaurant(value);
                    });
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<RestaurantSearchResultProvider>(
                builder: (context, value, child) {
                  switch (value.state) {
                    case RestaurantSearchResultStateLoadingState():
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case RestaurantSearchResultStateErrorState(error: var msg):
                      return Center(
                        child: Text(msg),
                      );
                    case RestaurantSearchResultStateLoadedState(
                        data: var restaurants
                      ):
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: restaurants.length,
                        itemBuilder: (context, index) {
                          final restaurant = restaurants[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SearchCard(
                              restaurant: restaurant,
                              urlHead: _urlHead,
                            ),
                          );
                        },
                      );
                    default:
                      return Container();
                  }
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
