import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

class DropDownOptions<T> extends HookWidget {
  final String optionHead;
  final List<T> options;
  final ValueNotifier<T> selectedOption;
  final String? displayField;

  DropDownOptions({
    required this.optionHead,
    required this.options,
    required this.selectedOption,
    this.displayField,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          optionHead,
          style: const TextStyle(
            color: Color(0xFF241E20),
            fontSize: 16,
            fontFamily: 'Gotham',
            fontWeight: FontWeight.w500,
            height: 1.5, // Adjust height as needed
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: const Color(
                  0xFFCCCCCC,
                ), // Replace bottomNavBarStroke with a color
             
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: DropdownButton<T>(
            isExpanded: true,
            value: selectedOption.value,
            hint: Text(optionHead),
            icon: const Icon(Ionicons.chevron_down),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.transparent,
            ),
            onChanged: (T? newValue) {
              if (newValue != null) {
                selectedOption.value = newValue;
              }
            },
             items: options.map((T option) {
            return DropdownMenuItem<T>(
              value: option,
              child: Text(option is Map<String, String>
                  ? option[displayField]!
                  : option.toString()),
            );
          }).toList(),
          ),
        ),
      ],
    );
  }
}

