import 'package:flutter/material.dart';

class GridBuilder extends StatelessWidget {
  const GridBuilder({
    super.key,
    required String urlHead,
    required this.arrayItem,
    required this.itemCount, required this.picID,
  }) : _urlHead = urlHead;

  final String picID;
  final String _urlHead;
  final int itemCount;
  final List arrayItem;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.9,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final food = arrayItem[index];
        return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 280,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        _urlHead + picID,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(food.name,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,),
                      )
                    ],
                  ),
                ),
              ],
            )
        );
      },
    );
  }
}