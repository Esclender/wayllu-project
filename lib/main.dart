import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/config/theme/app_theme.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/is_admin_cubit.dart';
import 'package:wayllu_project/src/presentation/views/home_screen.dart';
import 'package:wayllu_project/src/presentation/views/usersAdmin/register_products.dart';
import 'package:wayllu_project/src/presentation/views/usersAdmin/report.dart';

Future<void> main() async {
 await initializeDateFormatting('es');

  initializeDependecies();
  
  runApp(BlocSettup());
}

class BlocSettup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserLoggedCubit>(
          create: (BuildContext context) => UserLoggedCubit(),
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = getIt<AppRouter>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp/*.router*/(
      debugShowCheckedModeBanner: false,
      theme: ThemeApp.light,
    //routerConfig: _appRouter.config(),
    home: RegisterProducts(),
    );
  }
}
