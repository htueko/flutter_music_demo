import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'app_module.config.dart';

/// flutter pub run build_runner watch --delete-conflicting-outputs
/// instance to GitIt
GetIt locator = GetIt.instance;

@injectableInit
void setupLocator() {
  $initGetIt(locator);
}
