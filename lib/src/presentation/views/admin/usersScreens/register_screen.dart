import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/data/api_repository.imp.dart';
import 'package:wayllu_project/src/domain/dtos/registerArtisanDto/artisan_rep.dart';
import 'package:wayllu_project/src/domain/models/community_model.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/artisans_register_cubit.dart';
import 'package:wayllu_project/src/presentation/widgets/gradient_widgets.dart';
import 'package:wayllu_project/src/presentation/widgets/register_user/info_label_modal.dart';
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
  final _formKey = GlobalKey<FormState>();

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
  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: Text('¿Estas segura de crear el nuevo usuario?', style: TextStyle(fontSize: 18)),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  InfoLabelModal(hintText: 'Usuario:', valueText: username ?? ''),
                  const SpaceY(),
                  InfoLabelModal(hintText: 'Dni:', valueText: dni ?? ''),
                  const SpaceY(),
                  InfoLabelModal(hintText: 'Teléfono:', valueText: phone ?? ''),
                  const SpaceY(),
                  InfoLabelModal(hintText: 'Email:', valueText: email ?? ''),
                  const SpaceY(),
                  InfoLabelModal(hintText: 'Comunidad:', valueText: community ?? ''),
                  const SpaceY(),
                  InfoLabelModal(hintText: 'URL Imagen:', valueText: urlImage ?? ''),
                  const SpaceY(),
                  InfoLabelModal(hintText: 'Rol:', valueText: rol ?? ''),
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text('Volver'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text('Guardar'),
                    onPressed: () {
                      if (username != null &&
                          dni != null &&
                          community != null &&
                          password != null &&
                          urlImage != null &&
                          rol != null) {
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

                        context.read<ArtisansCubit>().registerArtisan(artesano);

                        Navigator.of(context).pop();
                        FocusScope.of(context).unfocus();
                        _formKey.currentState?.reset();
                      } else {
                        // Handle the case when any variable is null
                        // Show an error message or some other action
                      }
                    },
                  ),
                ],
              ),
            ],
          );
        },
      );
    }
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
          child: ListView(
            children: [
              Column(
                children: [
                  const MyTextLabel(hintText: 'Usuario:'),
                  const SizedBox(height: 10),
                  MyTextField(
                    onChanged: (text) {},
                    onSaved: (val) => {
                      setState(() {
                        username = val;
                      }),
                    },
                    hintText: 'Maria',
                    obscureText: false,
                  ),
                  const SpaceY(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MyTextLabel(hintText: 'DNI:'),
                      const SizedBox(height: 10),
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
                  const SpaceY(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MyTextLabel(hintText: 'Teléfono:'),
                      const SizedBox(height: 10),
                      MyTextField(
                        onChanged: (text) {},
                        onSaved: (val) => {
                          setState(() {
                            phone = val;
                          }),
                        },
                        hintText: '987654321',
                        obscureText: false,
                      ),
                    ],
                  ),
                  const SpaceY(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MyTextLabel(
                          hintText: 'Email',
                          warText: '*Opcional*',
                        ),
                        const SizedBox(
                          height: 10,
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
                    const SpaceY(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MyTextLabel(
                          hintText: 'Comunidad:',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          onChanged: (text) {},
                          onSaved: (val) => {
                            setState(() {
                              community = val;
                            }),
                          },
                          hintText: 'Ingresa la comunidad',
                          obscureText: false,
                      ),
                    ],
                  ),
                  const SpaceY(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MyTextLabel(hintText: 'URL Imagen:'),
                      const SizedBox(height: 10),
                      MyTextField(
                        onChanged: (text) {},
                        onSaved: (val) => {
                          setState(() {
                            urlImage = val;
                          }),
                        },
                        hintText: 'https://example.com/image.jpg',
                        obscureText: false,
                      ),
                    ],
                  ),
                  const SpaceY(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MyTextLabel(hintText: 'Rol:'),
                      const SizedBox(height: 10),
                      MyTextField(
                        onChanged: (text) {},
                        onSaved: (val) => {
                          setState(() {
                            rol = val;
                          }),
                        },
                        hintText: 'ARTESANO',
                        obscureText: false,
                      ),
                    ],
                  ),
                ],
              ),
              const SpaceY(),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MyTextLabel(hintText: 'Contraseña:'),
                          const SizedBox(height: 10),
                          MyTextField(
                            onSaved: (val) => {
                              setState(() {
                                password = val;
                              }),
                            },
                            hintText: '12345678',
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MyTextLabel(hintText: 'Confirmar'),
                          const SizedBox(height: 10),
                          MyTextField(
                            onSaved: (val) => {
                              setState(() {
                                confirmPassword = val;
                              }),
                            },
                            hintText: '12345678',
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                  ],
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
