import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';
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
  });

  final String labelText;
  final RxString rxString;
  final List<String> searchList;
  final bool isEnabled;
  final bool isRequired;

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
                  color: VardhmanColors.darkGrey,
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SearchField(
                      key: GlobalKey(debugLabel: labelText),
                      suggestionsDecoration: SuggestionDecoration(
                        selectionColor: VardhmanColors.dividerGrey,
                      ),
                      suggestionStyle: TextStyle(
                        color: VardhmanColors.darkGrey,
                        fontSize: 13,
                        fontWeight: isEnabled ? null : FontWeight.w500,
                      ),
                      searchInputDecoration: SearchInputDecoration(
                        hintText: isEnabled ? 'select' : null,
                        fillColor: VardhmanColors.dividerGrey,
                        contentPadding: EdgeInsets.only(left: 8),
                        border: border,
                        enabledBorder: border,
                        focusedBorder: border,
                        disabledBorder: border,
                        searchStyle: TextStyle(
                          color: VardhmanColors.darkGrey,
                          fontSize: 13,
                          fontWeight: isEnabled ? null : FontWeight.w500,
                        ),
                      ),
                      enabled: isEnabled && searchList.isNotEmpty,
                      suggestions: searchList
                          .map(
                            (searchKey) => SearchFieldListItem(searchKey),
                          )
                          .toList(),
                      onSuggestionTap: (searchFieldListItem) {
                        rxString.value = searchFieldListItem.searchKey;
                      },
                      selectedValue: rxString.isEmpty ||
                              !searchList.contains(rxString.value)
                          ? null
                          : SearchFieldListItem(rxString.value),
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
