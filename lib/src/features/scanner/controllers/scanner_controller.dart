import 'package:barcode_scanner_app/src/features/scanner/models/scanner_model.dart';
import 'package:flutter/material.dart';

typedef _Controller = ChangeNotifier;

abstract interface class ScannerController extends _Controller {
  ScannerModel get scannerModel;

  void updateValue(String result);
}

class ScannerControllerImpl extends _Controller implements ScannerController {
  ScannerModel _scannerModel = ScannerModel();

  @override
  ScannerModel get scannerModel => _scannerModel;

  @override
  void updateValue(String result) {
    _scannerModel = ScannerModel(scannedValue: result);
    notifyListeners();
  }
}
