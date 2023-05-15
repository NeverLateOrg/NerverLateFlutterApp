import 'dart:async';

import 'package:flutter/material.dart';
import 'package:never_late_api_refont/models/google_location.dart';
import 'package:never_late_api_refont/services/api_services/google_api_service.dart';

class LocationsSearchPage extends StatefulWidget {
  const LocationsSearchPage({Key? key}) : super(key: key);

  @override
  _LocationsSearchPageState createState() => _LocationsSearchPageState();
}

class _LocationsSearchPageState extends State<LocationsSearchPage> {
  Timer? _searchTimer;
  GoogleLocationsResponse _locations = GoogleLocationsResponse(places: []);

  void _onSearchTextChanged(value) async {
    if (_searchTimer != null) {
      setState(() {
        _searchTimer?.cancel();
      });
    }

    _searchTimer = Timer(const Duration(milliseconds: 800), () async {
      _locations = await GoogleApiService().getPlaceByText(value);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    print(_locations.isEmpty());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.tertiary,
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Address or Place',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            border: InputBorder.none,
          ),
          onChanged: _onSearchTextChanged,
        ),
      ),
      body: !_locations.isEmpty()
          ? _buildLocationsList(context)
          : const Center(
              child: Text('No locations found.'),
            ),
    );
  }

  Widget _buildLocationsList(BuildContext context) {
    return ListView.builder(
      itemCount: _locations.places.length,
      itemBuilder: (context, index) {
        final location = _locations.places[index];
        return InkWell(
          onTap: () => Navigator.pop(context, location),
          child: ListTile(
            title: Text(location.name),
            subtitle: Text(location.address),
          ),
        );
      },
    );
  }
}
