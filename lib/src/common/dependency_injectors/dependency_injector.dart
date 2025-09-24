import 'package:barcode_scanner_app/src/common/services/storage_service.dart';
import 'package:barcode_scanner_app/src/features/permission/view_models/permission_view_model.dart';
import 'package:barcode_scanner_app/src/features/permission/repositories/permission_repository.dart';
import 'package:barcode_scanner_app/src/features/scanner/view_models/scanner_view_model.dart';
import 'package:barcode_scanner_app/src/features/settings/view_models/setting_view_model.dart';
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
  locator.registerLazySingleton<PermissionViewModel>(
    () => PermissionViewModelImpl(
      permissionRepository: locator<PermissionRepository>(),
    ),
  );
}

void _startFeatureScanner() {
  locator.registerLazySingleton<ScannerViewModel>(() => ScannerViewModelImpl());
}

void _startFeatureSetting() {
  locator.registerCachedFactory<SettingRepository>(
    () => SettingRepositoryImpl(storageService: locator<StorageService>()),
  );
  locator.registerLazySingleton<SettingViewModel>(
    () => SettingViewModelImpl(settingRepository: locator<SettingRepository>()),
  );
}

Future<void> initDependencies() async {
  await locator<StorageService>().initStorage();
  await Future.wait([
    locator<SettingViewModel>().getTheme(),
    locator<PermissionViewModel>().initCameraPermission(),
  ]);
}

void resetDependencies() {
  locator.reset();
}

void resetFeatureSetting() {
  locator.unregister<SettingRepository>();
  locator.unregister<SettingViewModel>();
  _startFeatureSetting();
}
