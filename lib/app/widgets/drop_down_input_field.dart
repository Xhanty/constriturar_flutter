import 'package:flutter/material.dart';
import 'package:constriturar/app/core/config/app_colors.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';

class DropDownInputField<T> extends StatelessWidget {
  const DropDownInputField({
    super.key,
    required this.searchController,
    required this.data,
    required this.onSuggestionSelected,
    required this.itemBuilder,
    required this.itemFilter,
    this.hintText = 'Seleccione una opción',
    required this.isMultiple,
  });

  final TextEditingController searchController;
  final List<T> data;
  final void Function(T) onSuggestionSelected;
  final Widget Function(BuildContext, T) itemBuilder;
  final bool Function(T, String) itemFilter;
  final String hintText;
  final bool isMultiple;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.lightPrimary,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropDownSearchField<T>(
              displayAllSuggestionWhenTap: true,
              isMultiSelectDropdown: isMultiple,
              loadingBuilder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              textFieldConfiguration: TextFieldConfiguration(
                autofocus: false,
                controller: searchController,
                cursorColor: AppColors.primary,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.primary,
                  ),
                  hintText: hintText,
                  hintStyle: const TextStyle(fontFamily: 'Gilroy'),
                  border: InputBorder.none,
                ),
              ),
              suggestionsCallback: (pattern) async {
                if (pattern.isEmpty) {
                  return data;
                }
                return data.where((element) {
                  return itemFilter(element, pattern);
                }).toList();
              },
              onSuggestionSelected: onSuggestionSelected,
              itemBuilder: itemBuilder,
            ),
          ),
        ),
      ),
    );
  }
}
