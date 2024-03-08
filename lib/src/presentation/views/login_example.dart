import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/domain/dtos/user_credentials_rep.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/is_admin_cubit.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: controllerEmail,
              decoration: const InputDecoration(
                label: Text('Email'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: controllerClave,
              decoration: const InputDecoration(
                label: Text('Clave'),
              ),
            ),
            ElevatedButton(
              onPressed: () => _loginEvent(
                controllerEmail.text,
                controllerClave.text,
                context,
              ),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
