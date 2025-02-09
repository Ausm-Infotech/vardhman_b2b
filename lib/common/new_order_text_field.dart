import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/constants.dart';

class NewOrderTextField extends StatelessWidget {
  NewOrderTextField({
    super.key,
    required this.labelText,
    this.hintText,
    required this.rxString,
    this.enabled = true,
    this.minLines,
  });

  final String labelText;
  final String? hintText;
  final RxString rxString;
  final bool enabled;
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
            child: Obx(
              () => TextField(
                minLines: minLines,
                maxLines: minLines,
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: rxString.value,
                    selection: TextSelection.collapsed(
                      offset: rxString.value.length,
                    ),
                  ),
                ),
                decoration: InputDecoration(
                  label: Text(labelText),
                  hintText: hintText,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.1,
                      color: VardhmanColors.dividerGrey,
                    ),
                  ),
                ),
                onChanged: (value) => rxString.value = value,
                enabled: enabled,
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (enabled)
            Obx(
              () => SecondaryButton(
                wait: false,
                iconData: Icons.clear,
                text: '',
                onPressed: rxString.value.isEmpty
                    ? null
                    : () async {
                        rxString.value = '';
                      },
              ),
            ),
        ],
      ),
    );
  }
}
