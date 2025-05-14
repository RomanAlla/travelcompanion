import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travelcompanion/features/details_route/presentation/myshi.dart';
import 'package:travelcompanion/features/routes/data/models/route_model.dart';
import 'package:travelcompanion/features/routes/presentation/providers/route_repository_provider.dart';
import 'package:travelcompanion/features/routes/presentation/providers/routes_list_provider.dart';

class RouteCard extends ConsumerStatefulWidget {
  final RouteModel route;
  final bool showDeleteButton;

  const RouteCard({
    Key? key,
    required this.route,
    this.showDeleteButton = false,
  }) : super(key: key);

  @override
  ConsumerState<RouteCard> createState() => _RouteCardState();
}

class _RouteCardState extends ConsumerState<RouteCard> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var myItems = widget.route.photoUrls
            ?.map((url) => Container(
                  width: double.infinity,
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                ))
            .toList() ??
        [];
    void toRouteScreen() async {
      final routeRepository = ref.read(routeRepositoryProvider);
      final completeRoute =
          await routeRepository.getRoutesById(id: widget.route.id);
      if (context.mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Myshi(
                route: completeRoute,
                routeId: completeRoute.id,
              ),
            ));
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      child: GestureDetector(
        onTap: toRouteScreen,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.route.photoUrls.isNotEmpty)
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CarouselSlider(
                          items: myItems,
                          options: CarouselOptions(
                              enableInfiniteScroll: false,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                              viewportFraction: 1.0,
                              autoPlay: false,
                              height: 300)),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: myItems.length > 1
                              ? AnimatedSmoothIndicator(
                                  activeIndex: currentIndex,
                                  count: myItems.length,
                                  effect: WormEffect(
                                      type: WormType.thinUnderground,
                                      spacing: 3,
                                      dotHeight: 6,
                                      dotWidth: 6,
                                      activeDotColor: Colors.white,
                                      dotColor: const Color.fromARGB(
                                          255, 206, 206, 206)),
                                )
                              : null)
                    ],
                  ),
                )
              else
                Container(
                  height: 260,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Icon(
                    Icons.image,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.route.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2D3436),
                                ),
                              ),
                              Row(
                                children: [
                                  Text('4.9'),
                                  Icon(Icons.star),
                                ],
                              )
                            ],
                          ),
                        ),
                        if (widget.showDeleteButton)
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Удалить маршрут?'),
                                  content: const Text(
                                    'Вы уверены, что хотите удалить этот маршрут? Это действие нельзя отменить.',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Отмена'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        try {
                                          await ref
                                              .read(routeRepositoryProvider)
                                              .deleteRoute(widget.route.id);
                                          if (context.mounted) {
                                            Navigator.pop(context);
                                            ref.invalidate(
                                                userRoutesListProvider);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Маршрут успешно удален'),
                                                backgroundColor: Colors.green,
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          if (context.mounted) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text('Ошибка: $e'),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: const Text(
                                        'Удалить',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                    if (widget.route.description != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        widget.route.description!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF636E72),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
