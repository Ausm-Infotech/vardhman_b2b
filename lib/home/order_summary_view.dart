import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/new_order_date_field.dart';
import 'package:vardhman_b2b/common/order_detail_cell.dart';
import 'package:vardhman_b2b/common/order_detail_column_label.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/home/order_summary_controller.dart';

class OrderSummaryView extends StatelessWidget {
  const OrderSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderSummaryController orderSummaryController = Get.find();

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
                                labelText: 'Date',
                                rxDate:
                                    orderSummaryController.rxOrderSummaryDate,
                                firstDate: orderSummaryController
                                    .rxOrderSummaryDate.value
                                    ?.subtract(
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
              showCheckboxColumn: false,
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
                  label: OrderDetailColumnLabel(labelText: '#'),
                  fixedWidth: 50,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                    label: OrderDetailColumnLabel(labelText: 'Customer Code'),
                    fixedWidth: 120,
                    size: ColumnSize.M,
                    headingRowAlignment: MainAxisAlignment.end),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Customer Name'),
                  fixedWidth: 400,
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Portal Order'),
                  fixedWidth: 120,
                  size: ColumnSize.M,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'JDE Order'),
                  fixedWidth: 120,
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Order Type'),
                  fixedWidth: 240,
                  size: ColumnSize.M,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Order Date'),
                  fixedWidth: 120,
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Remark'),
                  fixedWidth: 120,
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
              ],
              empty: Center(child: const Text('No Order Lines')),
              rows: orderSummaryController.rxOrderSummaryLines.map(
                (orderSummaryLine) {
                  final index = orderSummaryController.rxOrderSummaryLines
                      .indexOf(orderSummaryLine);

                  return DataRow(
                    color: index.isEven
                        ? WidgetStatePropertyAll(Colors.white)
                        : WidgetStatePropertyAll(
                            VardhmanColors.dividerGrey.withAlpha(128)),
                    cells: [
                      DataCell(
                        OrderDetailCell(
                          cellText: (index + 1).toString(),
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: orderSummaryLine.customerCode,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: orderSummaryLine.customerName,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: orderSummaryLine.portalOrder,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: orderSummaryLine.jdeOrder,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: orderSummaryLine.orderType,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: DateFormat('d MMM yyyy').format(
                            DateTime.parse(orderSummaryLine.orderDate),
                          ),
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: orderSummaryLine.orderRemark,
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
    );
  }
}
