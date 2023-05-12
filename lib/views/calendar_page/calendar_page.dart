import 'package:flutter/material.dart';
import 'package:never_late_api_refont/services/data_services/event_service.dart';
import 'package:never_late_api_refont/views/calendar_page/widgets/calendar_day_view.dart';
import 'package:never_late_api_refont/views/calendar_page/widgets/calendar_month_view.dart';
import 'package:never_late_api_refont/views/calendar_page/widgets/calendar_week_view.dart';

import '../../widgets/app_large_text.dart';
import '../../widgets/expandable_button.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  int _selectedIndex = 0;
  final List<bool> _selectedViews = <bool>[true, false, false];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    List<Widget> views = [
      const CalendarDayView(militaryHourFormat: true),
      const CalendarWeekView(
        militaryHourFormat: true,
      ),
      const CalendarMonthView(),
    ];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.tertiary,
          title: AppLargeText(
            text: 'Calendar',
            color: theme.colorScheme.primary,
          ),
          actions: [
            RawMaterialButton(
              onPressed: () {
                // Refresh
                EventService().syncRemoteAll();
              },
              child: Icon(
                color: theme.colorScheme.primary,
                Icons.refresh,
              ),
            ),
          ],
        ),
        floatingActionButton: Wrap(
          direction: Axis.horizontal,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: ExpandableButton.toggle(
                spaceBetweenChildren: 5,
                buttonSize: const Size(36, 36),
                icon: Icons.sort,
                expandedIcon: Icons.keyboard_arrow_right,
                children: const [
                  Icons.calendar_view_day,
                  Icons.calendar_view_week,
                  Icons.calendar_view_month,
                ],
                onPressed: (int index) {
                  setState(() {
                    _selectedIndex = index;
                    for (int i = 0; i < _selectedViews.length; i++) {
                      _selectedViews[i] = i == index;
                    }
                  });
                },
                isSelected: _selectedViews,
                selectedBackgroundColor: theme.colorScheme.tertiary,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => {
                  // Add event
                  print('Add event'),
                },
              ),
            ),
          ],
        ),
        body: views[_selectedIndex]);
  }
}
