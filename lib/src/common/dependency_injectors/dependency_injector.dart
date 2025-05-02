import 'package:barcode_scanner_app/src/common/services/storage_service.dart';
import 'package:barcode_scanner_app/src/features/permission/controllers/permission_controller.dart';
import 'package:barcode_scanner_app/src/features/permission/repositories/permission_repository.dart';
import 'package:barcode_scanner_app/src/features/scanner/controllers/scanner_controller.dart';
import 'package:barcode_scanner_app/src/features/settings/controllers/setting_controller.dart';
import 'package:barcode_scanner_app/src/features/settings/repositories/setting_repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void dependencyInjector() {
  _startStorageService();
  _startFeaturePermission();
  _startFeatureScanner();
  _startFeatureSetting();
}

void _startStorageService() {
  locator.registerLazySingleton<StorageService>(() => StorageServiceImpl());
}

void _startFeaturePermission() {
  locator.registerCachedFactory<PermissionRepository>(
    () => PermissionRepositoryImpl(),
  );
  locator.registerLazySingleton<PermissionController>(
    () => PermissionControllerImpl(
      permissionRepository: locator<PermissionRepository>(),
    ),
  );
}

void _startFeatureScanner() {
  locator.registerLazySingleton<ScannerController>(
    () => ScannerControllerImpl(),
  );
}

void _startFeatureSetting() {
  locator.registerCachedFactory<SettingRepository>(
    () => SettingRepositoryImpl(storageService: locator<StorageService>()),
  );
  locator.registerLazySingleton<SettingController>(
    () =>
        SettingControllerImpl(settingRepository: locator<SettingRepository>()),
  );
}

Future<void> initDependencies() async {
  await locator<StorageService>().initStorage();
  await Future.wait([
    locator<SettingController>().loadTheme(),
    locator<PermissionController>().initCameraPermission(),
  ]);
}

void resetDependencies() {
  locator.reset();
}

void resetFeatureSetting() {
  locator.unregister<SettingRepository>();
  locator.unregister<SettingController>();
  _startFeatureSetting();
}
