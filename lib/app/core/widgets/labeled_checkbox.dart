import 'package:flutter/material.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Checkbox(
          visualDensity: const VisualDensity(horizontal: -4.0),
          value: value,
          onChanged: (bool? newValue) {
            onChanged(newValue);
          },
          shape: RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.circular(6),
          ),
          checkColor: const Color(0xFFFFFFFF),
          activeColor: const Color(0xFF8BB905),

          // fillColor: MaterialStateProperty.resolveWith<Color>(
          //     (Set<MaterialState> states) {
          //   if (states.contains(MaterialState.selected)) {
          //     return const Color(0xFF8BB905);
          //   }
          //   return const Color(0xFF9CAEBA);
          // }),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF1D2E42),
            fontSize: 14,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
