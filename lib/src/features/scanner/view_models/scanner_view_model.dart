import 'package:barcode_scanner_app/src/common/state_management/state_management.dart';
import 'package:barcode_scanner_app/src/features/scanner/models/scanner_model.dart';
import 'package:flutter/foundation.dart';

typedef _ViewModel = StateManagement<ScannerModel>;

abstract interface class ScannerViewModel extends _ViewModel {
  ScannerViewModel(super.initialState);

  void updateValue(String result);
}

class ScannerViewModelImpl extends _ViewModel implements ScannerViewModel {
  ScannerViewModelImpl() : super(ScannerModel());

  @override
  void updateValue(String result) {
    final model = state.copyWith(scannedValue: result);
    _emit(model);
  }

  void _emit(ScannerModel newState) {
    emitState(newState);
    debugPrint('ScannerModel: ${state.scannedValue}');
  }
}
