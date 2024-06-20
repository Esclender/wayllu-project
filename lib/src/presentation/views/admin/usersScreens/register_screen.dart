import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/domain/dtos/registerArtisanDto/artisan_rep.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/artisans_register_cubit.dart';
import 'package:wayllu_project/src/presentation/widgets/gradient_widgets.dart';
import 'package:wayllu_project/src/presentation/widgets/register_user/my_text_label.dart';
import 'package:wayllu_project/src/presentation/widgets/register_user/my_textfield.dart';
import 'package:wayllu_project/src/presentation/widgets/register_user/space_y.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';
import 'package:wayllu_project/src/utils/firebase/firebase_helper.dart';

@RoutePage()
class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({super.key});

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;

  List<Map<String, dynamic>> communities = [
    {'codigoComunidad': 1, 'comunidad': 'Huilloc'},
    {'codigoComunidad': 2, 'comunidad': 'Rumira Sondormayo'},
    {'codigoComunidad': 3, 'comunidad': 'Patacancha'},
    {'codigoComunidad': 4, 'comunidad': 'Yanamayo'},
    {'codigoComunidad': 5, 'comunidad': 'Quellccancca'},
  ];

  Map<String, dynamic>? selectedCommunity;

  String? username;
  String? dni;
  String? phone;
  String? email;
  String? community;
  String? password;
  String? confirmPassword;
  String? urlImage;
  String? rol;

  @override
  void dispose() {
    _textEditingController.clear();
    super.dispose();
  }

  final appRouter = getIt<AppRouter>();

  void _showAlertDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning,
                color: HexColor('#B80000'),
              ),
              const SizedBox(height: 20),
              Text(message),
            ],
          ),
        );
      },
    );
  }

  void _showLoadingDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: HexColor('#B80000'),
              ),
              const SizedBox(height: 20),
              Text(message),
            ],
          ),
        );
      },
    );
  }

  bool _isValidEmail(String? email) {
    if (email == null) return false;
    final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  Future<void> _submit() async {
    if (username == null ||
        dni == null ||
        phone == null ||
        community == null ||
        password == null ||
        confirmPassword == null) {
      _showAlertDialog('Ingresa los campos obligatorios');
      return;
    }

    if (dni!.length != 8 || !RegExp(r'^[0-9]+$').hasMatch(dni!)) {
      _showAlertDialog('El DNI debe tener 8 números');
      return;
    }

    if (rol == 'ARTESANO' && (phone == null || community == null)) {
      _showAlertDialog('Ingresa los campos obligatorios');
      return;
    }

    if (rol == 'ARTESANO' &&
        (phone!.length != 9 || !RegExp(r'^[0-9]+$').hasMatch(phone!))) {
      _showAlertDialog('El teléfono debe tener 9 números');
      return;
    }

    if (email != null && email != '' && !_isValidEmail(email)) {
      _showAlertDialog('Ingresa un correo electrónico válido');
      return;
    }

    if (password != confirmPassword) {
      _showAlertDialog('Las contraseñas no coinciden');
      return;
    }

    _showLoadingDialog('Cargando...');
    appRouter.popForced();

    final artesano = ArtesanoDto(
      NOMBRE_COMPLETO: username!,
      DNI: int.parse(dni!),
      COMUNIDAD: community!,
      CDG_COMUNIDAD: 1, // Example value for CDG_COMUNIDAD
      CLAVE: password!,
      CODIGO: 1005, // Example value for CODIGO
      URL_IMAGE: urlImage!,
      ROL: rol!,
    );

    try {
      await context.read<ArtisansCubit>().registerArtisan(artesano);
      _showLoadingDialog('Artesano registrado..');
      Timer(const Duration(seconds: 2), () {
        appRouter.popForced();
        _resetFields();
      });
    } catch (error) {
      _showAlertDialog('Error al registrar el artesano');
    }
  }

  Future<void> _pickImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final File imageFile = File(image.path);
      final String imageUrl =
          await uploadImageToFirebase(imageFile, folder: '/Artisans_Images');
      if (imageUrl != null) {
        setState(() {
          _selectedImage = imageFile;
          urlImage = imageUrl;
        });
      }
    }
  }

  void _resetFields() {
    setState(() {
      username = null;
      dni = null;
      phone = null;
      email = null;
      community = null;
      password = null;
      confirmPassword = null;
      urlImage = null;
      rol = null;
      _formKey.currentState?.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPrimary,
      appBar: AppBar(
        backgroundColor: bgPrimary,
        surfaceTintColor: Colors.transparent,
        leading: InkWell(
          onTap: () => {appRouter.pop()},
          child: const Icon(Ionicons.arrow_back),
        ),
        title: GradientText(
          text: 'Registro de Usuario',
          fontSize: 25.0,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            Column(children: [
              Column(
                children: [
                  photoUser(),
                ],
              ),
           Column(
                  children: [
                    const MyTextLabel(hintText: 'Rol'),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(bottom:8.0),
                      child: DropdownButtonFormField<String>(
                        value: rol,
                        onChanged: (String? newValue) {
                          setState(() {
                            rol = newValue;
                          });
                        },
                        items: <String>['ARTESANO', 'ADMIN']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: 'Selecciona el rol',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:8.0),
                      child: Column(
                        children: [ 
                      const MyTextLabel(hintText: 'Nombre'),
                      const SizedBox(height: 8),
                      MyTextField(
                        onChanged: (text) {},
                        onSaved: (val) => {
                          setState(() {
                            username = val;
                          }),
                        },
                        hintText: 'Maria',
                        obscureText: false,
                      ),],
                      ),
                    ),
                   
                    Padding(
                     padding: const EdgeInsets.only(bottom:8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MyTextLabel(hintText: 'DNI:'),
                          const SizedBox(height: 8),
                          MyTextField(
                            onChanged: (text) {},
                            onSaved: (val) => {
                              setState(() {
                                dni = val;
                              }),
                            },
                            hintText: '87654321',
                            obscureText: false,
                          ),
                        ],
                      ),
                    ),
                    if (rol == 'ARTESANO') ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom:8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: MyTextLabel(hintText: 'Celular'),),
                            const SizedBox(height: 8),
                            MyTextField(
                              onChanged: (text) {},
                              onSaved: (val) => setState(() {
                                phone = val;
                              }),
                              hintText: 'Ingresa tu número de celular',
                              obscureText: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                    
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MyTextLabel(
                            hintText: 'Email',
                            warText: '*Opcional*',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          MyTextField(
                            onChanged: (text) {},
                            onSaved: (val) => {
                              setState(() {
                                email = val ?? '';
                              }),
                            },
                            hintText: 'ejemplo@gmail.com',
                            obscureText: false,
                          ),
                        ],
                      ),
                    ),
                    
                    if (rol == 'ARTESANO') ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom:8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MyTextLabel(
                              hintText: 'Comunidad:',
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            DropdownButtonFormField<Map<String, dynamic>>(
                              value: selectedCommunity,
                              onChanged: (Map<String, dynamic>? value) {
                                setState(() {
                                  selectedCommunity = value;
                                  community = value?['comunidad'] as String;
                                });
                              },
                              items:
                                  communities.map((Map<String, dynamic> community) {
                                return DropdownMenuItem<Map<String, dynamic>>(
                                  value: community,
                                  child: Text(community['comunidad'] as String),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                fillColor: Colors.transparent,
                                hintText: 'Selecciona la comunidad',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    Padding(
                      padding: const EdgeInsets.only(bottom:8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: MyTextLabel(hintText: 'Contraseña:'),
                          ),
                          const SizedBox(height: 8),
                          MyTextField(
                            onChanged: (text) {},
                            onSaved: (val) => {
                              setState(() {
                                password = val;
                              }),
                            },
                            hintText: '******',
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                    const SpaceY(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MyTextLabel(hintText: 'Confirmar contraseña:'),
                        const SizedBox(height: 8),
                        MyTextField(
                          onChanged: (text) {},
                          onSaved: (val) => {
                            setState(() {
                              confirmPassword = val;
                            }),
                          },
                          hintText: '******',
                          obscureText: true,
                        ),
                      ],
                    ),
                    const SpaceY(),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        colorOne: '#800080',
                        colorTwo: '#C3C3DD',
                        text: 'Registrar',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _submit();
                          }
                        },
                      ),
                    ),
                  ],
                ),
             
            ],),
          ],),
        ),
      ),
    );
  }

  InkWell photoUser() {
    return InkWell(
      onTap: _pickImage,
      child: CircleAvatar(
        radius: 70,
        backgroundColor: const Color.fromARGB(255, 190, 190, 190),
        backgroundImage:
            _selectedImage != null ? FileImage(_selectedImage!) : null,
        child: _selectedImage == null
            ? const Icon(Icons.camera_alt_outlined,
                color: Color.fromARGB(255, 78, 78, 78),)
            : null,
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String colorOne;
  final String colorTwo;
  final String text;
  final VoidCallback onTap;

  const CustomButton({
    required this.colorOne,
    required this.colorTwo,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [btnprimary, btnsecondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
