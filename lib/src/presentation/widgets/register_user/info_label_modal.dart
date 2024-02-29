import 'package:flutter/material.dart';

class InfoLabelModal extends StatelessWidget {
  const InfoLabelModal({
    super.key,
    required this.hintText,
    required this.valueText,
  });

  final String hintText;
  final String valueText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            hintText,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(valueText),
        ),
      ],
    );
  }
}
