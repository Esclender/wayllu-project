// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/config/theme/app_theme.dart';
import 'package:wayllu_project/src/domain/dtos/usersCredentialsDto/user_credentials_rep.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/user_logged_cubit.dart';
import 'package:wayllu_project/src/presentation/widgets/login/text_login.dart';
import 'package:wayllu_project/src/presentation/widgets/login/text_login_field.dart';
import 'package:wayllu_project/src/presentation/widgets/register_user/my_text_label.dart';
import 'package:wayllu_project/src/presentation/widgets/register_user/space_y.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

@RoutePage()
class LoginExampleScreen extends HookWidget {
  //Dependencies Injection
  final appRouter = getIt<AppRouter>();

  Future<void> _loginEvent(
    String dni,
    String clave,
    BuildContext context,
  ) async {
    final dialogCompleter = Completer<BuildContext>();
    showLoadingDialog(context, dialogCompleter);
    final credentialsUser = UserCredentialDto(
      DNI: int.parse(dni),
      CLAVE: clave,
    );

    final token = await context
        .read<UserLoggedCubit>()
        .getAccessTokenAndSetRol(credentialsUser)
        .catchError((e) {
      Navigator.pop(context);
      return null;
    }).then((value) {
      return value;
    });

    if (token != null) {
      initializeEndpoints(token);
      appRouter.popAndPush(HomeRoute(viewIndex: 0));
      await context.read<UserLoggedInfoCubit>().setUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controllerEmail = useTextEditingController(text: '12345678');
    final controllerClave = useTextEditingController(text: '1234');

    return AnnotatedRegion(
      value: SystemStyles.login,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            gradient: loginGradient,
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 40, left: 20, bottom: 40, right: 20),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/ISOTIPO.png'),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          children: [
                            TextLogin(
                              text: 'BIENVENIDO 👋',
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            TextLogin(text: 'A '),
                            TextLogin(
                              text: 'WAYLLU',
                              colorText: Colors.amber,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SpaceY(
                      value: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const MyTextLabel(hintText: 'DNI'),
                        const SizedBox(
                          height: 10,
                        ),
                        TextLoginField(
                          controller: controllerEmail,
                          hintText: 'Ingrese su DNI',
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const MyTextLabel(hintText: 'Password'),
                        const SpaceY(),
                        TextLoginField(
                          controller: controllerClave,
                          hintText: 'Ingrese con su correo',
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.58),
                            ),
                            backgroundColor: HexColor('#B80000'),
                            minimumSize: const Size.fromHeight(50),
                          ),
                          onPressed: () => _loginEvent(
                            controllerEmail.text,
                            controllerClave.text,
                            context,
                          ),
                          child: const Text(
                            'Ingresar',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showLoadingDialog(
    BuildContext context,
    Completer<BuildContext> completer,
  ) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents closing the dialog by tapping outside
      builder: (BuildContext context) {
        // completer.complete(context);
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: HexColor('#B80000'),
              ),
              const SizedBox(height: 20),
              const Text('Cargando...'),
            ],
          ),
        );
      },
    );
  }
}
