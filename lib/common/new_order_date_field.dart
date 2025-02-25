import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/constants.dart';

class NewOrderDateField extends StatelessWidget {
  NewOrderDateField({
    super.key,
    required this.labelText,
    this.hintText = '',
    required this.rxDate,
    this.isEnabled = true,
    this.minLines,
    this.isRequired = false,
    this.hasError = false,
  });

  final String labelText;
  final String hintText;
  final Rxn<DateTime> rxDate;
  final bool isEnabled;
  final int? minLines;
  final bool isRequired;
  final bool hasError;

  final noneBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
  );

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
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
                    color: isEnabled && hasError && rxDate.value == null
                        ? VardhmanColors.red
                        : VardhmanColors.darkGrey,
                    width: 1.5,
                  ),
                  color: isEnabled ? Colors.white : VardhmanColors.dividerGrey,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DateTimeField(
                        mode: DateTimeFieldPickerMode.date,
                        decoration: InputDecoration(
                          errorBorder: noneBorder,
                          focusedBorder: noneBorder,
                          enabledBorder: noneBorder,
                          focusedErrorBorder: noneBorder,
                          border: OutlineInputBorder(),
                          suffixIcon: Container(),
                          hintText: isEnabled ? 'select' : null,
                          hintStyle: TextStyle(
                            color: VardhmanColors.darkGrey,
                            fontSize: 13,
                          ),
                          prefixText: rxDate.value != null
                              ? DateFormat('d MMM yyyy').format(rxDate.value!)
                              : null,
                          prefixStyle: TextStyle(
                            color: VardhmanColors.darkGrey,
                            fontSize: 13,
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 8,
                            top: 0,
                          ),
                        ),
                        value: rxDate.value,
                        onChanged: (DateTime? date) {
                          if (date != null) {
                            rxDate.value = date;
                          }
                        },
                      ),
                    ),
                    if (isEnabled && rxDate.value != null)
                      SecondaryButton(
                        wait: false,
                        iconData: Icons.clear,
                        text: '',
                        onPressed: () async {
                          rxDate.value = null;
                        },
                      ),
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
