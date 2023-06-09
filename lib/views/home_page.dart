import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:never_late_api_refont/views/calendar_page/calendar_page.dart';
import 'package:never_late_api_refont/views/locations_page/locations_page.dart';
import 'package:never_late_api_refont/views/setting_page/setting_page.dart';

import '../models/event.dart';
import '../services/data_services/event_service.dart';

class PageItem {
  final Widget page;
  final IconData icon;
  final String name;

  PageItem({required this.page, required this.icon, required this.name});
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<PageItem> _pages = [
    PageItem(
      page: const CalendarPage(),
      icon: Icons.calendar_today_outlined,
      name: 'Calendar',
    ),
    PageItem(
      page: const LocationsPage(),
      icon: Icons.location_searching,
      name: 'Locations',
    ),
    PageItem(
      page: const SettingPage(),
      icon: Icons.settings_outlined,
      name: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider<Event>(
        controller: EventService().controller,
        child: Scaffold(
            body: _pages[_currentIndex].page,
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  selectedItemColor: Theme.of(context).colorScheme.secondary,
                  unselectedItemColor: Theme.of(context).colorScheme.primary,
                  iconSize: 25,
                  onTap: (index) async {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  items: _pages
                      .map(
                        (page) => BottomNavigationBarItem(
                          icon: Icon(page.icon),
                          label: page.name,
                        ),
                      )
                      .toList(),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                ),
              ),
            )));
  }
}
