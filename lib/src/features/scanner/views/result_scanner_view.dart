import 'package:barcode_scanner_app/src/features/scanner/controllers/scanner_controller.dart';
import 'package:barcode_scanner_app/src/features/scanner/routes/scanner_routes.dart';
import 'package:barcode_scanner_app/src/features/settings/routes/setting_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResultScannerView extends StatefulWidget {
  final ScannerController scannerController;

  const ResultScannerView({super.key, required this.scannerController});

  @override
  State<ResultScannerView> createState() => _ResultScannerViewState();
}

class _ResultScannerViewState extends State<ResultScannerView> {
  late final ScannerController scannerController;

  @override
  void initState() {
    super.initState();
    scannerController = widget.scannerController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Scanner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              context.push(SettingRoutes.setting);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListenableBuilder(
              listenable: scannerController,
              builder: (context, child) {
                debugPrint(
                  'Barcode Result: ${scannerController.scannerModel.scannedValue}',
                );
                return SelectableText(
                  'Barcode Result: ${scannerController.scannerModel.scannedValue}',
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              label: const Text('Open Camera'),
              icon: const Icon(Icons.camera_alt_outlined),
              onPressed: () async {
                await _openCameraScannerView(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openCameraScannerView(BuildContext context) async {
    final String? result = await context.push(ScannerRoutes.cameraScanner);

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!context.mounted) return;

    scannerController.updateValue(result ?? '');
  }
}
