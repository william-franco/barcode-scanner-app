import 'package:barcode_scanner_app/src/common/state_management/state_management.dart';
import 'package:barcode_scanner_app/src/features/permission/models/permission_model.dart';
import 'package:barcode_scanner_app/src/features/permission/repositories/permission_repository.dart';
import 'package:flutter/foundation.dart';

typedef _ViewModel = StateManagement<PermissionModel>;

abstract interface class PermissionViewModel extends _ViewModel {
  Future<void> initCameraPermission();
}

class PermissionViewModelImpl extends _ViewModel
    implements PermissionViewModel {
  final PermissionRepository permissionRepository;

  PermissionViewModelImpl({required this.permissionRepository});

  @override
  PermissionModel build() => PermissionModel();

  @override
  Future<void> initCameraPermission() async {
    final isGranted = await permissionRepository.checkAndRequestPermission();
    final model = state.copyWith(isGranted: isGranted);
    _emit(model);
  }

  void _emit(PermissionModel newState) {
    emitState(newState);
    debugPrint('PermissionViewModel: ${state.isGranted}');
  }
}
