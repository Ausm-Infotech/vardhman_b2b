import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/constants.dart';

class RupeeText extends StatelessWidget {
  final String label;
  final double amount;
  final double discountAmount, iconSize, fontSize;

  const RupeeText({
    super.key,
    this.label = '',
    required this.amount,
    this.discountAmount = 0,
    this.iconSize = 17,
    this.fontSize = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (label.isNotEmpty) ...[
          Text(label),
          SizedBox(
            width: 8,
          )
        ],
        Icon(
          Icons.currency_rupee_sharp,
          color: VardhmanColors.darkGrey,
          size: iconSize,
        ),
        Flexible(
          child: Text(
            amount.toStringAsFixed(2),
            style: TextStyle(
              decoration: discountAmount.isGreaterThan(0)
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              decorationThickness: 2,
              color: amount.isNegative
                  ? VardhmanColors.green
                  : discountAmount.isGreaterThan(0)
                      ? Colors.grey
                      : VardhmanColors.darkGrey,
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (discountAmount.isGreaterThan(0)) ...[
          SizedBox(
            width: 4,
          ),
          Text(
            discountAmount.toStringAsFixed(2),
            style: TextStyle(
              color: VardhmanColors.green,
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
          )
        ]
      ],
    );
  }
}
