import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/user_address.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'package:vardhman_b2b/login/login_controller.dart';

class UserController extends GetxController {
  final _sharedPrefs = Get.find<SharedPreferences>();

  final loginController = Get.find<LoginController>();

  final Rx<UserDetail> rxCustomerDetail, rxUserDetail;

  final availableQuantity = 0.obs;

  final rxDeliveryAddress = Rxn<UserAddress>();

  final _database = Get.find<Database>();

  final rxRelatedCustomers = RxList<RelatedCustomer>();

  final rxDeliveryAddresses = RxList<UserAddress>();

  late StreamSubscription<UserDetail> _rxCustomerDetailSubscription;

  late StreamSubscription<List<RelatedCustomer>>
      _rxRelatedCustomersSubscription;

  UserController({
    required UserDetail userDetail,
    required UserDetail customerDetail,
    List<RelatedCustomer> relatedCustomers = const [],
  })  : rxCustomerDetail = customerDetail.obs,
        rxUserDetail = userDetail.obs {
    rxRelatedCustomers.addAll(relatedCustomers);

    _listenRxCustomerDetail();
  }

  void _listenRxCustomerDetail() {
    _rxCustomerDetailSubscription = rxCustomerDetail.listenAndPump(
      (customerDetail) async {
        _watchRelatedCustomers();

        final billingAddress =
            await Api.fetchBillingAddress(customerDetail.soldToNumber);

        final deliveryAddresses = await Api.fetchDeliveryAddresses(
          company: customerDetail.companyCode,
          soldToNumber: customerDetail.soldToNumber,
        );

        rxDeliveryAddresses.clear();

        if (billingAddress != null) rxDeliveryAddresses.add(billingAddress);

        rxDeliveryAddresses.addAll(deliveryAddresses);

        if (rxDeliveryAddresses.isNotEmpty) {
          String selectedAddressKey =
              sharedPrefsSelectedAddressKey(customerDetail);

          final selectedAddressJson =
              _sharedPrefs.getString(selectedAddressKey);

          if (selectedAddressJson != null) {
            rxDeliveryAddress.value = rxDeliveryAddresses.firstWhere(
              (element) => jsonEncode(element.toJson()) == selectedAddressJson,
              orElse: () => rxDeliveryAddresses.first,
            );
          } else {
            rxDeliveryAddress.value = rxDeliveryAddresses.first;
          }

          _sharedPrefs.setString(
            selectedAddressKey,
            jsonEncode(rxDeliveryAddress.value!.toJson()),
          );
        }
      },
    );
  }

  Future<void> refreshDeliveryAddresses() async {
    final billingAddress =
        await Api.fetchBillingAddress(rxCustomerDetail.value.soldToNumber);

    final deliveryAddresses = await Api.fetchDeliveryAddresses(
      company: rxCustomerDetail.value.companyCode,
      soldToNumber: rxCustomerDetail.value.soldToNumber,
    );

    rxDeliveryAddresses.clear();

    if (billingAddress != null) rxDeliveryAddresses.add(billingAddress);

    rxDeliveryAddresses.addAll(deliveryAddresses);

    if (rxDeliveryAddresses.isNotEmpty) {
      String selectedAddressKey =
          sharedPrefsSelectedAddressKey(rxCustomerDetail.value);

      final selectedAddressJson = _sharedPrefs.getString(selectedAddressKey);

      if (selectedAddressJson != null) {
        rxDeliveryAddress.value = rxDeliveryAddresses.firstWhere(
          (element) => jsonEncode(element.toJson()) == selectedAddressJson,
          orElse: () => rxDeliveryAddresses.first,
        );
      } else {
        rxDeliveryAddress.value = rxDeliveryAddresses.first;
      }

      _sharedPrefs.setString(
        selectedAddressKey,
        jsonEncode(rxDeliveryAddress.value!.toJson()),
      );
    }
  }

  Future<void> selectDeliveryAddress(UserAddress newDeliveryAddress) async {
    String selectedAddressKey =
        sharedPrefsSelectedAddressKey(rxCustomerDetail.value);

    await _sharedPrefs.setString(
      selectedAddressKey,
      jsonEncode(newDeliveryAddress.toJson()),
    );

    rxDeliveryAddress.value = newDeliveryAddress;
  }

  void _watchRelatedCustomers() {
    _rxRelatedCustomersSubscription = _database.managers.relatedCustomers
        .filter(
          (f) => f.managerSoldTo.equals(rxUserDetail.value.soldToNumber),
        )
        .watch()
        .listen(
          (customers) {},
        );
  }

  Future<void> selectCustomer(String customerSoldToNumber) async {
    final customerDetailComp = await Api.fetchUserData(customerSoldToNumber);

    if (customerDetailComp != null) {
      rxCustomerDetail.value = UserDetail(
        id: 0,
        mobileNumber: customerDetailComp.mobileNumber.value,
        name: customerDetailComp.name.value,
        soldToNumber: customerDetailComp.soldToNumber.value,
        companyCode: customerDetailComp.companyCode.value,
        companyName: customerDetailComp.companyName.value,
        role: customerDetailComp.role.value,
        category: customerDetailComp.category.value,
      );

      await _sharedPrefs.setString(
        sharedPrefsSelectedCustomerKey(rxUserDetail.value),
        customerSoldToNumber,
      );
    }
  }

  Future<void> refreshRelatedCustomers() async {
    final relatedCustomers = await Api.fetchRelatedCustomers(
      userCategory: rxUserDetail.value.category,
      userAddressNumber: rxUserDetail.value.soldToNumber,
    );

    await _database.managers.relatedCustomers
        .filter(
          (f) => f.managerSoldTo.equals(rxUserDetail.value.soldToNumber),
        )
        .delete();

    _database.managers.relatedCustomers.bulkCreate(
      (o) => relatedCustomers,
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<void> logOut() async {
    await _database.managers.userDetails.delete();

    loginController.rxUserDetail.value = null;
  }

  @override
  void dispose() {
    _rxRelatedCustomersSubscription.cancel();

    _rxCustomerDetailSubscription.cancel();

    super.dispose();
  }
}
