import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travelcompanion/features/auth/presentation/providers/auth_provider.dart';
import 'package:travelcompanion/features/routes/data/models/route_model.dart';
import 'package:travelcompanion/features/routes/presentation/providers/favourite_repository_provider.dart';

class CarouselSliderWidget extends StatefulWidget {
  final List<Widget> items;
  final int count;
  int activeIndex;
  final RouteModel route;
  final WidgetRef ref;
  CarouselSliderWidget(
      {super.key,
      required this.items,
      required this.count,
      required this.activeIndex,
      required this.route,
      required this.ref});

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  Future<void> addToFavouriteRoute() async {
    try {
      final rep = widget.ref.read(favouriteRepository);
      final user = widget.ref.watch(authProvider).user;
      await rep.addToFavourite(userId: user!.id, routeId: widget.route.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Маршрут добавлен в избранное')),
        );
      }
    } catch (e) {
      print(e.toString());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: widget.items,
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                widget.activeIndex = index;
              });
            },
            height: 300,
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayInterval: Duration(seconds: 3),
            autoPlay: true,
          ),
        ),
        if (widget.items.length > 1)
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedSmoothIndicator(
                effect: WormEffect(
                  type: WormType.thinUnderground,
                  spacing: 3,
                  dotHeight: 6,
                  dotWidth: 6,
                  activeDotColor: Colors.white,
                  dotColor: const Color.fromARGB(255, 206, 206, 206),
                ),
                activeIndex: widget.activeIndex,
                count: widget.items.length,
              ),
            ),
          ),
        Positioned(
          top: 25,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    border: null,
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        border: null,
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: addToFavouriteRoute,
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        border: null,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.download),
                        onPressed: () {},
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
