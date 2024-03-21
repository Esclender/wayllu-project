import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/config/theme/app_theme.dart';
import 'package:wayllu_project/src/domain/dtos/user_credentials_rep.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/is_admin_cubit.dart';
import 'package:wayllu_project/src/presentation/widgets/login/text_login.dart';
import 'package:wayllu_project/src/presentation/widgets/login/text_login_field.dart';
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

    return AnnotatedRegion(
      value: SystemStyles.login,
      child: Scaffold(
        backgroundColor: bgPrimary,
        body: Container(
          decoration: BoxDecoration(
            gradient: gradientLogin,
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
                      value: 40,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const MyTextLabel(hintText: 'DNI'),
                        const SpaceY(),
                        TextLoginField(
                          controller: controllerEmail,
                          hintText: 'Ingrese su DNI',
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const MyTextLabel(hintText: 'Password'),
                        const SpaceY(),
                        TextLoginField(
                          controller: controllerClave,
                          hintText: 'Ingrese con su correo',
                          obscureText: true,
                        ),
                        const SpaceY(),
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
                            'Ingresar',
                            style: TextStyle(color: Colors.white),
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
}
