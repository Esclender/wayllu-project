import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

class ActivityHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
 
  final String formattedDate = DateFormat('d \'de\' MMMM \'de\' y', 'es_ES').format(DateTime.now());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Actividad',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: iconColor
            ),
          ),
          Text(
            'Hoy, $formattedDate',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}