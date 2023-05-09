import 'package:flutter_cache_manager/flutter_cache_manager.dart';

final locationsCacheManager = CacheManager(
  Config(
    'locationsCache',
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 100,
  ),
);
