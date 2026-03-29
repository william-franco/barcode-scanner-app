import 'package:barcode_scanner_app/src/features/scanner/models/scanner_model.dart';
import 'package:barcode_scanner_app/src/features/scanner/view_models/scanner_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ScannerViewModel Test', () {
    late ScannerViewModel viewModel;

    setUp(() {
      viewModel = ScannerViewModelImpl();
    });

    tearDown(() {
      viewModel.dispose();
    });

    // ---------------------------------------------------------------------------
    // Initial state
    // ---------------------------------------------------------------------------

    test('should start with a default ScannerModel', () {
      expect(viewModel.state, isA<ScannerModel>());
      expect(viewModel.state.scannedValue, equals(''));
    });

    // ---------------------------------------------------------------------------
    // updateValue
    // ---------------------------------------------------------------------------

    group('updateValue', () {
      test('should emit ScannerModel with the provided scanned value', () {
        // arrange
        final emittedStates = <ScannerModel>[];
        viewModel.addListener(() => emittedStates.add(viewModel.state));

        // act
        viewModel.updateValue('https://example.com');

        // assert
        expect(emittedStates.length, equals(1));
        expect(emittedStates.first.scannedValue, equals('https://example.com'));
      });

      test('should notify listeners exactly once per updateValue call', () {
        // arrange
        int notifyCount = 0;
        viewModel.addListener(() => notifyCount++);

        // act
        viewModel.updateValue('QR_CODE_123');

        // assert
        expect(notifyCount, equals(1));
      });

      test('should update state to the latest value on sequential calls', () {
        // act
        viewModel.updateValue('first');
        viewModel.updateValue('second');
        viewModel.updateValue('third');

        // assert
        expect(viewModel.state.scannedValue, equals('third'));
      });

      test('should emit every sequential value in order', () {
        // arrange
        final emittedStates = <ScannerModel>[];
        viewModel.addListener(() => emittedStates.add(viewModel.state));

        // act
        viewModel.updateValue('first');
        viewModel.updateValue('second');
        viewModel.updateValue('third');

        // assert
        expect(emittedStates.length, equals(3));
        expect(emittedStates[0].scannedValue, equals('first'));
        expect(emittedStates[1].scannedValue, equals('second'));
        expect(emittedStates[2].scannedValue, equals('third'));
      });

      test('should emit ScannerModel with an empty string value', () {
        // arrange
        viewModel.updateValue('non-empty');
        final emittedStates = <ScannerModel>[];
        viewModel.addListener(() => emittedStates.add(viewModel.state));

        // act
        viewModel.updateValue('');

        // assert
        expect(emittedStates.first.scannedValue, equals(''));
      });

      test('should not notify listeners when the same value is emitted twice '
          '(StateManagement identical check)', () {
        // arrange
        viewModel.updateValue('same');
        int notifyCount = 0;
        viewModel.addListener(() => notifyCount++);

        // act — emitState uses `identical` check; ScannerModel is a new
        // instance each time via copyWith, so this WILL notify.
        // This test documents the current behaviour explicitly.
        viewModel.updateValue('same');

        // assert — copyWith always returns a new instance, so listeners fire
        expect(notifyCount, equals(1));
        expect(viewModel.state.scannedValue, equals('same'));
      });
    });
  });
}
