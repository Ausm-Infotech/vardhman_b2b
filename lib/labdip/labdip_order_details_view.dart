import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/catalog/catalog_controller.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/labdip/labdip_controller.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class LabdipOrderDetailsView extends StatelessWidget {
  const LabdipOrderDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LabdipController labdipController = Get.find<LabdipController>();

    final CatalogController catalogController = Get.find<CatalogController>();

    return Obx(
      () {
        final hasDispatchedLine = labdipController.rxOrderDetailLines.any(
          (element) => element.status == 'Dispatched',
        );

        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              HeaderView(
                elevation: 4,
                title: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: VardhmanColors.darkGrey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (labdipController.rxSelectedOrderHeaderLine.value !=
                            null) ...[
                          Text(
                            'Order Details for ${labdipController.rxSelectedOrderHeaderLine.value!.orderReference}',
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'JDE order no. ${labdipController.rxSelectedOrderHeaderLine.value!.orderNumber}',
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Dated ${DateFormat('dd/MM/yyyy').format(labdipController.rxSelectedOrderHeaderLine.value!.orderDate)}',
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: labdipController.rxSelectedOrderHeaderLine.value == null
                    ? const Center(
                        child: Text('No Order Selected'),
                      )
                    : DataTable2(
                        columnSpacing: 8,
                        showBottomBorder: true,
                        border: TableBorder.symmetric(
                          inside: BorderSide(
                              color: VardhmanColors.darkGrey, width: 0.2),
                          outside: BorderSide(
                              color: VardhmanColors.darkGrey, width: 0.2),
                        ),
                        headingCheckboxTheme: CheckboxThemeData(
                          fillColor: WidgetStatePropertyAll(Colors.white),
                          checkColor:
                              WidgetStatePropertyAll(VardhmanColors.red),
                        ),
                        datarowCheckboxTheme: CheckboxThemeData(
                          fillColor: WidgetStatePropertyAll(Colors.white),
                          checkColor:
                              WidgetStatePropertyAll(VardhmanColors.red),
                        ),
                        dataTextStyle: TextStyle(
                          color: VardhmanColors.darkGrey,
                          fontSize: 13,
                        ),
                        checkboxHorizontalMargin: 0,
                        horizontalMargin: 0,
                        showCheckboxColumn: false,
                        headingRowHeight: 40,
                        dataRowHeight: 40,
                        headingRowColor:
                            WidgetStatePropertyAll(VardhmanColors.darkGrey),
                        headingTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        columns: [
                          DataColumn2(
                            label: Text('#'),
                            size: ColumnSize.S,
                            fixedWidth: 30,
                            numeric: true,
                          ),
                          DataColumn2(
                            label: Text('Article'),
                            fixedWidth: 60,
                          ),
                          DataColumn2(label: Text('Brand'), size: ColumnSize.M),
                          DataColumn2(
                            label: Text('Ticket'),
                            fixedWidth: 50,
                            numeric: true,
                          ),
                          DataColumn2(
                            label: Text('Tex'),
                            numeric: true,
                            fixedWidth: 40,
                          ),
                          DataColumn2(
                            label: Text('Shade'),
                            fixedWidth: 60,
                          ),
                          DataColumn2(
                            label: Text('Final Shade'),
                            fixedWidth: 80,
                          ),
                          DataColumn2(
                              label: Text('Remark'), size: ColumnSize.S),
                          DataColumn2(
                              label: Text('Status'), size: ColumnSize.M),
                          if (hasDispatchedLine)
                            DataColumn2(
                                label: Text('Feedback'), size: ColumnSize.L),
                        ],
                        rows: labdipController.rxOrderDetailLines.map(
                          (orderDetail) {
                            final itemParts =
                                orderDetail.item.split(RegExp('\\s+'));

                            final String article = itemParts[0];
                            final String uom = itemParts[1];
                            final String shade = itemParts[2];

                            final catalogItem = catalogController
                                .rxFilteredItems
                                .firstWhereOrNull(
                              (itemCatalogInfo) =>
                                  itemCatalogInfo.article == article &&
                                  itemCatalogInfo.uom == uom,
                            );

                            final labdipTableRow = labdipController
                                .getLabdipTableRow(orderDetail.workOrderNumber);

                            final index = labdipController.rxOrderDetailLines
                                .indexOf(orderDetail);

                            final reason = labdipController
                                    .rxSelectedOrderDetailLinesReasonMap[
                                orderDetail];

                            return DataRow(
                              color: WidgetStatePropertyAll(
                                index.isEven
                                    ? Colors.white
                                    : VardhmanColors.dividerGrey,
                              ),
                              cells: [
                                DataCell(
                                  Text(orderDetail.lineNumber.toString()),
                                ),
                                DataCell(
                                  Text(article),
                                ),
                                DataCell(
                                  Text(catalogItem?.brandDesc ?? ''),
                                ),
                                DataCell(
                                  Text(catalogItem?.ticket ?? ''),
                                ),
                                DataCell(
                                  Text(catalogItem?.tex ?? ''),
                                ),
                                DataCell(
                                  Text(shade),
                                ),
                                DataCell(
                                  Text(labdipTableRow?.permanentShade == null
                                      ? ''
                                      : '${labdipTableRow?.permanentShade} ${labdipTableRow?.reference}'),
                                ),
                                DataCell(
                                  Text(orderDetail.userComment),
                                ),
                                DataCell(
                                  Text(orderDetail.status),
                                ),
                                if (hasDispatchedLine)
                                  DataCell(
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Theme(
                                            data: ThemeData(
                                              canvasColor: Colors.white,
                                              hoverColor: VardhmanColors.red
                                                  .withAlpha(32),
                                              focusColor: Colors.white,
                                            ),
                                            child: DropdownButton<String>(
                                              value: reason,
                                              hint: Text(
                                                'Select reason',
                                              ),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: VardhmanColors.darkGrey,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              iconSize: reason != null ? 0 : 18,
                                              items: labdipController
                                                  .rejectionReasons
                                                  .map(
                                                (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: value == reason
                                                            ? VardhmanColors.red
                                                            : VardhmanColors
                                                                .darkGrey,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                              onChanged: (String? newValue) {
                                                labdipController
                                                        .rxSelectedOrderDetailLinesReasonMap[
                                                    orderDetail] = newValue ?? '';
                                              },
                                            ),
                                          ),
                                          if (reason != null)
                                            SecondaryButton(
                                              wait: false,
                                              text: '',
                                              iconData: Icons.clear,
                                              onPressed: () async {
                                                labdipController
                                                    .rxSelectedOrderDetailLinesReasonMap
                                                    .remove(orderDetail);
                                              },
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ).toList(),
                      ),
              ),
              if (labdipController
                  .rxSelectedOrderDetailLinesReasonMap.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: VardhmanColors.darkGrey,
                        width: 0.2,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '${labdipController.rxSelectedOrderDetailLinesReasonMap.length} line${labdipController.rxSelectedOrderDetailLinesReasonMap.length > 1 ? 's' : ''} selected'),
                      PrimaryButton(
                        text: 'Rematch',
                        onPressed: () async {
                          final UserController _userController =
                              Get.find<UserController>(tag: 'userController');

                          final nextOrderNumber = await Api.fetchOrderNumber();

                          final b2bOrderNumber = 'B2BL-$nextOrderNumber';

                          if (nextOrderNumber != null) {
                            final isSubmitted = await Api.submitRematchOrder(
                              merchandiserName: '',
                              b2bOrderNumber: b2bOrderNumber,
                              branchPlant: _userController.branchPlant,
                              soldTo: _userController
                                  .rxCustomerDetail.value.soldToNumber,
                              shipTo: (_userController.rxDeliveryAddress.value
                                              ?.deliveryAddressNumber ==
                                          0
                                      ? _userController
                                          .rxCustomerDetail.value.soldToNumber
                                      : _userController.rxDeliveryAddress.value
                                          ?.deliveryAddressNumber)
                                  .toString(),
                              company: _userController
                                  .rxCustomerDetail.value.companyCode,
                              orderTakenBy:
                                  _userController.rxUserDetail.value.role,
                              orderDetailLines: labdipController
                                  .rxSelectedOrderDetailLinesReasonMap.keys
                                  .toList(),
                              selectedOrderDetailLinesReasonMap:
                                  labdipController
                                      .rxSelectedOrderDetailLinesReasonMap,
                            );

                            if (isSubmitted) {
                              labdipController
                                  .rxSelectedOrderDetailLinesReasonMap
                                  .clear();

                              toastification.show(
                                autoCloseDuration: Duration(seconds: 5),
                                primaryColor: VardhmanColors.green,
                                title: Text(
                                  'Order $b2bOrderNumber placed successfully!',
                                ),
                              );

                              if (_userController
                                  .rxCustomerDetail.value.canSendSMS) {
                                Api.sendOrderEntrySMS(
                                  orderNumber: b2bOrderNumber,
                                  mobileNumber: _userController
                                      .rxCustomerDetail.value.mobileNumber,
                                );
                              }

                              if (_userController
                                  .rxCustomerDetail.value.canSendWhatsApp) {
                                Api.sendOrderEntryWhatsApp(
                                  orderNumber: b2bOrderNumber,
                                  mobileNumber: _userController
                                      .rxCustomerDetail.value.mobileNumber,
                                );
                              }
                            } else {
                              toastification.show(
                                autoCloseDuration: Duration(seconds: 5),
                                primaryColor: VardhmanColors.red,
                                title: Text(
                                  'Some error placing the order!',
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
