import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/domain/models/community_model.dart';
import 'package:wayllu_project/src/locator.dart';
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

  var community_select;

  String? username;
  String? dni;
  String? phone;
  String? email;
  String? community;
  String? password;
  String? confirmPassword;

  @override
  void dispose() {
    _textEditingController.clear();
    super.dispose();
  }

  bool isEmailCorrect = false;
  final _formKey = GlobalKey<FormState>();

  final appRouter = getIt<AppRouter>();

  List<DropdownMenuItem<String>> communityDropdownItems =
      list_community.map((community) {
    return DropdownMenuItem<String>(
      value: community.id,
      child: Text(community.name),
    );
  }).toList();

  Text t = Text(
    'Comunidad',
    style: GoogleFonts.poppins(
      fontSize: 14,
      color: const Color.fromARGB(
        128,
        0,
        0,
        0,
      ),
    ),
  );

// confirm modal
  void _submit() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              '¿Estas segura de crear el nuevo usuario?',
              style: TextStyle(fontSize: 18),
            ),
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
                InfoLabelModal(
                  hintText: 'Comunidad:',
                  valueText: community_select.toString(),
                ),
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
                  onPressed: () {},
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
                    Navigator.of(context).pop();
                    FocusScope.of(context).unfocus();
                    _formKey.currentState?.reset();
                  },
                ),
              ],
            ),
          ],
        );
      },
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
        title: GradientText(
          text: 'Grafico de ventas',
          fontSize: 25.0,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          30.0,
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                children: [
                  const MyTextLabel(hintText: 'Usuario:'),
                  const SizedBox(
                    height: 10,
                  ),
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
                      const SizedBox(
                        height: 10,
                      ),
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
                      const MyTextLabel(
                        hintText: 'Teléfono:',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
                    children: [
                      const MyTextLabel(
                        hintText: 'Comunidad:',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(
                                120,
                                0,
                                0,
                                0,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(
                                120,
                                0,
                                0,
                                0,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: communityDropdownItems,
                        hint: Text(
                          'Comunidad',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color.fromARGB(
                              128,
                              0,
                              0,
                              0,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            community_select = value;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            community_select = value;
                          });
                        },
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
                          const MyTextLabel(
                            hintText: 'Contraseña:',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                          const MyTextLabel(
                            hintText: 'Confirmar',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                            onSaved: (val) => {
                              setState(() {
                                confirmPassword = val;
                              }),
                            },
                            hintText: '987654321',
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
