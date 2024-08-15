
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';


SizedBox wrappedContainerTextForm(
  BuildContext context,
  TextEditingController pesoController,
  ValueNotifier<String> tipoPesoController,
  TextEditingController altoController,
  TextEditingController anchoController,
) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height:
        MediaQuery.of(context).size.height * 0.24, // Adjust height as needed
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Wrap(
          spacing: 10, // Spacing between elements
          runSpacing: 16, // Spacing between rows
          children: [
            _buildTextField(
              context,
              'Peso',
              'Ingresa el Peso',
              pesoController,
            ),
            _buildTextField(
              context,
              'Tipo de peso',
              null,
              null,
              isCombo: true,
              valueNotifier: tipoPesoController,
            ),
            _buildTextField(
              context,
              'Alto',
              'Alto del producto',
              altoController,
            ),
            _buildTextField(
              context,
              'Ancho',
              'Ancho del producto',
              anchoController,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildTextField(
  BuildContext context,
  String title,
  String? description,
  TextEditingController? controller, {
  bool isCombo = false,
  ValueNotifier? valueNotifier,
}) {
  if (isCombo) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width * 0.90) / 2 - 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF241E20),
              fontSize: 16,
              fontFamily: 'Gotham',
              fontWeight: FontWeight.w500,
              height: 1.5, // Adjust height as needed
            ),
          ),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(
                  0xFFCCCCCC,
                ), // Replace bottomNavBarStroke with a color
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              isExpanded: true,
              value: valueNotifier!.value,
              hint: const Text('Tipo de peso'),
              icon: const Icon(Ionicons.chevron_down),
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.transparent,
              ),
              onChanged: (newValue) {
                if (newValue != null) {
                  valueNotifier.value = newValue;
                }
              },
              items: ['gramos'].map<DropdownMenuItem>((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  return SizedBox(
    width: (MediaQuery.of(context).size.width * 0.90) / 2 - 6,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF241E20),
            fontSize: 16,
            fontFamily: 'Gotham',
            fontWeight: FontWeight.w500,
            height: 1.5, // Adjust height as needed
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(
                  0xFFCCCCCC), // Replace bottomNavBarStroke with a color
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
                height: 1.5, // Adjust height as needed
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
