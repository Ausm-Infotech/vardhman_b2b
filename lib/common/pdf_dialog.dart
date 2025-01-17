import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:vardhman_b2b/constants.dart';

class PdfDialog extends StatefulWidget {
  final String? pdfAssetPath;
  final Uint8List? bytes;

  const PdfDialog.asset({
    super.key,
    required this.pdfAssetPath,
  }) : bytes = null;

  const PdfDialog.data({
    super.key,
    required this.bytes,
  }) : pdfAssetPath = null;

  @override
  State<PdfDialog> createState() => _PdfDialogState();
}

class _PdfDialogState extends State<PdfDialog> {
  final pdfViewerController = PdfViewerController();
  bool zoomedIn = false;

  @override
  Widget build(BuildContext context) {
    final params = PdfViewerParams(
      viewerOverlayBuilder: (context, size, handleLinkTap) => [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onDoubleTap: () async {
            if (zoomedIn) {
              await pdfViewerController.zoomDown();
              zoomedIn = false;
            } else {
              await pdfViewerController.zoomUp();
              zoomedIn = true;
            }
          },
          onTapUp: (details) {
            handleLinkTap(details.localPosition);
          },
          child: IgnorePointer(
            child: SizedBox(
              width: size.width,
              height: size.height,
            ),
          ),
        ),
      ],
    );

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.antiAlias,
              child: widget.pdfAssetPath != null
                  ? PdfViewer.asset(
                      widget.pdfAssetPath!,
                      params: params,
                      controller: pdfViewerController,
                    )
                  : PdfViewer.data(
                      widget.bytes!,
                      sourceName: 'PDF',
                      params: params,
                      controller: pdfViewerController,
                    ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton.outlined(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  VardhmanColors.darkGrey,
                ),
              ),
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
