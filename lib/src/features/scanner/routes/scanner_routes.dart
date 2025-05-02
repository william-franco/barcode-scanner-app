import 'package:barcode_scanner_app/src/features/scanner/views/camera_scanner_view.dart';
import 'package:barcode_scanner_app/src/features/scanner/views/result_scanner_view.dart';
import 'package:go_router/go_router.dart';

class ScannerRoutes {
  static String get resultScanner => '/result-scanner';
  static String get cameraScanner => '/camera-scanner';

  final routes = [
    GoRoute(
      path: resultScanner,
      builder: (context, state) {
        return const ResultScannerView();
      },
    ),
    GoRoute(
      path: cameraScanner,
      builder: (context, state) {
        return const CameraScannerView();
      },
    ),
  ];
}
