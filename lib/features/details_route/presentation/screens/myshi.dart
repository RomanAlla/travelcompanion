import 'package:flutter/material.dart';

import 'package:travelcompanion/features/details_route/presentation/widgets/carousel_slider_widget.dart';
import 'package:travelcompanion/features/details_route/presentation/widgets/info_row_widget.dart';
import 'package:travelcompanion/features/details_route/presentation/widgets/map_widget.dart';
import 'package:travelcompanion/features/details_route/presentation/widgets/route_creator_info_widget.dart';
import 'package:travelcompanion/features/details_route/presentation/widgets/route_description_widget.dart';
import 'package:travelcompanion/features/details_route/presentation/widgets/route_meta_info_widget.dart';
import 'package:travelcompanion/features/details_route/presentation/widgets/route_title_name_widget.dart';
import 'package:travelcompanion/features/routes/data/models/route_model.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

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
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSliderWidget(
                items: myItems,
                count: myItems.length,
                activeIndex: currentIndex),
            SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                children: [
                  RouteTitleNameWidget(text: widget.route.name),
                  RouteMetaInfoWidget(
                      rating: 4.9,
                      reviewsCount: 32,
                      routeType: widget.route.routeType),
                  SizedBox(
                    height: 20,
                  ),
                  RouteCreatorInfoWidget(
                      creatorName: widget.route.creatorName!),
                  SizedBox(height: 20),
                  routeInfo(),
                  SizedBox(
                    height: 20,
                  ),
                  RouteDescriptionWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  MapWidget(
                    mapObjects: [],
                    target: Point(
                        latitude: widget.route.latitude!,
                        longitude: widget.route.longitude!),
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget routeInfo() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              InfoIconText(icon: Icons.directions_walk, label: 'fsdfsdf')
            ],
          ),
        ),
        SizedBox(
          width: 7,
        ),
        Expanded(
          child: Column(
            children: [
              InfoIconText(icon: Icons.calendar_month, label: 'rweuyiruiweb')
            ],
          ),
        ),
        SizedBox(
          width: 7,
        ),
        Expanded(
          child: Column(
            children: [InfoIconText(icon: Icons.timer, label: 'weropcxnmnmbv')],
          ),
        ),
        SizedBox(
          width: 7,
        ),
        Expanded(
          child: Column(
            children: [
              InfoIconText(icon: Icons.map, label: 'eqwriu0qwhjnbmmbnxc'),
            ],
          ),
        ),
      ],
    );
  }
}
