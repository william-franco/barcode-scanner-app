class ScannerModel {
  final String scannedValue;

  ScannerModel({this.scannedValue = ''});

  ScannerModel copyWith({String? scannedValue}) =>
      ScannerModel(scannedValue: scannedValue ?? this.scannedValue);
}
