import 'package:barcode_scanner_app/src/features/scanner/models/scanner_model.dart';
import 'package:flutter/foundation.dart';

typedef _ViewModel = ChangeNotifier;

abstract interface class ScannerViewModel extends _ViewModel {
  ScannerModel get scannerModel;

  void updateValue(String result);
}

class ScannerViewModelImpl extends _ViewModel implements ScannerViewModel {
  ScannerModel _scannerModel = ScannerModel();

  @override
  ScannerModel get scannerModel => _scannerModel;

  @override
  void updateValue(String result) {
    _scannerModel = _scannerModel.copyWith(scannedValue: result);
    notifyListeners();
  }
}
