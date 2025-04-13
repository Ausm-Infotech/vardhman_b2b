import 'package:flutter/material.dart';

class OrderDetailCell extends StatelessWidget {
  const OrderDetailCell({
    super.key,
    required this.cellText,
    this.textColor,
  });

  final String cellText;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(
        cellText,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
  }
}
