import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/domain/dtos/user_credentials_rep.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/is_admin_cubit.dart';
import 'package:wayllu_project/src/presentation/widgets/register_user/my_text_label.dart';
import 'package:wayllu_project/src/presentation/widgets/register_user/space_y.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

@RoutePage()
class LoginExampleScreen extends HookWidget {
  final credentialsAdmin = const UserCredentialDto(
    dni: 'admin',
    clave: 'admin',
  );

  final credentialsUser = const UserCredentialDto(
    dni: 'user',
    clave: 'user',
  );

  //Dependencies Injection
  final appRouter = getIt<AppRouter>();

  void _loginEvent(String dni, String clave, BuildContext context) {
    final credentialsUser = UserCredentialDto(
      dni: dni,
      clave: clave,
    );

    context.read<UserLoggedCubit>().isAdmin(credentialsUser);
    appRouter.navigate(HomeRoute(viewIndex: 0));
  }

  @override
  Widget build(BuildContext context) {
    final controllerEmail = useTextEditingController(text: 'admin');
    final controllerClave = useTextEditingController(text: 'admin');

    return Scaffold(
      backgroundColor: bgPrimary,
      body: Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  HexColor('#B800FF'),
                  HexColor('#FFA743'),
                  HexColor('#B800FF')
                ],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.2, 0.4, 0.9],
                tileMode: TileMode.clamp)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset('assets/ISOTIPO.PNG'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('BIENVENIDO 👋'),
                    ],
                  ),
                  Row(children: [
                    Text('A '),
                    Text('WAYLLU'),
                  ])
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextLabel(hintText: 'Correo'),
                  SpaceY(),
                  TextFormField(
                    controller: controllerEmail,
                    decoration: InputDecoration(
                      hintText: 'Escriba su mail',
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        color: const Color.fromARGB(128, 0, 0, 0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(120, 0, 0, 0)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(120, 0, 0, 0)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextLabel(hintText: 'Clave'),
                  SpaceY(),
                  TextFormField(
                    controller: controllerClave,
                    decoration: InputDecoration(
                      hintText: 'Escriba su clave',
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        color: const Color.fromARGB(128, 0, 0, 0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(120, 0, 0, 0)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(120, 0, 0, 0)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                    ),
                  ),
                  SpaceY(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.58),
                      ),
                      backgroundColor: HexColor('#B80000'),
                      minimumSize: const Size.fromHeight(60),
                    ),
                    onPressed: () => _loginEvent(
                      controllerEmail.text,
                      controllerClave.text,
                      context,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
