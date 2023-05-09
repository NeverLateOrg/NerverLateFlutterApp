import 'package:flutter/material.dart';
import 'package:never_late_api_refont/models/customLocation.dart';
import 'package:never_late_api_refont/models/placeLocation.dart';
import 'package:never_late_api_refont/widgets/app_large_text.dart';
import 'package:never_late_api_refont/widgets/app_text.dart';
import 'package:never_late_api_refont/widgets/place_location_image.dart';

class LocationBox extends StatelessWidget {
  const LocationBox({Key? key, required this.location}) : super(key: key);

  final dynamic location;

  bool isPlace() {
    return location is PlaceLocation;
  }

  PlaceLocation getPlace() {
    return location as PlaceLocation;
  }

  CustomLocation getCustomLocation() {
    return location as CustomLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 350),
      height: 115,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Row(children: [
              SizedBox(
                  width: 100,
                  child: Center(
                    child: SizedBox(
                        width: 100,
                        height: 75,
                        child: isPlace()
                            ? PlaceLocationImage(placeLocation: getPlace())
                            : Image.asset('assets/images/placeholder.png',
                                fit: BoxFit.cover)),
                  )),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLargeText(
                        text: location.name,
                        size: 17,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 11,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          Expanded(
                              child: AppText(
                            text: isPlace()
                                ? getPlace().address
                                : getCustomLocation().location,
                            size: 11,
                            color: Theme.of(context).colorScheme.secondary,
                          ))
                        ],
                      )
                    ]),
              )),
            ]),
          ),
        ],
      ),
    );
  }
}
