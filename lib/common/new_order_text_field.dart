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
        padding: const EdgeInsets.all(8.0),
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
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    if (isRequired)
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
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
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: VardhmanColors.darkGrey,
                  width: 0.5,
                ),
              ),
              padding: EdgeInsets.all(4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
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
                  const SizedBox(
                    width: 8,
                    height: 38,
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
