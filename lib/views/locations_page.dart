import 'package:flutter/material.dart';
import 'package:never_late_api_refont/models/customLocation.dart';
import 'package:never_late_api_refont/services/location.service.dart';
import 'package:never_late_api_refont/widgets/filterBar.dart/FilterBar.dart';

import '../models/placeLocation.dart';
import '../widgets/app_large_text.dart';
import '../widgets/locationBox.dart';

enum PopupMenuChoice { edit, delete }

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  _LocationsPageState createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  final List<PlaceLocation> placeLocations = LocationService().placeLocations;
  final List<CustomLocation> customLocations =
      LocationService().customLocations;
  int numberOfLocations = 0;
  List<dynamic> locations = [];

  final List<String> menuItems = ['Places', 'Customs'];

  @override
  void initState() {
    super.initState();
    numberOfLocations = placeLocations.length + customLocations.length;
    locations = [...placeLocations, ...customLocations];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: AppLargeText(
        text: 'Locations',
        color: Theme.of(context).colorScheme.tertiary,
      )),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                hintText: 'Search Tech Talk',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FilterBar(
              menuItems: const [
                'All',
                'Places',
                'Customs',
              ],
              onSelectionChanged: (p0) {
                print(p0);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 350,
                ),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: numberOfLocations,
                    itemBuilder: ((context, index) {
                      return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: LocationBox(
                            location: locations[index],
                          ));
                    })),
              ),
            ))
          ],
        ),
      ),
    );
    /*return SafeArea(
        child: Container(
      width: double.maxFinite,
      height: double.maxFinite,
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        chColor.fromRGBO(244, 67, 54, 1)          AppLargeText(
            text: 'Locations',
            color: Theme.of(context).colorScheme.tertiary,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: menuItems
                .map((e) =>
                    Column(children: [AppText(text: e), AppText(text: '@')]))
                .toList(),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.maxFinite,
            height: 300,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: placeLocations.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container();
                }),
          ),
        ],
      ),
    ));
  }*/
  }
}
