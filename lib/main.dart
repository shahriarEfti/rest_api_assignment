import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'All/App/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String storageLocation = (await getApplicationDocumentsDirectory()).path;
  await FastCachedImageConfig.init(
    subDir: storageLocation,
    clearCacheAfter: const Duration(days: 2),
  );
  runApp(const MyApp());
}
