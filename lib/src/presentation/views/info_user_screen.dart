import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/domain/models/user_info_model.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

@RoutePage()
class InfoUserScreen extends HookWidget {
  final bool isAdmin;

  InfoUserScreen({this.isAdmin = false});

  final ImagePicker imagePicker = ImagePicker();

  int get viewIndex => 1;

  final PersonalInfo person = PersonalInfo(
    dni: '123456789',
    nombre: 'Maria Jose Fernandez',
    comunidad: 'Grupo 1',
    clave: 'Enero20.',
  );

  final ContactInfo contact = ContactInfo(telefono: '928590695');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: bgPrimary,
      body: Column(
        children: [
          _topVector(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAvatar(person),
            ],
          ),
          Column(
            children: [
              _buildInfoContainer('Informacion Personal', person),
              _buildInfoContainer('Informacion de Contacto', contact),
              if (!isAdmin) _buildInhabilitButton() else Container(),
            ],
          ),
        ],
      ),
      floatingActionButton: BottomNavBar(
        viewSelected: viewIndex,
      ),
    );
  }

  Widget _buildInhabilitButton() {
    return TextButton(
      onPressed: () {},
      child: const Text('Deshabilitar'),
    );
  }

  Widget _buildAvatar(PersonalInfo person) {
    final ValueNotifier<File?> profileImage = useState(null);

    Future selectImage() async {
      final XFile? image =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        profileImage.value = File(image.path);
      }
    }

    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        CircleAvatar(
          radius: 80.0,
          backgroundImage:
              profileImage.value != null || person.urlProfile != null
                  ? profileImage.value != null
                      ? FileImage(profileImage.value!) as ImageProvider
                      : NetworkImage(person.urlProfile!)
                  : null,
          backgroundColor: Colors.grey,
          child: profileImage.value != null || person.urlProfile != null
              ? null
              : const Icon(
                  Ionicons.person,
                  size: 60,
                  color: Colors.white,
                ),
        ),
        InkWell(
          onTap: selectImage,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: bgPrimary, width: 5),
              borderRadius: const BorderRadius.all(Radius.circular(40)),
            ),
            child: CircleAvatar(
              backgroundColor: secondaryColor,
              child: const Icon(
                Ionicons.pencil,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoContainer(
    String container,
    InfoBase data,
  ) {
    final BoxShadow boxShadow = BoxShadow(
      color: Colors.grey.withOpacity(0.5), // Color of the shadow
      spreadRadius: 1, // Spread radius of the shadow
      blurRadius: 7, // Blur radius of the shadow
      offset: const Offset(0, 3), // Offset of the shadow
    );

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: bgContainer,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            boxShadow,
          ],
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                container,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildGrid(data.entries),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(List<List> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => _buildGridRow(data[index]),
        separatorBuilder: (c, i) => const Divider(),
        itemCount: data.length,
      ),
    );
  }

  Widget _buildGridRow(List entry) {
    bool isObscure = true;
    if (entry[0] == 'Clave') {
      return StatefulBuilder(
        builder: (context, setState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  entry[0].toString(),
                  style: const TextStyle(fontWeight: FontWeight.w300),
                ),
              ),
              Flexible(
                flex: 2,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  child: const Icon(Ionicons.eye),
                ),
              ),
              Flexible(
                child: TextFormField(
                  decoration: const InputDecoration(border: InputBorder.none),
                  keyboardType: TextInputType.text,
                  obscureText: isObscure,
                  initialValue: entry[1] as String,
                  readOnly: true,
                ),
              ),
            ],
          );
        },
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          entry[0].toString(),
          style: const TextStyle(fontWeight: FontWeight.w300),
        ),
        Text(
          entry[1].toString(),
        ),
      ],
    );
  }

  Widget _topVector(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      child: Image.asset(
        'assets/Vector-Top.png',
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    );
  }
}
