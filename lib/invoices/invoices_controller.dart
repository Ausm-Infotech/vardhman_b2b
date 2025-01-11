import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/invoice_info.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class InvoicesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _userController = Get.find<UserController>(tag: 'userController');

  final _rxFilteredinvoiceInfos = RxList<InvoiceInfo>();

  final _allInvoices = <InvoiceInfo>[];

  final rxFirstDate = oldestDateTime.obs;

  final rxFromDate = oldestDateTime.obs;

  final rxToDate = DateTime.now().obs;

  final rxInvoiceNumberInput = ''.obs;

  final rxSelectedInvoiceInfos = <InvoiceInfo>[].obs;

  final invoiceNumberTextEditingController = TextEditingController();

  late final tabController = TabController(
    length: 2,
    vsync: this,
  );

  DateTime? previousFromDate;

  InvoicesController() {
    init();
  }

  Future<void> init() async {
    _userController.rxCustomerDetail.listenAndPump(
      (_) async {
        await clearFilters();

        rxFirstDate.value = _allInvoices.first.date;

        rxFromDate.value = _allInvoices.first.date;
      },
    );

    rxInvoiceNumberInput.listenAndPump(
      (_) {
        filterInvoices();
      },
    );
  }

  void filterInvoices() {
    _rxFilteredinvoiceInfos.clear();

    _rxFilteredinvoiceInfos.addAll(
      _allInvoices.where(
        (invoiceInfo) =>
            invoiceInfo.invoiceNumber
                .toString()
                .contains(rxInvoiceNumberInput.value) &&
            invoiceInfo.date.isAfter(
              rxFromDate.value.subtract(
                const Duration(days: 1),
              ),
            ) &&
            invoiceInfo.date.isBefore(
              rxToDate.value.add(
                const Duration(days: 1),
              ),
            ),
      ),
    );
  }

  Future<void> refreshInvoices() async {
    _allInvoices.clear();

    final customerSoldToNumber =
        _userController.rxCustomerDetail.value.soldToNumber;

    final invoiceInfos = await Api.fetchInvoices(
      customerNumber: customerSoldToNumber,
      company: _userController.rxCustomerDetail.value.companyCode,
    );

    if (invoiceInfos.isNotEmpty) {
      final invoicesInProcessing =
          await Api.fetchInvoicesInProcessing(customerSoldToNumber);

      final processedInvoiceInfos = invoiceInfos.map(
        (invoiceInfo) {
          InvoiceInfo invoiceInfoWithStatusAndDiscount =
              getInvoiceInfoWithStatusAndDiscount(invoiceInfo);

          if (invoicesInProcessing.contains(invoiceInfo.invoiceNumber)) {
            return invoiceInfoWithStatusAndDiscount.copyWith(
              status: InvoiceStatus.processing,
            );
          } else {
            return invoiceInfoWithStatusAndDiscount;
          }
        },
      );

      _allInvoices.addAll(
        processedInvoiceInfos,
      );

      _allInvoices.sort(
        (a, b) => a.discountDueDate.compareTo(b.discountDueDate),
      );

      filterInvoices();
    }
  }

  List<InvoiceInfo> get openInvoices => _rxFilteredinvoiceInfos
      .where(
        (invoiceInfo) => invoiceInfo.status != InvoiceStatus.paid,
      )
      .toList();

  List<InvoiceInfo> get creditNotes => _rxFilteredinvoiceInfos
      .where(
        (invoiceInfo) => invoiceInfo.status == InvoiceStatus.creditNote,
      )
      .toList();

  List<InvoiceInfo> get overdueInvoices => _rxFilteredinvoiceInfos
      .where(
        (invoiceInfo) => invoiceInfo.status == InvoiceStatus.overdue,
      )
      .toList();

  List<InvoiceInfo> get notDueInvoices => _rxFilteredinvoiceInfos
      .where(
        (invoiceInfo) => invoiceInfo.status == InvoiceStatus.notDue,
      )
      .toList();

  List<InvoiceInfo> get discountedInvoices => _rxFilteredinvoiceInfos
      .where(
        (invoiceInfo) => invoiceInfo.status == InvoiceStatus.discounted,
      )
      .toList();

  List<InvoiceInfo> get processingInvoices => _rxFilteredinvoiceInfos
      .where(
        (invoiceInfo) => invoiceInfo.status == InvoiceStatus.processing,
      )
      .toList();

  List<InvoiceInfo> get newToOldPaidInvoices => _rxFilteredinvoiceInfos
      .where(
        (invoiceInfo) => invoiceInfo.status == InvoiceStatus.paid,
      )
      .toList()
    ..sort(
      (a, b) => b.date.compareTo(a.date),
    );

  void addInvoiceToSelected(InvoiceInfo invoiceInfo) {
    if (!rxSelectedInvoiceInfos.contains(invoiceInfo)) {
      rxSelectedInvoiceInfos.add(invoiceInfo);

      rxSelectedInvoiceInfos.sort(
        (a, b) => a.discountDueDate.compareTo(b.discountDueDate),
      );
    }
  }

  void removeInvoiceFromSelected(InvoiceInfo invoiceInfo) {
    rxSelectedInvoiceInfos.remove(invoiceInfo);
  }

  double get totalOverdueAmount => _allInvoices
      .fold(
        0.0,
        (previousValue, invoiceInfo) =>
            previousValue +
            (invoiceInfo.status == InvoiceStatus.overdue
                ? invoiceInfo.openAmount
                : 0),
      )
      .toPrecision(2);

  double get totalOutstandingAmount => _allInvoices
      .fold(
        0.0,
        (previousValue, invoiceInfo) =>
            previousValue +
            (invoiceInfo.status != InvoiceStatus.paid
                ? invoiceInfo.openAmount
                : 0),
      )
      .toPrecision(2);

  double get totalOpenAmount => openInvoices
      .fold(
        0.0,
        (previousValue, invoiceInfo) => previousValue + invoiceInfo.openAmount,
      )
      .toPrecision(2);

  double get selectedTotalAmount => rxSelectedInvoiceInfos
      .fold(
        0.0,
        (previousValue, element) => previousValue + element.openAmount,
      )
      .toPrecision(2);

  double get selectedDiscountedAmount => rxSelectedInvoiceInfos.fold(
        0.0,
        (previousValue, invoiceInfo) {
          if (invoiceInfo.discountAmount.isGreaterThan(0)) {
            return previousValue + invoiceInfo.discountAmount;
          } else {
            return previousValue + invoiceInfo.openAmount;
          }
        },
      ).toPrecision(2);

  bool get hasFilters =>
      areDatesEqual(
        rxFromDate.value,
        rxFirstDate.value,
      ) &&
      areDatesEqual(rxToDate.value, DateTime.now()) &&
      rxInvoiceNumberInput.value.isEmpty;

  Future<void> clearFilters() async {
    rxFromDate.value = rxFirstDate.value;

    rxToDate.value = DateTime.now();

    rxInvoiceNumberInput.value = '';

    invoiceNumberTextEditingController.clear();

    await refreshInvoices();
  }
}
