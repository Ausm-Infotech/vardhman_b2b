import 'package:flutter/services.dart';
import 'package:vardhman_b2b/api/order_detail_line.dart';
import 'package:vardhman_b2b/drift/database.dart';

class VardhmanColors {
  static const green = Color(0xff008b47);

  static const lightBlue = Color(0xffD9F0FF);

  static const darkGrey = Color(0xFF424242);

  static const red = Color(0xFFE61E31);

  static const dividerGrey = Color.fromARGB(255, 232, 232, 232);

  static const orange = Color(0xFFFFB300);
}

const catalogues = [
  'assets/Perma_Spun_ECO_100_1347115390.pdf',
  'assets/D_Core_453567264.pdf',
  'assets/Anesoft_907499584.pdf',
  'assets/Wild_Cat_ECO_100_1382366534.pdf',
];

const brandImages = [
  'Duro.jpg',
  'Hammer.png',
  'Kreation.png',
  'Organica.jpg',
  'Rangoli.png',
  'Tora.jpg',
];

const brands = [
  'AK56_Platinum_Plus_Platinum_Panda_Titanium_Panda_Panda_Gold_AK56_Gold_AK56_Marvel_King_Panda_Supreme_Panda_Agni',
  'Tora_Gold_Edge_Duro_Challenge',
  'Organica_Vanity',
  'Hammer',
  'Rangoli_Kreation',
];

const brandImageBrochureMap = {
  'Organica': 'Organica_Vanity',
  // 'Vanity': 'Organica_Vanity',
  // 'Tora_Gold': 'Tora_Gold_Edge_Duro_Challenge',
  // 'Tora_Gold_Edge': 'Tora_Gold_Edge_Duro_Challenge',
  // 'Duro': 'Tora_Gold_Edge_Duro_Challenge',
  'Challenge': 'Tora_Gold_Edge_Duro_Challenge',
  // 'Rangoli': 'Rangoli_Kreation',
  'Kreation': 'Rangoli_Kreation',
  'Hammer': 'Hammer',
  // 'AK56_Platinum_Plus':
  //     'AK56_Platinum_Plus_Platinum_Panda_Titanium_Panda_Panda_Gold_AK56_Gold_AK56_Marvel_King_Panda_Supreme_Panda_Agni',
  // 'Platinum_Panda':
  //     'AK56_Platinum_Plus_Platinum_Panda_Titanium_Panda_Panda_Gold_AK56_Gold_AK56_Marvel_King_Panda_Supreme_Panda_Agni',
  // 'Titanium_Panda':
  //     'AK56_Platinum_Plus_Platinum_Panda_Titanium_Panda_Panda_Gold_AK56_Gold_AK56_Marvel_King_Panda_Supreme_Panda_Agni',
  // 'Panda_Gold':
  //     'AK56_Platinum_Plus_Platinum_Panda_Titanium_Panda_Panda_Gold_AK56_Gold_AK56_Marvel_King_Panda_Supreme_Panda_Agni',
  // 'AK56_Gold':
  //     'AK56_Platinum_Plus_Platinum_Panda_Titanium_Panda_Panda_Gold_AK56_Gold_AK56_Marvel_King_Panda_Supreme_Panda_Agni',
  // 'AK56_Marvel':
  //     'AK56_Platinum_Plus_Platinum_Panda_Titanium_Panda_Panda_Gold_AK56_Gold_AK56_Marvel_King_Panda_Supreme_Panda_Agni',
  // 'King_Panda':
  //     'AK56_Platinum_Plus_Platinum_Panda_Titanium_Panda_Panda_Gold_AK56_Gold_AK56_Marvel_King_Panda_Supreme_Panda_Agni',
  // 'Supreme_Panda':
  //     'AK56_Platinum_Plus_Platinum_Panda_Titanium_Panda_Panda_Gold_AK56_Gold_AK56_Marvel_King_Panda_Supreme_Panda_Agni',
  'Agni':
      'AK56_Platinum_Plus_Platinum_Panda_Titanium_Panda_Panda_Gold_AK56_Gold_AK56_Marvel_King_Panda_Supreme_Panda_Agni',
};

String sharedPrefsSelectedCustomerKey(UserDetail userDetail) {
  return 'selectedCustomer_${userDetail.soldToNumber}';
}

String sharedPrefsSelectedAddressKey(UserDetail customerDetail) {
  return 'lastSelectedAddress_${customerDetail.soldToNumber}';
}

bool isCustomer(UserDetail userDetail) {
  return userDetail.role == 'CUSTOMER';
}

DateTime halfYearAgo() {
  return DateTime.now().subtract(
    const Duration(days: 180),
  );
}

bool areDatesEqual(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

enum OrderStatus {
  pending,
  shipped,
  cancelled,
}

Map<String, String> orderTypeConstants = {
  'LD': 'Lab Dip Order',
  'BK': 'Bulk Order',
  'DT': 'DTM Order'
};

OrderStatus getOrderDetailLineStatus(OrderDetailLine orderDetailLine) {
  if (orderDetailLine.dateShipped != null) {
    return OrderStatus.shipped;
  } else if (orderDetailLine.quantityCancelled > 0) {
    return OrderStatus.cancelled;
  } else {
    return OrderStatus.pending;
  }
}

String getAmountInLakhs(double amount) {
  if (amount > 100000) {
    return '₹${(amount / 100000).toStringAsFixed(2)} lac';
  }

  return '₹${amount.toStringAsFixed(0)}';
}

DateTime oldestDateTime = DateTime(2000, 1, 1);

String getItemNumber(
    {required String article, required String uom, required String shade}) {
  return '${article.padRight(7)}${uom.padRight(5)}$shade';
}

final capitalFormatter = TextInputFormatter.withFunction(
  (oldValue, newValue) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
    );
  },
);
