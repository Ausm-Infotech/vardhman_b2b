import 'package:flutter/material.dart';

class LabelRow extends StatelessWidget {
  final String leading;
  final String title;
  final String trailing;
  final Color color;
  final Color textColor;

  const LabelRow({
    super.key,
    this.leading = '',
    required this.title,
    this.trailing = '',
    required this.color,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: textColor,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      child: Container(
        color: color,
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              leading,
            ),
            Text(
              title,
            ),
            Text(
              trailing,
            ),
          ],
        ),
      ),
    );
  }
}
