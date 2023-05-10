import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:never_late_api_refont/models/customLocation.dart';
import 'package:never_late_api_refont/services/data_services/place_locations_service.dart';
import 'package:never_late_api_refont/widgets/filterBar.dart/FilterBar.dart';

import '../models/placeLocation.dart';
import '../services/data_services/custom_locations_service.dart';
import '../widgets/app_large_text.dart';
import '../widgets/locationBox.dart';

enum PopupMenuChoice { edit, delete }

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  _LocationsPageState createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  late List<PlaceLocation> placeLocations;
  late List<CustomLocation> customLocations;
  List<dynamic> locations = [];
  List<dynamic> filteredByFuzeLocations = [];
  List<dynamic> finalFilteredLocations = [];
  Fuzzy? fuze;

  final List<String> menuFilterItems = ['All', 'Places', 'Customs'];
  int menuFilterSelectedIndex = 0;

  List<dynamic> filterByType() {
    if (menuFilterItems[menuFilterSelectedIndex] == menuFilterItems[0]) {
      return filteredByFuzeLocations;
    } else if (menuFilterItems[menuFilterSelectedIndex] == menuFilterItems[1]) {
      return filteredByFuzeLocations.whereType<PlaceLocation>().toList();
    } else {
      return filteredByFuzeLocations.whereType<CustomLocation>().toList();
    }
  }

  setupFuzzy() {
    fuze = Fuzzy(locations,
        options: FuzzyOptions(keys: [
          WeightedKey(name: 'name', getter: (obj) => obj.name, weight: 2),
          WeightedKey(
              name: 'location',
              getter: (obj) =>
                  obj is PlaceLocation ? obj.address : obj.location,
              weight: 1)
        ]));
  }

  updateLocations() async {
    final placeLocationsService = PlaceLocationsService();
    final customLocationsService = CustomLocationsService();
    await placeLocationsService.updateRemoteAll();
    await customLocationsService.updateRemoteAll();
    setState(() {
      initValues();
    });
  }

  initValues() {
    placeLocations = PlaceLocationsService().getAll();
    customLocations = CustomLocationsService().getAll();
    locations = [...placeLocations, ...customLocations];
    filteredByFuzeLocations = locations;
    finalFilteredLocations = filterByType();
    setupFuzzy();
  }

  @override
  void initState() {
    super.initState();
    updateLocations();
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
            TextField(
              onChanged: (value) {
                final res = fuze?.search(value);
                if (res == null) return;
                setState(() {
                  filteredByFuzeLocations = res.map((e) => e.item).toList();
                  finalFilteredLocations = filterByType();
                });
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                hintText: 'Search Tech Talk',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FilterBar(
              menuItems: menuFilterItems,
              onSelectionChanged: (values) {
                setState(() {
                  menuFilterSelectedIndex = values.indexOf(true);
                  finalFilteredLocations = filterByType();
                });
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
                    itemCount: finalFilteredLocations.length,
                    itemBuilder: ((context, index) {
                      return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: LocationBox(
                            location: finalFilteredLocations[index],
                          ));
                    })),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
