import 'package:barcode_scanner_app/src/features/scanner/views/camera_scanner_view.dart';
import 'package:barcode_scanner_app/src/features/scanner/views/result_scanner_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScannerRoutes {
  static const String resultScanner = '/result-scanner';
  static const String cameraScanner = '/camera-scanner';

  static final List<GoRoute> routes = [
    GoRoute(
      path: resultScanner,
      pageBuilder: (context, state) => const MaterialPage(
        child: ResultScannerView(),
      ),
    ),
    GoRoute(
      path: cameraScanner,
      pageBuilder: (context, state) => const MaterialPage(
        child: CameraScannerView(),
      ),
    ),
  ];
}
