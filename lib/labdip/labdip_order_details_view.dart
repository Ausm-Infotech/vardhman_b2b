import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:searchfield/searchfield.dart';
import 'package:vardhman_b2b/catalog/catalog_controller.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/labdip/labdip_controller.dart';

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
                              label: Text('Comment'), size: ColumnSize.S),
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
                              // selected: reason != null && reason.isNotEmpty,
                              // onSelectChanged:
                              //     orderDetail.status != 'Dispatched'
                              //         ? null
                              //         : (_) {
                              //             // labdipController
                              //             //     .selectOrderDetailLine(orderDetail);
                              //           },
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
                                    DropdownButton<String>(
                                      value: reason,
                                      hint: Text('Select reason'),
                                      items: labdipController.rejectionReasons
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        labdipController
                                                .rxSelectedOrderDetailLinesReasonMap[
                                            orderDetail] = newValue ?? '';
                                      },
                                      isExpanded: true,
                                    ),
                                    // IconButton(
                                    //   icon: Icon(Icons.clear),
                                    //   onPressed: () {
                                    //     labdipController.rxSelectedOrderDetailLinesReasonMap.remove(orderDetail);
                                    //   },
                                    // ),
                                    // SearchField(
                                    //   searchInputDecoration:
                                    //       SearchInputDecoration(
                                    //     hintText: 'select reason',
                                    //     contentPadding: EdgeInsets.all(4),
                                    //     searchStyle: TextStyle(
                                    //       fontSize: 13,
                                    //       fontWeight: FontWeight.w500,
                                    //       color: reason != null &&
                                    //               reason.isNotEmpty
                                    //           ? VardhmanColors.red
                                    //           : VardhmanColors.darkGrey,
                                    //     ),
                                    //   ),
                                    //   onSuggestionTap: (p0) {
                                    //     labdipController
                                    //             .rxSelectedOrderDetailLinesReasonMap[
                                    //         orderDetail] = p0.searchKey;
                                    //   },

                                    // onSearchTextChanged: (p0) {
                                    //   labdipController
                                    //           .rxSelectedOrderDetailLinesReasonMap[
                                    //       orderDetail] = p0;

                                    //   return labdipController.rejectionReasons
                                    //       .where((element) => element
                                    //           .toLowerCase()
                                    //           .contains(p0.toLowerCase()))
                                    //       .map(
                                    //         (e) => SearchFieldListItem(
                                    //           e,
                                    //           child: Text(e),
                                    //         ),
                                    //       )
                                    //       .toList();
                                    // },
                                    // suggestions:
                                    //     labdipController.rejectionReasons
                                    //         .map(
                                    //           (e) => SearchFieldListItem(
                                    //             e,
                                    //             child: Text(e),
                                    //           ),
                                    //         )
                                    //         .toList(),
                                  ),
                                // Column(
                                //   children: <Widget>[

                                //     // if (reason == 'Other') ...[
                                //     //   const SizedBox(width: 8),
                                //     //   TextField(
                                //     //     decoration: const InputDecoration(
                                //     //       hintText: 'Enter reason',
                                //     //     ),
                                //     //     onChanged: (value) {
                                //     //       labdipController
                                //     //               .rxSelectedOrderDetailLinesReasonMap[
                                //     //           orderDetail] = value;
                                //     //     },
                                //     //   ),
                                //     // ],
                                //   ],
                                // ),
                                // ),
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
                        onPressed: () async {},
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
