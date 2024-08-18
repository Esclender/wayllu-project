
  import 'dart:ui';

import 'package:flutter/material.dart';

SizedBox containerTextForm(
    BuildContext context,
    String title,
    String description,
    TextEditingController controller,
  ) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.11,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF241E20),
              fontSize: 16,
              fontFamily: 'Gotham',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(
                  0xFFCCCCCC,
                ),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: description,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.only(left: 12),
                hintStyle: const TextStyle(
                  color: Color(0xFF241E20),
                  fontSize: 14,
                  fontFamily: 'Gotham',
                  fontWeight: FontWeight.w300,
                  height: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
