import 'package:barcode_scanner_app/src/features/scanner/view_models/scanner_view_model.dart';
import 'package:barcode_scanner_app/src/features/scanner/routes/scanner_routes.dart';
import 'package:barcode_scanner_app/src/features/settings/routes/setting_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResultScannerView extends StatefulWidget {
  final ScannerViewModel scannerViewModel;

  const ResultScannerView({super.key, required this.scannerViewModel});

  @override
  State<ResultScannerView> createState() => _ResultScannerViewState();
}

class _ResultScannerViewState extends State<ResultScannerView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
              listenable: widget.scannerViewModel,
              builder: (context, child) {
                debugPrint(
                  'Barcode Result: ${widget.scannerViewModel.scannerModel.scannedValue}',
                );
                return SelectableText(
                  'Barcode Result: ${widget.scannerViewModel.scannerModel.scannedValue}',
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

    widget.scannerViewModel.updateValue(result ?? '');
  }
}
