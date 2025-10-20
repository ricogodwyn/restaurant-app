import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:restaurant_app/screen/detail/comment_card.dart';
import 'package:restaurant_app/screen/detail/grid_builder.dart';

class BodyDetailPage extends StatelessWidget {
  static const String _urlHead =
      "https://restaurant-api.dicoding.dev/images/small/";
  const BodyDetailPage({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16),
              child: Hero(
                tag: restaurant.pictureId,
                child: Image.network(
                  _urlHead + restaurant.pictureId,
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
                    children: [
                      Text(
                        restaurant.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                        restaurant.city,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.star, size: 20,color: Colors.orange),
                      SizedBox(width: 2),
                      Text(
                        restaurant.rating.toString(),
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        restaurant.address,
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
                      itemCount: restaurant.categories.length,
                      itemBuilder: (context, index) {
                        final category = restaurant.categories[index];
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
                  Text(restaurant.description),
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
                    itemCount: restaurant.menus.foods.length,
                    arrayItem: restaurant.menus.foods,
                    urlHead: _urlHead,
                    picID: restaurant.pictureId,
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
                    itemCount: restaurant.menus.drinks.length,
                    arrayItem: restaurant.menus.drinks,
                    urlHead: _urlHead,
                    picID: restaurant.pictureId,
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
                      itemCount: restaurant.customerReviews.length,
                      itemBuilder: (context, index) {
                        final review = restaurant.customerReviews[index];
                        return CommentCard(review: review);
                      }),
                ],
              ),
            )
          ]),
        ));
  }
}