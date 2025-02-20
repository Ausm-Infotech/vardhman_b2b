import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/constants.dart';

class CatalogSearchField extends StatelessWidget {
  CatalogSearchField({
    super.key,
    required this.labelText,
    required this.rxString,
    required this.searchList,
    this.isEnabled = true,
    this.isRequired = false,
    this.errorValue,
    this.shouldEnforceList = true,
  });

  final String labelText;
  final RxString rxString;
  final String? errorValue;
  final List<String> searchList;
  final bool isEnabled;
  final bool isRequired;
  final bool shouldEnforceList;

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
              padding: const EdgeInsets.only(left: 8),
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
                          fontWeight: FontWeight.bold,
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
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: isEnabled ? Colors.white : VardhmanColors.dividerGrey,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: rxString.value == errorValue
                      ? VardhmanColors.red
                      : VardhmanColors.darkGrey,
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: DropdownSearch<String>(
                      decoratorProps: DropDownDecoratorProps(
                        baseStyle: TextStyle(
                          color: VardhmanColors.darkGrey,
                          fontSize: 13,
                        ),
                        decoration: InputDecoration(
                          hintText: isEnabled ? 'select' : null,
                          hintStyle: TextStyle(
                            color: VardhmanColors.darkGrey,
                            fontSize: 13,
                          ),
                          contentPadding: EdgeInsets.only(left: 8),
                          border: border,
                          enabledBorder: border,
                          focusedBorder: border,
                          disabledBorder: border,
                        ),
                      ),
                      popupProps: PopupProps.menu(
                        searchFieldProps: TextFieldProps(
                          autocorrect: false,
                          style: TextStyle(
                            color: VardhmanColors.darkGrey,
                            fontSize: 13,
                          ),
                        ),
                        showSearchBox: true,
                        fit: FlexFit.loose,
                        searchDelay: Duration(milliseconds: 0),
                        itemBuilder: (context, item, isDisabled, isSelected) =>
                            ListTile(
                          title: Text(
                            item,
                            style: TextStyle(
                              color: VardhmanColors.darkGrey,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      items: (searchText, cs) async {
                        if (shouldEnforceList) {
                          return searchList;
                        } else {
                          final trimmedSearchText = searchText.trim();

                          return [
                            if (trimmedSearchText.isNotEmpty &&
                                !searchList.contains(trimmedSearchText))
                              trimmedSearchText,
                            ...searchList
                          ];
                        }
                      },
                      autoValidateMode: AutovalidateMode.disabled,
                      onChanged: (value) => rxString.value = value ?? '',
                      selectedItem:
                          rxString.value.isEmpty ? null : rxString.value,
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
