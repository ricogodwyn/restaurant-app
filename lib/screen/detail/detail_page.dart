import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail/detail_restaurant_provider.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';

import 'body_detail_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.id});
  final String id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    Future.microtask(
      () {
        context
            .read<DetailRestaurantProvider>()
            .fetchDetailRestaurant(widget.id);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page",
            style: TextStyle(fontWeight: FontWeight.bold)
      )),
      body: Consumer<DetailRestaurantProvider>(
        builder: (context, value, child) {
          return switch (value.state) {
            DetailRestaurantLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
            DetailRestaurantLoadedState(data: var restaurant) =>
              BodyDetailPage(restaurant: restaurant),
            DetailRestaurantErrorState(error: var msg) => Center(
                child: Text(msg),
              ),
            _ => SizedBox()
          };
        },
      ),
    );
  }
}



