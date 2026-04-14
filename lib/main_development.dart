import 'dart:io';

import 'package:clot/app/app.dart';
import 'package:clot/bootstrap.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';

Future<void> main() async {
  await bootstrap(
    () => DevicePreview(
      enabled:
          !kReleaseMode &&
          (Platform.isWindows || Platform.isMacOS || Platform.isLinux),
      builder: (context) => const App(),
    ),
  );
}
