import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travelcompanion/features/details_route/presentation/widgets/advices_widget.dart';
import 'package:travelcompanion/features/details_route/presentation/widgets/carousel_slider_widget.dart';
import 'package:travelcompanion/features/details_route/presentation/widgets/info_row_widget.dart';
import 'package:travelcompanion/features/details_route/presentation/widgets/map_widget.dart';
import 'package:travelcompanion/features/details_route/presentation/widgets/route_creator_info_widget.dart';
import 'package:travelcompanion/features/details_route/presentation/widgets/route_description_widget.dart';
import 'package:travelcompanion/features/details_route/presentation/widgets/route_meta_info_widget.dart';
import 'package:travelcompanion/features/details_route/presentation/widgets/route_points_widget.dart';
import 'package:travelcompanion/features/details_route/presentation/widgets/route_title_name_widget.dart';
import 'package:travelcompanion/features/routes/data/models/route_model.dart';
import 'package:travelcompanion/features/routes/presentation/providers/interesting_route_points_by_route_id_provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

@RoutePage()
class RouteDescriptionScreen extends ConsumerStatefulWidget {
  final RouteModel route;
  final String routeId;

  const RouteDescriptionScreen(
      {super.key, required this.routeId, required this.route});

  @override
  ConsumerState<RouteDescriptionScreen> createState() => _MyshiState();
}

class _MyshiState extends ConsumerState<RouteDescriptionScreen> {
  late final List<Widget> myItems;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    myItems = widget.route.photoUrls
        .map((url) => Container(
              width: double.infinity,
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSliderWidget(
                route: widget.route,
                items: myItems,
                count: myItems.length,
                activeIndex: currentIndex,
                ref: ref),
            const SizedBox(
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
                  const SizedBox(
                    height: 20,
                  ),
                  RouteCreatorInfoWidget(
                      route: widget.route,
                      creatorName: widget.route.creatorName ?? ''),
                  const SizedBox(height: 20),
                  routeInfo(),
                  const SizedBox(
                    height: 20,
                  ),
                  const RouteDescriptionWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  MapWidget(
                    mapObjects: const [],
                    target: Point(
                        latitude: widget.route.latitude!,
                        longitude: widget.route.longitude!),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  routePointsInfo(ref),
                  const SizedBox(
                    height: 20,
                  ),
                  tipsTile()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tipsTile() {
    return IntrinsicHeight(
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child:const Padding(
            padding:  EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Советы и лайфхаки',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                AdviceWidget(
                    label: 'werwerwerrwqehgrwehkrhjkwehjkrhjkwejhkrjhwkerhjk'),
                SizedBox(height: 10),
                AdviceWidget(label: 'werijovcnjknjwejk'),
                SizedBox(height: 10),
                AdviceWidget(label: 'werjkhwhjekrjhkwejhkr'),
              ],
            ),
          )),
    );
  }

  Widget routePointsInfo(WidgetRef ref) {
    final pointsAsyncValue =
        ref.watch(interestingRoutePointsByRouteIdProvider(widget.routeId));
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
           const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Интересные точки маршрута',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            pointsAsyncValue.when(
              data: (pointsList) {
                if (pointsList.isEmpty) {
                  return const Center(
                    child: Text('Нет интересных точек'),
                  );
                }
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: pointsList.length,
                    itemBuilder: (context, index) {
                      final point = pointsList[index];
                      return RoutePointsWidget(
                          icon: Icons.location_on,
                          label: point.name,
                          description: point.description ?? '');
                    });
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const Center(child: CircularProgressIndicator()),
            )
          ],
        ),
      ),
    );
  }

  Widget routeInfo() {
    return const Row(
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
