import 'package:flutter/material.dart';

class BarcodeOverlayWidget extends StatelessWidget {
  final Color overlayColour;

  const BarcodeOverlayWidget({
    super.key,
    required this.overlayColour,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    double width = mediaQuery.width;
    double height = mediaQuery.height;
    double scanArea = (width < 400 || height < 400) ? 200.0 : 330.0;

    return Stack(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            overlayColour,
            BlendMode.srcOut,
          ),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  backgroundBlendMode: BlendMode.dstOut,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  // height: scanArea,
                  // width: scanArea,
                  height: 140.0,
                  width: 600.0,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: CustomPaint(
            // foregroundPainter: BorderPaintWidget(),
            child: SizedBox(
              width: scanArea + 25,
              height: scanArea + 25,
            ),
          ),
        ),
      ],
    );
  }
}
