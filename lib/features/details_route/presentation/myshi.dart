import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:travelcompanion/features/routes/data/models/route_model.dart';

class Myshi extends StatefulWidget {
  final RouteModel route;
  final String routeId;

  Myshi({super.key, required this.routeId, required this.route});

  @override
  State<Myshi> createState() => _MyshiState();
}

class _MyshiState extends State<Myshi> {
  late final List<Widget> myItems;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    myItems = widget.route.photoUrls
            ?.map((url) => Container(
                  width: double.infinity,
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                ))
            .toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                if (myItems.isNotEmpty)
                  CarouselSlider(
                    items: myItems,
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      height: 300,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlay: true,
                    ),
                  )
                else
                  Container(
                    height: 300,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
