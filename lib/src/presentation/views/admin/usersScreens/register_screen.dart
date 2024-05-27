import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:logger/logger.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/users_list_cubit.dart';
import 'package:wayllu_project/src/presentation/widgets/register_user/my_text_label.dart';
import 'package:wayllu_project/src/presentation/widgets/register_user/my_textfield.dart';
import 'package:wayllu_project/src/presentation/widgets/register_user/space_y.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

@RoutePage()
class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({super.key});

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  String? nombre, dni, phone, email, community, password, confirmPassword;
  final _formKey = GlobalKey<FormState>();
  final appRouter = getIt<AppRouter>();
  var communitySelect;

  final List<Map> communities = [
    {'codigoComunidad': 1, 'comunidad': 'Huilloc'},
    {'codigoComunidad': 2, 'comunidad': 'Rumira Sondormayo'},
    {'codigoComunidad': 3, 'comunidad': 'Patacancha'},
    {'codigoComunidad': 4, 'comunidad': 'Yanamayo'},
    {'codigoComunidad': 5, 'comunidad': 'Quellccancca'},
  ];

  List<DropdownMenuItem> get communityDropdownItems =>
      communities.map((community) {
        return DropdownMenuItem(
          value: community,
          child: Text(community['comunidad'] as String),
        );
      }).toList();

  @override
  void dispose() {
    _textEditingController.clear();
    super.dispose();
  }

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
    if (nombre == null ||
        dni == null ||
        phone == null ||
        communitySelect == null ||
        password == null ||
        confirmPassword == null) {
      _showAlertDialog('Ingresa los campos obligatorios');
      return;
    }

    if (dni!.length != 8 || !RegExp(r'^[0-9]+$').hasMatch(dni!)) {
      _showAlertDialog('El DNI debe tener 8 números');
      return;
    }

    if (phone!.length != 9 || !RegExp(r'^[0-9]+$').hasMatch(phone!)) {
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

    // final userCubit = context.watch<>();
    final userInfoToSend = {
      'NOMBRE_COMPLETO': nombre,
      'COMUNIDAD': communitySelect['comunidad'],
      'DNI': dni,
      'CDG_COMUNIDAD': communitySelect['codigoComunidad'],
      'CLAVE': password,
    };

    await context.read<UsersListCubit>().registerUser(userInfoToSend);

    _showLoadingDialog('Artesano registrado..');
    Timer(const Duration(seconds: 2), () {
      appRouter.popForced();
      _resetFields();
    });

    Logger().i(userInfoToSend);
  }

  void _resetFields() {
    setState(() {
      nombre = null;
      dni = null;
      phone = null;
      email = null;
      communitySelect = null;
      password = null;
      confirmPassword = null;
      _formKey.currentState?.reset();
    });
  }

  Widget _buildTextField(
    String label,
    String hint,
    bool obscureText,
    void Function(String?) onSave, {
    bool isOptional = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextLabel(hintText: isOptional ? '$label (Opcional)' : label),
        const SizedBox(height: 10),
        MyTextField(
          onChanged: (text) {},
          onSaved: onSave,
          hintText: hint,
          obscureText: obscureText,
        ),
      ],
    );
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
        title: const Text(
          'Registrar Usuario',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Gotham',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                children: [
                  _buildTextField(
                    'Nombre:',
                    'Tu Nombre',
                    false,
                    (val) => setState(() => nombre = val),
                  ),
                  const SpaceY(),
                  _buildTextField(
                    'DNI:',
                    '87654321',
                    false,
                    (val) => setState(() => dni = val),
                  ),
                  const SpaceY(),
                  _buildTextField(
                    'Teléfono:',
                    '987654321',
                    false,
                    (val) => setState(() => phone = val),
                  ),
                  const SpaceY(),
                  _buildTextField(
                    'Email',
                    'ejemplo@gmail.com',
                    false,
                    (val) => setState(() => email = val ?? ''),
                    isOptional: true,
                  ),
                  const SpaceY(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MyTextLabel(hintText: 'Comunidad:'),
                      const SizedBox(height: 10),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(120, 0, 0, 0),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(120, 0, 0, 0),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: communityDropdownItems,
                        hint: Text(
                          'Comunidad',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color.fromARGB(128, 0, 0, 0),
                          ),
                        ),
                        onChanged: (value) =>
                            setState(() => communitySelect = value),
                        onSaved: (value) =>
                            setState(() => communitySelect = value),
                      ),
                    ],
                  ),
                ],
              ),
              const SpaceY(),
              Row(
                children: [
                  Expanded(
                      child: _buildTextField('Contraseña:', '', true,
                          (val) => setState(() => password = val))),
                  const SizedBox(width: 20),
                  Expanded(
                      child: _buildTextField('Confirmar', '', true,
                          (val) => setState(() => confirmPassword = val))),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Text(
                  '_errorMessage',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.58),
                  ),
                  backgroundColor: HexColor('#FFA743'),
                  minimumSize: const Size.fromHeight(60),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _submit();
                  }
                },
                child: Text(
                  'Registrar',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
