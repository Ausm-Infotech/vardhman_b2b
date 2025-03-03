import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/constants.dart';

class NewOrderTextField extends StatelessWidget {
  NewOrderTextField({
    super.key,
    required this.labelText,
    this.hintText = '',
    required this.rxString,
    this.isEnabled = true,
    this.minLines = 1,
    this.isRequired = false,
    this.hasError = false,
    this.inputFormatters = const [],
    this.trailingWidget,
  });

  final String labelText;
  final String hintText;
  final RxString rxString;
  final bool isEnabled;
  final int? minLines;
  final bool isRequired;
  final bool hasError;
  final List<TextInputFormatter> inputFormatters;
  final Widget? trailingWidget;

  final TextEditingController textEditingController = TextEditingController();

  final border = OutlineInputBorder(
    borderSide: BorderSide.none,
  );

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        String finalHintText = hintText;

        if (isEnabled && isRequired && finalHintText.isEmpty) {
          finalHintText = 'input required';
        }

        return Padding(
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
                    color:
                        isEnabled && hasError && rxString.value.trim().isEmpty
                            ? VardhmanColors.red
                            : VardhmanColors.darkGrey,
                    width: 1.5,
                  ),
                  color: isEnabled
                      ? Colors.white
                      : VardhmanColors.dividerGrey.withAlpha(128),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        inputFormatters: inputFormatters,
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
                          hintText: finalHintText,
                          hintStyle: TextStyle(
                            color: VardhmanColors.darkGrey,
                            fontSize: 13,
                          ),
                          contentPadding: EdgeInsets.only(left: 8),
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
                    if (trailingWidget != null) trailingWidget!,
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
