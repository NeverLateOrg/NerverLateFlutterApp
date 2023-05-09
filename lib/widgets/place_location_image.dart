import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:never_late_api_refont/models/placeLocation.dart';
import 'package:never_late_api_refont/services/api_services/place.locations.service.dart';
import 'package:never_late_api_refont/services/connection_service/connection.service.dart';
import 'package:never_late_api_refont/utils/cached_managers.dart';

class PlaceLocationImage extends StatelessWidget {
  const PlaceLocationImage(
      {super.key, this.height, this.width, required this.placeLocation});

  final double? height;
  final double? width;
  final PlaceLocation placeLocation;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          PlaceLocationsService().getPlaceLocationsImageUrl(placeLocation.id),
      cacheManager: locationsCacheManager,
      fit: BoxFit.cover,
      width: width,
      height: height,
      httpHeaders: Map<String, String>.from({
        'Authorization': 'Bearer ${ConnectionService().getAccessToken()}',
      }),
      errorWidget: (BuildContext context, String url, dynamic error) {
        // Display a placeholder image if the request fails
        return Image.asset(
          'assets/images/placeholder.png',
          fit: BoxFit.cover,
        );
      },
    );
  }
}
