import 'package:barcode_scanner_app/src/features/scanner/models/scanner_model.dart';
import 'package:flutter/material.dart';

typedef _Controller = ValueNotifier<ScannerModel>;

abstract interface class ScannerController extends _Controller {
  ScannerController() : super(ScannerModel());

  void updateValue(String result);
}

class ScannerControllerImpl extends _Controller implements ScannerController {
  ScannerControllerImpl() : super(ScannerModel());

  @override
  void updateValue(String result) {
    value = ScannerModel(scannedValue: result);
  }
}
