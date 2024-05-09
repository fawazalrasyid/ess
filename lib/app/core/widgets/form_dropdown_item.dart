import 'package:flutter/material.dart';

import '../values/app_colors.dart';

class FormDropdownItem extends StatelessWidget {
  const FormDropdownItem({
    super.key,
    required this.controller,
    required this.label,
    required this.hintLabel,
    required this.isRequired,
    required this.dropdownItems,
    required this.selectedValue,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final String hintLabel;
  final bool isRequired;
  final List<String> dropdownItems;
  final String selectedValue;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          textAlign: TextAlign.start,
          TextSpan(
            children: [
              TextSpan(
                text: label,
                style: const TextStyle(
                  color: Color(0xFF0E132E),
                  fontSize: 14,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (isRequired)
                const TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Color(0xFFE94B3D),
                    fontSize: 14,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField(
          decoration: InputDecoration(
            enabled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.textFieldBorder,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.focusedTextFieldBorder,
              ),
            ),
            border: InputBorder.none,
            hintText: hintLabel,
            hintStyle: const TextStyle(
              color: AppColors.textFieldHint,
              fontSize: 14,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w400,
            ),
            contentPadding: const EdgeInsets.all(14),
          ),
          items: dropdownItems.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          // value: selectedValue,
          onChanged: (value) => onChanged(value),
        ),
      ],
    );
  }
}
