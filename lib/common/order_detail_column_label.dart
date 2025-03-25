import 'package:flutter/material.dart';

class OrderDetailColumnLabel extends StatelessWidget {
  const OrderDetailColumnLabel({
    super.key,
    required this.labelText,
  });

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(color: Colors.white, width: 0.2))),
      alignment: Alignment.centerRight,
      child: Text(
        labelText,
        textAlign: TextAlign.end,
        softWrap: true,
      ),
    );
  }
}
