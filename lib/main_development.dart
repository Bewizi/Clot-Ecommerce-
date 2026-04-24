import 'dart:io';

import 'package:clot/app/app.dart';
import 'package:clot/bootstrap.dart';
import 'package:clot/core/data/supabase_api_keys.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: SupaBaseApi.url,
    anonKey: SupaBaseApi.anonKey,
  );
  await bootstrap(
    () => DevicePreview(
      enabled:
          !kReleaseMode &&
          (Platform.isWindows || Platform.isMacOS || Platform.isLinux),
      builder: (context) => const App(),
    ),
  );
}
