import 'package:barcode_scanner_app/src/features/scanner/widgets/barcode_overlay_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CameraScannerView extends StatefulWidget {
  const CameraScannerView({super.key});

  @override
  State<CameraScannerView> createState() => _CameraScannerViewState();
}

class _CameraScannerViewState extends State<CameraScannerView> {
  late final MobileScannerController cameraController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          RotatedBox(
            quarterTurns: 3,
            child: MobileScanner(
              controller: cameraController,
              onDetect: (BarcodeCapture capture) {
                // final List<Barcode> barcodes = capture.barcodes;
                // final Uint8List? image = capture.image;
                // for (final barcode in barcodes) {
                //   debugPrint('Barcode found! ${barcode.rawValue}');
                // }

                final String? scannedValue = capture.barcodes.first.rawValue;
                debugPrint('Barcode scanned: $scannedValue');
                _readBarCode(scannedValue);
              },
            ),
          ),
          BarcodeOverlayWidget(overlayColour: Colors.black.withOpacity(0.5)),
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    context.pop();
                  },
                ),
                const Text(
                  'Scanner',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox.shrink(),
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: ElevatedButton(
          //     child: const Text('Enter barcode number'),
          //     onPressed: () {},
          //   ),
          // ),
        ],
      ),
    );
  }

  void _readBarCode(String? scannedValue) {
    if (scannedValue?.length != 44) {
      return;
    }
    context.pop(scannedValue);
  }
}
