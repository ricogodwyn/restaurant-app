import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:restaurant_app/provider/detail/local_database_provider.dart';
import 'package:restaurant_app/screen/detail/comment_card.dart';
import 'package:restaurant_app/screen/detail/grid_builder.dart';

class BodyDetailPage extends StatefulWidget {
  static const String _urlHead =
      "https://restaurant-api.dicoding.dev/images/small/";
  const BodyDetailPage({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  State<BodyDetailPage> createState() => _BodyDetailPageState();
}

class _BodyDetailPageState extends State<BodyDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LocalDatabaseProvider>().loadProfileValueById(widget.restaurant.id);
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16),
              child: Hero(
                tag: widget.restaurant.pictureId,
                child: Image.network(
                  BodyDetailPage._urlHead + widget.restaurant.pictureId,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.restaurant.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Consumer<LocalDatabaseProvider>(
                        builder: (context, value, child) {
                          return IconButton(
                              onPressed: () {
                                if(value.restaurant?.name == widget.restaurant.name){
                                  context.read<LocalDatabaseProvider>()
                                      .removeProfileValueById(widget.restaurant.id);
                                } else {
                                  context.read<LocalDatabaseProvider>()
                                      .saveRestaurantValue(widget.restaurant);
                                }
                              },
                              icon: Icon(value.restaurant?.name == widget.restaurant.name
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                                color: Colors.red,
                              )
                          );
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 20),
                      SizedBox(width: 2),
                      Text(
                        widget.restaurant.city,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.star, size: 20,color: Colors.orange),
                      SizedBox(width: 2),
                      Text(
                        widget.restaurant.rating.toString(),
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.restaurant.address,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.restaurant.categories.length,
                      itemBuilder: (context, index) {
                        final category = widget.restaurant.categories[index];
                        return Row(
                          children: [
                            Chip(
                              label: Text(
                                category.name,
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.green[700],
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox.square(dimension: 16),
                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(widget.restaurant.description),
                  SizedBox.square(dimension: 16),
                  Text(
                    "Menus",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox.square(dimension: 8),
                  Text(
                    "Foods",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  GridBuilder(
                    itemCount: widget.restaurant.menus.foods.length,
                    arrayItem: widget.restaurant.menus.foods,
                    urlHead: BodyDetailPage._urlHead,
                    picID: widget.restaurant.pictureId,
                  ),
                  Text(
                    "Drinks",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  GridBuilder(
                    itemCount: widget.restaurant.menus.drinks.length,
                    arrayItem: widget.restaurant.menus.drinks,
                    urlHead: BodyDetailPage._urlHead,
                    picID: widget.restaurant.pictureId,
                  ),
                  Text(
                    "Reviews",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.restaurant.customerReviews.length,
                      itemBuilder: (context, index) {
                        final review = widget.restaurant.customerReviews[index];
                        return CommentCard(review: review);
                      }),
                ],
              ),
            )
          ]),
        ));
  }
}