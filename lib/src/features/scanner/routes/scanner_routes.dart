import 'package:barcode_scanner_app/src/common/dependency_injectors/dependency_injector.dart';
import 'package:barcode_scanner_app/src/features/scanner/controllers/scanner_controller.dart';
import 'package:barcode_scanner_app/src/features/scanner/views/camera_scanner_view.dart';
import 'package:barcode_scanner_app/src/features/scanner/views/result_scanner_view.dart';
import 'package:go_router/go_router.dart';

class ScannerRoutes {
  static String get cameraScanner => '/camera-scanner';
  static String get resultScanner => '/result-scanner';

  List<GoRoute> get routes => _routes;

  final List<GoRoute> _routes = [
    GoRoute(
      path: cameraScanner,
      builder: (context, state) {
        return const CameraScannerView();
      },
    ),
    GoRoute(
      path: resultScanner,
      builder: (context, state) {
        return ResultScannerView(
          scannerController: locator<ScannerController>(),
        );
      },
    ),
  ];
}
