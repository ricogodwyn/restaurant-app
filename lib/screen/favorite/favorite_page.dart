import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_app/provider/detail/local_database_provider.dart';
import 'package:restaurant_app/screen/favorite/favorite_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  static const String _urlHead =
      "https://restaurant-api.dicoding.dev/images/small/";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LocalDatabaseProvider>().loadAllProfileValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites",
        style: TextStyle(fontWeight: FontWeight.bold),)),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Consumer<LocalDatabaseProvider>(
                builder: (context, value, child) {
                  final restaurantList =
                      value.restaurantList ?? []; // default to empty list

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: restaurantList.length,
                    itemBuilder: (context, index) {
                      final restaurant = restaurantList[index];
                      return Padding(
                        padding: EdgeInsetsGeometry.symmetric(vertical: 8),
                        child: FavoriteCard(
                          urlHead: _urlHead,
                          restaurant: restaurant,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
