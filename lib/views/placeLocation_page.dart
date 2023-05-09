import 'package:flutter/material.dart';
import 'package:never_late_api_refont/widgets/app_large_text.dart';
import 'package:never_late_api_refont/widgets/app_text.dart';

import '../models/placeLocation.dart';

enum PopupMenuChoice { edit, delete }

class PlaceLocationPage extends StatelessWidget {
  const PlaceLocationPage({super.key, required this.placeLocation});

  final PlaceLocation placeLocation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/eiffelTower.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  color: Theme.of(context).colorScheme.primary,
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                PopupMenuButton<PopupMenuChoice>(
                    color: Theme.of(context).colorScheme.primary,
                    itemBuilder: (context) => [
                          const PopupMenuItem(
                              value: PopupMenuChoice.edit, child: Text('Edit')),
                          const PopupMenuItem(
                              value: PopupMenuChoice.delete,
                              child: Text('Delete')),
                        ],
                    onSelected: (value) {
                      switch (value) {
                        case PopupMenuChoice.edit:
                          print('Edit');
                          break;
                        case PopupMenuChoice.delete:
                          print('Delete');
                          break;
                      }
                    }),
              ],
            ),
          ),
          Positioned(
            top: 270,
            bottom: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                top: 30,
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  AppLargeText(
                    text: placeLocation.name,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.map_outlined,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      AppText(
                          text: placeLocation.address,
                          color: Theme.of(context).colorScheme.tertiary),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
