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
    this.isEnabled = true,
    this.minLines,
    this.isRequired = false,
  });

  final String labelText;
  final String? hintText;
  final RxString rxString;
  final bool isEnabled;
  final int? minLines;
  final bool isRequired;

  final TextEditingController textEditingController = TextEditingController();

  final border = OutlineInputBorder(
    borderSide: BorderSide.none,
  );

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: RichText(
                text: TextSpan(
                  text: labelText,
                  style: TextStyle(
                    color: VardhmanColors.darkGrey,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    if (isRequired)
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: VardhmanColors.darkGrey,
                  width: 1,
                ),
                color: Colors.white,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        color: VardhmanColors.darkGrey,
                        fontSize: 13,
                        fontWeight: isEnabled ? null : FontWeight.w500,
                      ),
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
                        hintText: isEnabled && isRequired
                            ? hintText ?? 'input needed'
                            : null,
                        hintStyle: TextStyle(
                          color: isRequired
                              ? VardhmanColors.red
                              : VardhmanColors.darkGrey,
                          fontSize: 13,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 8,
                        ),
                        border: border,
                        enabledBorder: border,
                        focusedBorder: border,
                      ),
                      onChanged: (value) => rxString.value = value,
                      enabled: isEnabled,
                    ),
                  ),
                  if (isEnabled && rxString.value.isNotEmpty)
                    SecondaryButton(
                      wait: false,
                      iconData: Icons.clear,
                      text: '',
                      onPressed: () async {
                        rxString.value = '';
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
