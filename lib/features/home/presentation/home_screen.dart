import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:travelcompanion/core/router/router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _onTabTapped(int index, TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
         MainRoutesRoute(),
         FavouriteRoute(),
         TravelsRoute(),
         ProfileRoute()
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              onTap: (index) => _onTabTapped(index, tabsRouter),
              currentIndex: tabsRouter.activeIndex,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: 'Поиск'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border), label: 'Избранное'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.route), label: 'Поездки'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Профиль'),
              ],
            ));
      },
    );
  }
}
