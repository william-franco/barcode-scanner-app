import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

// void dependencyInjector() {
//   _startStorageService();
//   _startFeaturePermission();
//   _startFeatureSetting();
// }

// void _startStorageService() {
//   locator.registerLazySingleton<StorageService>(
//     () => StorageServiceImpl(),
//   );
// }

// void _startFeaturePermission() {
//   locator.registerCachedFactory<PermissionRepository>(
//     () => PermissionRepositoryImpl(),
//   );
//   locator.registerLazySingleton<PermissionController>(
//     () => PermissionControllerImpl(
//       permissionRepository: locator<PermissionRepository>(),
//     ),
//   );
// }

// void _startFeatureSetting() {
//   locator.registerCachedFactory<SettingRepository>(
//     () => SettingRepositoryImpl(
//       storageService: locator<StorageService>(),
//     ),
//   );
//   locator.registerLazySingleton<SettingController>(
//     () => SettingControllerImpl(
//       settingRepository: locator<SettingRepository>(),
//     ),
//   );
// }

// Future<void> initDependencies() async {
//   await Future.wait([
//     locator<SettingController>().loadTheme(),
//     locator<PermissionController>().initMicrophonePermission(),
//   ]);
// }

// void resetDependencies() {
//   locator.reset();
// }

// void resetFeatureSetting() {
//   locator.unregister<SettingRepository>();
//   locator.unregister<SettingController>();
//   _startFeatureSetting();
// }