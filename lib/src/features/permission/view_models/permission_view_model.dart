import 'package:barcode_scanner_app/src/features/permission/models/permission_model.dart';
import 'package:barcode_scanner_app/src/features/permission/repositories/permission_repository.dart';
import 'package:flutter/foundation.dart';

typedef _ViewModel = ChangeNotifier;

abstract interface class PermissionViewModel extends _ViewModel {
  PermissionModel get permissionModel;

  Future<void> initCameraPermission();
}

class PermissionViewModelImpl extends _ViewModel
    implements PermissionViewModel {
  final PermissionRepository permissionRepository;

  PermissionViewModelImpl({required this.permissionRepository});

  PermissionModel _permissionModel = PermissionModel();

  @override
  PermissionModel get permissionModel => _permissionModel;

  @override
  Future<void> initCameraPermission() async {
    final isGranted = await permissionRepository.checkAndRequestPermission();
    _permissionModel = _permissionModel.copyWith(isGranted: isGranted);
    notifyListeners();
  }
}
