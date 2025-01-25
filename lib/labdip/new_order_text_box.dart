import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/constants.dart';

class NewOrderTextBox extends StatelessWidget {
  NewOrderTextBox({
    super.key,
    required this.label,
    this.hintText,
    required this.text,
    this.minLines,
  });

  final String label;
  final String? hintText;
  final String text;
  final int? minLines;

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: VardhmanColors.dividerGrey,
          width: 0.5,
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              minLines: minLines,
              maxLines: minLines,
              controller: TextEditingController.fromValue(
                TextEditingValue(
                  text: text,
                  selection: TextSelection.collapsed(
                    offset: text.length,
                  ),
                ),
              ),
              decoration: InputDecoration(
                label: Text(label),
                hintText: hintText,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.1,
                    color: VardhmanColors.dividerGrey,
                  ),
                ),
              ),
              enabled: false,
            ),
          ),
        ],
      ),
    );
  }
}
