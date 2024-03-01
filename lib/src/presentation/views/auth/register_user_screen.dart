import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wayllu_project/src/domain/models/community_model.dart';
import 'package:wayllu_project/src/presentation/widgets/register_user/info_label_modal.dart';
import 'package:wayllu_project/src/presentation/widgets/register_user/my_text_label.dart';
import 'package:wayllu_project/src/presentation/widgets/register_user/my_textfield.dart';
import 'package:wayllu_project/src/presentation/widgets/register_user/space_y.dart';

@RoutePage()
class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({super.key});

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  final nameEditingController = TextEditingController();
  final dniEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final communityEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final passwordConfirmEditingController = TextEditingController();
  var community_select;

  @override
  void dispose() {
    _textEditingController.clear();
    super.dispose();
  }

  bool isEmailCorrect = false;
  final _formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> communityDropdownItems =
      list_community.map((community) {
    return DropdownMenuItem<String>(
      value: community.id,
      child: Text(community.name),
    );
  }).toList();

  void _submit() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Estas segura de crear el nuevo usuario?'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                InfoLabelModal(
                  hintText: 'Usuario',
                  valueText: nameEditingController.text,
                ),
                const SpaceY(),
                InfoLabelModal(
                  hintText: 'Dni',
                  valueText: dniEditingController.text,
                ),
                const SpaceY(),
                InfoLabelModal(
                  hintText: 'Teléfono',
                  valueText: phoneEditingController.text,
                ),
                const SpaceY(),
                InfoLabelModal(
                  hintText: 'Email',
                  valueText: emailEditingController.text,
                ),
                const SpaceY(),
                InfoLabelModal(
                  hintText: 'Comunidad',
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
                  onPressed:
                      () {}, // so the alert dialog is closed when navigating back to main page
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('#FCF6F0'),
        body: Center(
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const MyTextLabel(hintText: 'Usuario:'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    MyTextField(
                                      onChanged: (text) {},
                                      controller: nameEditingController,
                                      hintText: 'Maria',
                                      obscureText: false,
                                    ),
                                  ],
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
                                      controller: dniEditingController,
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
                                      controller: phoneEditingController,
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
                                      controller: emailEditingController,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                const SpaceY(),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const MyTextLabel(
                                              hintText: 'Contraseña:',
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            MyTextField(
                                              controller:
                                                  passwordConfirmEditingController,
                                              hintText: '12345678',
                                              obscureText: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const MyTextLabel(
                                              hintText: 'Confirmar',
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            MyTextField(
                                              controller:
                                                  passwordConfirmEditingController,
                                              hintText: '987654321',
                                              obscureText: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SpaceY(),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 0, 0),
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
                                    //TODO: ADD VALIDATIONS FOR FIELDS
                                    _submit();
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    // Transform.translate(
    //   offset: const Offset(0, -253),
    //   child: Image.asset(
    //     'assets/images/',
    //     scale: 1.5,
    //     width: double.infinity,
    //   ),
    // ),
  }
}
