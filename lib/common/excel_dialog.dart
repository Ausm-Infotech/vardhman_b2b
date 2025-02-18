import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toastification/toastification.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/orders/order_entry_controller.dart';

class ExcelDialog extends StatelessWidget {
  ExcelDialog({
    super.key,
  });

  final OrderEntryController orderEntryController =
      Get.find<OrderEntryController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Import Data from Excel File',
              style: TextStyle(
                fontSize: 16,
                color: VardhmanColors.darkGrey,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            PrimaryButton(
              iconData: Icons.upload,
              text: 'Choose File',
              onPressed: () async {
                await orderEntryController.importExcel();

                Get.back();
              },
            ),
            const Divider(
              height: 64,
              thickness: 0.5,
              color: VardhmanColors.dividerGrey,
            ),
            SecondaryButton(
              iconData: Icons.file_download,
              text: 'Download Sample',
              onPressed: () async {
                PermissionStatus status =
                    await Permission.manageExternalStorage.status;

                if (status.isDenied) {
                  status = await Permission.manageExternalStorage.request();
                }

                final ByteData data =
                    await rootBundle.load('assets/Sample.xlsx');

                // final Directory? directory = await getDownloadsDirectory();

                const destinationPath =
                    '/storage/emulated/0/Download/Sample.xlsx';

                final File file = File(destinationPath);
                await file.writeAsBytes(data.buffer.asUint8List());

                toastification.show(
                  autoCloseDuration: Duration(seconds: 5),
                  primaryColor: VardhmanColors.green,
                  title: Text('Sample.xlsx saved in Downloads'),
                );

                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}
