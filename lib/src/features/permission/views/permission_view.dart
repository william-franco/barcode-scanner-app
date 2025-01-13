import 'package:barcode_scanner_app/src/common/dependency_injectors/dependency_injector.dart';
import 'package:barcode_scanner_app/src/features/permission/controllers/permission_controller.dart';
import 'package:barcode_scanner_app/src/features/permission/models/permission_model.dart';
import 'package:barcode_scanner_app/src/features/scanner/routes/scanner_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PermissionView extends StatefulWidget {
  const PermissionView({super.key});

  @override
  State<PermissionView> createState() => _PermissionViewState();
}

class _PermissionViewState extends State<PermissionView> {
  late final PermissionController permissionController;

  @override
  void initState() {
    super.initState();
    permissionController = locator<PermissionController>();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      _checkPermissionState();
    });
  }

  void _checkPermissionState() {
    if (permissionController.value.isGranted) {
      context.go(ScannerRoutes.resultScanner);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Permission Check'),
      ),
      body: Center(
        child: ValueListenableBuilder<PermissionModel>(
          valueListenable: permissionController,
          builder: (context, model, child) {
            if (model.isGranted) {
              return Text(
                'Permission granted. Navigating...',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              );
            } else {
              return Text(
                'Microphone permission is not granted. Please enable it in settings.',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              );
            }
          },
        ),
      ),
    );
  }
}
