import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:travelcompanion/features/home/presentation/widgets/route_card_widget.dart';
import 'package:travelcompanion/features/routes/presentation/providers/routes_list_provider.dart';

class UserRoutesScreen extends ConsumerWidget {
  const UserRoutesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routes = ref.watch(userRoutesListProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Stack(
        children: [
          const Positioned(
            top: -50,
            right: -50,
            child: _BackgroundCircle(
              width: 200,
              height: 200,
              color: Color(0xFF6C5CE7),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Color(0xFF2D3436)),
                        onPressed: () => context.pop(),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Мои путешествия',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3436),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: routes.when(
                    data: (routesList) {
                      if (routesList.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF6C5CE7).withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.route,
                                  size: 48,
                                  color: Color(0xFF6C5CE7),
                                ),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'У вас пока нет созданных маршрутов',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF2D3436),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Создайте свой первый маршрут',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF636E72),
                                ),
                              ),
                              const SizedBox(height: 32),
                              ElevatedButton(
                                onPressed: () {
                                  context.push('/create-route');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF6C5CE7),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 16),
                                ),
                                child: const Text(
                                  'Создать маршрут',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        itemCount: routesList.length,
                        itemBuilder: (context, index) {
                          final route = routesList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: RouteCard(
                              route: route,
                              showDeleteButton: true,
                            ),
                          );
                        },
                      );
                    },
                    error: (error, _) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Ошибка: $error',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    loading: () => const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF6C5CE7),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/create-route');
        },
        backgroundColor: const Color(0xFF6C5CE7),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _BackgroundCircle extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const _BackgroundCircle({
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.1),
      ),
    );
  }
}
