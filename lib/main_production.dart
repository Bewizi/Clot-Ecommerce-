import 'package:clot/app/app.dart';
import 'package:clot/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
