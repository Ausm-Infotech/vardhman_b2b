import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/new_order_date_field.dart';
import 'package:vardhman_b2b/common/order_detail_column_label.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/home/home_controller.dart';

class OrderSummaryView extends StatelessWidget {
  const OrderSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    // final labdipEntryController = Get.find<LabdipEntryController>();
    final HomeController homeController = Get.find();

    // final OrderReviewController orderReviewController =
    //     Get.find<OrderReviewController>();

    return Obx(
      () => Column(
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
              'Order Summary',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            // trailing: DefaultTextStyle(
            //   style: const TextStyle(
            //     fontWeight: FontWeight.bold,
            //   ),
            //   child: PrimaryButton(
            //     text: 'Submit Order',
            //     onPressed: labdipEntryController.rxLabdipOrderLines.isEmpty
            //         ? null
            //         : labdipEntryController.submitOrder,
            //   ),
            // ),
          ),
          Container(
            color: VardhmanColors.dividerGrey.withAlpha(128),
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: [
                            SizedBox(
                              width: 300,
                              child: NewOrderDateField(
                                labelText: 'From',
                                rxDate: homeController.rxFromDate,
                                firstDate:
                                    homeController.rxFromDate.value?.subtract(
                                  Duration(days: 60),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: DataTable2(
              minWidth: 600,
              columnSpacing: 0,
              showBottomBorder: true,
              border: TableBorder.symmetric(
                inside: BorderSide(color: VardhmanColors.darkGrey, width: 0.2),
                outside: BorderSide(color: VardhmanColors.darkGrey, width: 0.2),
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
              horizontalMargin: 16,
              headingRowHeight: 60,
              dataRowHeight: 60,
              headingRowColor: WidgetStatePropertyAll(VardhmanColors.darkGrey),
              headingTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              columns: const [
                DataColumn2(
                    label: OrderDetailColumnLabel(labelText: 'Customer Code'),
                    // fixedWidth: 50,
                    size: ColumnSize.M,
                    headingRowAlignment: MainAxisAlignment.end),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Customer Name'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Portal Order'),
                  size: ColumnSize.M,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'JDE Order'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Order Type'),
                  size: ColumnSize.M,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Order Date'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Remark'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
              ],
              empty: Center(child: const Text('No Order Lines')), rows: [],
              // rows: <DraftTableData>[]
              // labdipEntryController.labdipOrderLinesDescending.map(
              //   (labdipOrderLine) {
              //     final index = labdipEntryController.rxLabdipOrderLines
              //         .indexOf(labdipOrderLine);

              //     final uomDesc = orderReviewController
              //         .getUomDescription(labdipOrderLine.uom);

              //     return DataRow(
              //       color: index.isEven
              //           ? WidgetStatePropertyAll(Colors.white)
              //           : WidgetStatePropertyAll(
              //               VardhmanColors.dividerGrey.withAlpha(128)),
              //       selected: labdipEntryController.rxSelectedLabdipOrderLines
              //           .contains(labdipOrderLine),
              //       onSelectChanged: (_) {
              //         labdipEntryController
              //             .selectLabdipOrderLine(labdipOrderLine);
              //       },
              //       cells: [
              //         DataCell(
              //           OrderDetailCell(
              //             cellText: (index + 1).toString(),
              //           ),
              //         ),
              //         DataCell(
              //           OrderDetailCell(
              //             cellText: labdipOrderLine.merchandiser,
              //           ),
              //         ),
              //         DataCell(
              //           OrderDetailCell(
              //             cellText: labdipOrderLine.buyer,
              //           ),
              //         ),
              //         DataCell(
              //           OrderDetailCell(
              //             cellText: labdipOrderLine.article,
              //           ),
              //         ),
              //         DataCell(
              //           OrderDetailCell(
              //             cellText: "${labdipOrderLine.uom} - $uomDesc",
              //           ),
              //         ),
              //         DataCell(
              //           OrderDetailCell(
              //             cellText: labdipOrderLine.ticket,
              //           ),
              //         ),
              //         DataCell(
              //           OrderDetailCell(
              //             cellText: labdipOrderLine.brand,
              //           ),
              //         ),
              //         DataCell(
              //           OrderDetailCell(
              //             cellText: labdipOrderLine.tex,
              //           ),
              //         ),
              //         DataCell(
              //           OrderDetailCell(
              //             cellText: labdipOrderLine.substrate,
              //           ),
              //         ),
              //         DataCell(
              //           OrderDetailCell(
              //             cellText: labdipOrderLine.shade,
              //           ),
              //         ),
              //         DataCell(
              //           OrderDetailCell(
              //             cellText: labdipOrderLine.colorName,
              //           ),
              //         ),
              //         DataCell(
              //           OrderDetailCell(
              //             cellText: labdipOrderLine.lab,
              //           ),
              //         ),
              //         DataCell(
              //           OrderDetailCell(
              //             cellText: labdipOrderLine.qtxFileName,
              //           ),
              //         ),
              //         DataCell(
              //           OrderDetailCell(
              //             cellText: labdipOrderLine.remark,
              //           ),
              //         ),
              //       ],
              //     );
              //   },
              // ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
