import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../values/app_colors.dart';

class FormItem extends StatefulWidget {
  const FormItem({
    super.key,
    required this.controller,
    this.isRequired = false,
    this.isReadOnly = false,
    required this.validator,
    required this.label,
    required this.hintLabel,
    required this.inputType,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final bool isRequired;
  final bool isReadOnly;
  final Function validator;
  final String label;
  final String hintLabel;
  final TextInputType inputType;
  final Widget? suffixIcon;

  @override
  State<FormItem> createState() => _FormItemState();
}

class _FormItemState extends State<FormItem> {
  late bool isObsecure;

  @override
  void initState() {
    super.initState();
    isObsecure = widget.inputType == TextInputType.visiblePassword;
  }

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
                text: widget.label,
                style: const TextStyle(
                  color: Color(0xFF1D2E42),
                  fontSize: 14,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (widget.isRequired)
                const TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Color(0xFFE94B3D),
                    fontSize: 14,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          readOnly: widget.isReadOnly,
          keyboardType: widget.inputType,
          textInputAction: TextInputAction.next,
          obscureText: isObsecure,
          onChanged: (text) => widget.validator(),
          maxLines: widget.inputType == TextInputType.streetAddress ? 2 : 1,
          decoration: InputDecoration(
            enabled: true,
            filled: true,
            fillColor: const Color(0xFFF8F9FD),
            suffixIcon: widget.inputType == TextInputType.visiblePassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObsecure = !isObsecure;
                      });
                    },
                    icon: isObsecure
                        ? const Icon(IconlyBold.show)
                        : const Icon(IconlyBold.hide),
                    color: AppColors.iconDefault,
                  )
                : widget.suffixIcon,
            border: InputBorder.none,
            hintText: widget.hintLabel,
            hintStyle: const TextStyle(
              color: Color(0xFF90A8BF),
              fontSize: 14,
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w400,
            ),
            contentPadding: const EdgeInsets.all(18),
          ),
        ),
      ],
    );
  }
}
