import 'package:flutter/material.dart';

class RouteMetaInfoWidget extends StatelessWidget {
  final double rating;
  final int reviewsCount;
  final String routeType;

  const RouteMetaInfoWidget(
      {super.key,
      required this.rating,
      required this.reviewsCount,
      required this.routeType});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: Colors.amber,
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          '4.9',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 3,
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          '120 отзывов',
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(
          width: 6,
        ),
        Container(
          height: 30,
          width: 70,
          decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(40)),
          child: Center(
              child: Text(
            routeType,
            style: TextStyle(color: Colors.green),
          )),
        ),
      ],
    );
  }
}
