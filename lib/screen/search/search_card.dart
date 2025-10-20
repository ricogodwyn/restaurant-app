import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/search_restaurant_response.dart';

import 'package:restaurant_app/static/navigation_route.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({
    super.key,
    required String urlHead,
    required this.restaurant,
  }) : _urlHead = urlHead;

  final String _urlHead;
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
            context,
            NavigationRoute.detailRoute.name,
            arguments: restaurant.id);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 80,
              minHeight: 80,
              maxWidth: 120,
              minWidth: 120,
            ),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8),
              child: Hero(
                tag: restaurant.pictureId,
                child: Image.network(
                  _urlHead + restaurant.pictureId,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restaurant.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 15),
                      SizedBox(width: 2),
                      Text(restaurant.city),
                      SizedBox(width: 5,),
                      Icon(Icons.star,
                        size: 18,
                        color: Colors.orangeAccent,),
                      SizedBox(width: 3),
                      Text(restaurant.rating.toString()),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Text(restaurant.description.toString(),
                            overflow:
                            TextOverflow.ellipsis,
                            maxLines: 2),
                      ),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}