import 'package:flutter/material.dart';

class RouteCreatorInfoWidget extends StatelessWidget {
  final String creatorName;
  const RouteCreatorInfoWidget({super.key, required this.creatorName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  creatorName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Автор маршрута',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      '4.8',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('5 маршрутов', style: TextStyle(color: Colors.grey))
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 60,
            ),
            Icon(Icons.verified)
          ],
        ),
      ),
    );
  }
}
