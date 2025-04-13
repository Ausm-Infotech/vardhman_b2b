import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/labdip/labdip_controller.dart';
import 'package:vardhman_b2b/orders/order_review_controller.dart';

class FeedbackDialog extends StatelessWidget {
  FeedbackDialog({super.key});

  final LabdipController labdipController = Get.find<LabdipController>();

  final OrderReviewController orderReviewController =
      Get.find<OrderReviewController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Dialog(
        insetPadding: EdgeInsets.all(80),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          child: Column(
            children: <Widget>[
              HeaderView(
                elevation: 4,
                leading: SecondaryButton(
                  wait: false,
                  iconData: Icons.arrow_back_ios_new,
                  text: 'Back',
                  onPressed: () async {
                    Get.back();
                  },
                ),
                title: Text(
                  'Feedback for ${labdipController.rxSelectedOrderHeaderLine.value!.orderNumber}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                trailing: DefaultTextStyle(
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  child: PrimaryButton(
                    text: 'Submit Feedback',
                    onPressed: labdipController.rxOrderDetailFeedbackMap.values
                            .any((feedback) => feedback.reason.trim().isEmpty)
                        ? null
                        : labdipController.submitFeedback,
                  ),
                ),
              ),
              Expanded(
                child: DataTable2(
                  columnSpacing: 16,
                  showBottomBorder: true,
                  border: TableBorder.symmetric(
                    inside:
                        BorderSide(color: VardhmanColors.darkGrey, width: 0.2),
                    outside:
                        BorderSide(color: VardhmanColors.darkGrey, width: 0.2),
                  ),
                  headingCheckboxTheme: CheckboxThemeData(
                    fillColor: WidgetStatePropertyAll(Colors.white),
                    checkColor: WidgetStatePropertyAll(VardhmanColors.red),
                  ),
                  datarowCheckboxTheme: CheckboxThemeData(
                    fillColor: WidgetStatePropertyAll(Colors.white),
                    checkColor: WidgetStatePropertyAll(VardhmanColors.red),
                  ),
                  dataTextStyle: TextStyle(
                    color: VardhmanColors.darkGrey,
                    fontSize: 13,
                  ),
                  checkboxHorizontalMargin: 0,
                  headingRowHeight: 40,
                  dataRowHeight: 60,
                  headingRowColor:
                      WidgetStatePropertyAll(VardhmanColors.darkGrey),
                  headingTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  columns: const [
                    DataColumn2(
                      label: Text('#'),
                      size: ColumnSize.S,
                      fixedWidth: 30,
                      numeric: true,
                    ),
                    DataColumn2(
                      label: Text('Article'),
                      size: ColumnSize.S,
                      fixedWidth: 60,
                    ),
                    DataColumn2(
                      label: Text('Shade'),
                      size: ColumnSize.S,
                      fixedWidth: 60,
                    ),
                    DataColumn2(
                      label: Text('Final Shade'),
                      size: ColumnSize.S,
                      fixedWidth: 120,
                    ),
                    DataColumn2(
                        headingRowAlignment: MainAxisAlignment.center,
                        label: Text('Feedback Reason'),
                        size: ColumnSize.L),
                    DataColumn2(
                      label: Text('Need Revised Sample'),
                      size: ColumnSize.S,
                      fixedWidth: 150,
                    ),
                    DataColumn2(
                      fixedWidth: 180,
                      label: Text("Don't Need Revised Sample"),
                      size: ColumnSize.S,
                    ),
                  ],
                  empty: Center(child: const Text('No Order Lines')),
                  rows: labdipController.rxOrderDetailFeedbackMap.entries.map(
                    (mapEntry) {
                      final orderDetailLine = mapEntry.key;

                      final index = labdipController.rxOrderDetailLines
                          .indexOf(orderDetailLine);

                      final itemParts =
                          orderDetailLine.item.split(RegExp('\\s+'));

                      final String article = itemParts[0];
                      final String uom = itemParts[1];
                      final String shade = itemParts[2];

                      final labdipTableRows = labdipController
                          .getLabdipTableRows(orderDetailLine.workOrderNumber);

                      final feedback = mapEntry.value;

                      final noneBorder = OutlineInputBorder(
                        borderSide: BorderSide.none,
                      );

                      return DataRow(
                        color: index.isEven
                            ? WidgetStatePropertyAll(Colors.white)
                            : WidgetStatePropertyAll(
                                VardhmanColors.dividerGrey.withAlpha(128)),
                        cells: [
                          DataCell(Text((index + 1).toString())),
                          DataCell(Text(article)),
                          DataCell(Text(shade)),
                          DataCell(
                            Text(labdipTableRows.map((labdipTableRow) {
                              return '${labdipTableRow.permanentShade} ${labdipTableRow.reference}';
                            }).join(', ')),
                          ),
                          DataCell(
                            Row(
                              children: <Widget>[
                                IconButton(
                                  color: VardhmanColors.darkGrey,
                                  disabledColor: VardhmanColors.green,
                                  onPressed: feedback.isPositive
                                      ? null
                                      : () {
                                          labdipController
                                                      .rxOrderDetailFeedbackMap[
                                                  orderDetailLine] =
                                              feedback.copyWith(
                                            isPositive: true,
                                            shouldRematch: false,
                                            reason: 'Accepted',
                                          );

                                          toastification.show(
                                            autoCloseDuration:
                                                Duration(seconds: 3),
                                            primaryColor: VardhmanColors.green,
                                            title: Text('Accepted'),
                                          );
                                        },
                                  icon: Icon(
                                    (feedback.isPositive)
                                        ? Icons.thumb_up
                                        : Icons.thumb_up_outlined,
                                  ),
                                ),
                                IconButton(
                                  color: VardhmanColors.darkGrey,
                                  disabledColor: VardhmanColors.red,
                                  onPressed: !feedback.isPositive
                                      ? null
                                      : () {
                                          labdipController
                                                      .rxOrderDetailFeedbackMap[
                                                  orderDetailLine] =
                                              feedback.copyWith(
                                            isPositive: false,
                                            reason: '',
                                          );

                                          toastification.show(
                                            autoCloseDuration:
                                                Duration(seconds: 3),
                                            primaryColor: VardhmanColors.red,
                                            title: Text('Rejected'),
                                          );
                                        },
                                  icon: Icon(
                                    (!feedback.isPositive)
                                        ? Icons.thumb_down
                                        : Icons.thumb_down_outlined,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: VardhmanColors.darkGrey,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: DropdownSearch<String>(
                                            enabled: !feedback.isPositive,
                                            decoratorProps:
                                                DropDownDecoratorProps(
                                              baseStyle: TextStyle(
                                                color: VardhmanColors.darkGrey,
                                                fontSize: 13,
                                              ),
                                              decoration: InputDecoration(
                                                hintText:
                                                    'select rejection reason',
                                                hintStyle: TextStyle(
                                                  color:
                                                      VardhmanColors.darkGrey,
                                                  fontSize: 13,
                                                ),
                                                contentPadding:
                                                    EdgeInsets.only(left: 8),
                                                border: noneBorder,
                                                enabledBorder: noneBorder,
                                                focusedBorder: noneBorder,
                                                disabledBorder: noneBorder,
                                              ),
                                            ),
                                            popupProps: PopupProps.menu(
                                              searchFieldProps: TextFieldProps(
                                                maxLength: 15,
                                                autocorrect: false,
                                                style: TextStyle(
                                                  color:
                                                      VardhmanColors.darkGrey,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              showSearchBox: true,
                                              fit: FlexFit.loose,
                                              searchDelay:
                                                  Duration(milliseconds: 0),
                                              itemBuilder: (context, item,
                                                      isDisabled, isSelected) =>
                                                  ListTile(
                                                title: Text(
                                                  item,
                                                  style: TextStyle(
                                                    color:
                                                        VardhmanColors.darkGrey,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            items: (searchText, cs) async {
                                              final trimmedSearchText =
                                                  searchText.trim();

                                              return [
                                                if (trimmedSearchText
                                                        .isNotEmpty &&
                                                    !labdipController
                                                        .rejectionReasons
                                                        .contains(
                                                            trimmedSearchText))
                                                  trimmedSearchText,
                                                ...labdipController
                                                    .rejectionReasons
                                              ];
                                            },
                                            autoValidateMode:
                                                AutovalidateMode.disabled,
                                            onChanged: (newValue) {
                                              if (newValue != null) {
                                                labdipController
                                                            .rxOrderDetailFeedbackMap[
                                                        orderDetailLine] =
                                                    feedback.copyWith(
                                                        reason: newValue);
                                              }
                                            },
                                            selectedItem:
                                                feedback.reason.isEmpty
                                                    ? null
                                                    : feedback.reason,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DataCell(
                            Checkbox(
                              tristate: false,
                              fillColor: WidgetStatePropertyAll(
                                Colors.white,
                              ),
                              checkColor: VardhmanColors.red,
                              side: BorderSide(
                                color: VardhmanColors.darkGrey,
                                width: 0.5,
                              ),
                              value: feedback.shouldRematch,
                              onChanged: feedback.isPositive
                                  ? null
                                  : (bool? value) {
                                      if (value == true) {
                                        labdipController
                                                    .rxOrderDetailFeedbackMap[
                                                orderDetailLine] =
                                            feedback.copyWith(
                                          shouldRematch: true,
                                        );
                                      }
                                    },
                            ),
                          ),
                          DataCell(
                            Checkbox(
                              tristate: false,
                              fillColor: WidgetStatePropertyAll(
                                Colors.white,
                              ),
                              checkColor: VardhmanColors.red,
                              side: BorderSide(
                                color: VardhmanColors.darkGrey,
                                width: 0.5,
                              ),
                              value: !feedback.shouldRematch,
                              onChanged: feedback.isPositive
                                  ? null
                                  : (bool? value) {
                                      if (value == true) {
                                        labdipController
                                                    .rxOrderDetailFeedbackMap[
                                                orderDetailLine] =
                                            feedback.copyWith(
                                          shouldRematch: false,
                                        );
                                      }
                                    },
                            ),
                          ),
                        ],
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
