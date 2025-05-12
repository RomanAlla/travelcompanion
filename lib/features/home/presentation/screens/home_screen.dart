import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:travelcompanion/features/home/presentation/widgets/categories_bar_widget.dart';
import 'package:travelcompanion/features/home/presentation/widgets/route_card_widget.dart';
import 'package:travelcompanion/features/home/presentation/widgets/seatch_bar_widget.dart';
import 'package:travelcompanion/features/routes/presentation/providers/routes_list_provider.dart';

class RoutesScreen extends ConsumerStatefulWidget {
  const RoutesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RoutesScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<RoutesScreen> {
  int selectedCategory = 0;
  int currentNavIndex = 0;
  String pickedCategory = 'Тропики';

  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.beach_access, 'label': 'Тропики'},
    {'icon': Icons.rocket, 'label': 'Острова'},
    {'icon': Icons.dangerous, 'label': 'Пещеры'},
    {'icon': Icons.local_fire_department, 'label': 'Популярные'},
    {'icon': Icons.nature, 'label': 'Особые'},
  ];

  @override
  Widget build(BuildContext context) {
    final routes = ref.watch(routesListProvider);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          SearchBarWidget(),
          SizedBox(
            height: 5,
          ),
          CategoriesBar(
            categories: categories,
            selected: selectedCategory,
            onSelect: (i) {
              setState(() {
                selectedCategory = i;
                pickedCategory = categories[i]['label'];
              });
            },
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
              child: routes.when(
            data: (routesList) {
              var filteredRoutes = routesList.where((route) {
                return route.routeType == pickedCategory;
              }).toList();

              if (filteredRoutes.isEmpty) {
                return const Center(
                  child: Text('Нет доступных маршрутов'),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: filteredRoutes.length,
                itemBuilder: (context, index) {
                  final route = filteredRoutes[index];
                  return RouteCard(
                    route: route,
                  );
                },
              );
            },
            error: (error, _) => Center(
              child: Text('Ошибка: $error'),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          )),
        ],
      ),
    );
  }
}
