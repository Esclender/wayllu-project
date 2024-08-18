import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PhotoProduct extends StatelessWidget {
  final ValueNotifier<String>? existingImageUrl;  // URL de la imagen existente en la base de datos, puede ser null
  final ValueNotifier<File?> newProductImage;     // Imagen recién seleccionada
  final Future<void> Function() selectImage;      // Función para seleccionar imagen

  PhotoProduct({
    this.existingImageUrl,
    required this.newProductImage,
    required this.selectImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            await selectImage();
            // El manejo de la subida de la imagen se realizará fuera de este widget.
          },
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.grey,
            backgroundImage: newProductImage.value != null
                ? FileImage(newProductImage.value!) as ImageProvider<Object>?
                : (existingImageUrl != null && existingImageUrl!.value.isNotEmpty
                    ? NetworkImage(existingImageUrl!.value)
                    : null),
            child: newProductImage.value == null &&
                    (existingImageUrl == null || existingImageUrl!.value.isEmpty)
                ? const Icon(Ionicons.camera_outline, color: Colors.white)
                : null,
          ),
        ),
      ],
    );
  }
}

