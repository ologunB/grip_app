import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/apis/auth_api.dart';
import 'core/apis/bible_api.dart';
import 'core/apis/post_api.dart';
import 'core/vms/auth_vm.dart';
import 'core/vms/base_vm.dart';
import 'core/vms/bible_vm.dart';
import 'core/vms/post_vm.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthApi());
  locator.registerFactory(() => AuthViewModel());
  locator.registerLazySingleton(() => PostApi());
  locator.registerFactory(() => PostViewModel());
  locator.registerLazySingleton(() => BibleApi());
  locator.registerFactory(() => BibleViewModel());
}

final List<SingleChildWidget> allProviders = <SingleChildWidget>[
  ChangeNotifierProvider<AuthViewModel>(create: (_) => AuthViewModel()),
  ChangeNotifierProvider<PostViewModel>(create: (_) => PostViewModel()),
  ChangeNotifierProvider<BibleViewModel>(create: (_) => BibleViewModel()),
];
