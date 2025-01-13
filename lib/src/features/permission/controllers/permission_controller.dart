import 'package:barcode_scanner_app/src/features/permission/models/permission_model.dart';
import 'package:barcode_scanner_app/src/features/permission/repositories/permission_repository.dart';
import 'package:flutter/material.dart';

typedef _Controller = ValueNotifier<PermissionModel>;

abstract interface class PermissionController extends _Controller {
  PermissionController() : super(PermissionModel());

  Future<void> initCameraPermission();
}

class PermissionControllerImpl extends _Controller
    implements PermissionController {
  final PermissionRepository permissionRepository;

  PermissionControllerImpl({
    required this.permissionRepository,
  }) : super(PermissionModel());

  @override
  Future<void> initCameraPermission() async {
    final isGranted = await permissionRepository.checkAndRequestPermission();
    value = PermissionModel(isGranted: isGranted);
  }
}
