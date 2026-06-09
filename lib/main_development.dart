import 'package:clot/app/app.dart';
import 'package:clot/bootstrap.dart';
import 'package:clot/core/data/supabase_api_keys.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: SupaBaseApi.url,
    anonKey: SupaBaseApi.anonKey,
  );
  await bootstrap(
    () => const App(),
  );
}
