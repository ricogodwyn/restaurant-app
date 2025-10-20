import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';


class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
    required this.review,
  });

  final CustomerReview review;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Card(

              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 2),
                        Text(review.date,
                          style: TextStyle(
                            fontSize: 12,
                          ),)
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        SizedBox(width: 2),
                        Expanded(
                          child: Text(review.review,
                            style: TextStyle(
                              fontSize: 15,
                            ),),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}