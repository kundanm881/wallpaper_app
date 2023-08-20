import 'package:flutter_cache_manager/flutter_cache_manager.dart';

CacheManager cacheManager(String key) => CacheManager(
  Config(
    key,
    stalePeriod: const Duration(days: 1),
  ),
);