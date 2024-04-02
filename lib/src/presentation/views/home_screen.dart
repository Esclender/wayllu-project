import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/domain/enums/lists_enums.dart';
import 'package:wayllu_project/src/domain/enums/user_roles.dart';
import 'package:wayllu_project/src/domain/models/models_products.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/products_list_cubit.dart';
import 'package:wayllu_project/src/presentation/cubit/user_logged_cubit.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/presentation/widgets/list_products.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

@RoutePage()
class HomeScreen extends HookWidget {
  final int viewIndex;
  HomeScreen({
    required this.viewIndex,
  });

  final appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final int hour = now.hour;
    final String greeting = getGreeting(hour);
    final loggedUserRol = context.read<UserLoggedCubit>().state;

    void goToRegisterOfProductOrVentaCondition() {
      if (loggedUserRol == UserRoles.admin) {
        appRouter.navigate(const RegisterProductsRoute());
      } else {
        appRouter.navigate(const CarritoRoute());
      }
    }

    final productsListCubit = context.watch<ProductListCubit>();
    // List<Producto> _data = [];
    List<Producto> data = [];

    useEffect(
      () {
        productsListCubit.getProductsLists();

        return () {};
      },
      [],
    );

    return Scaffold(
      backgroundColor: bgPrimary,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Container(),
            expandedHeight: 68.0,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: topVector(context),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const SizedBox(
                        width: 45,
                        height: 45,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/admin2.jpg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            '${greeting}Mariano',
                            style: const TextStyle(
                              fontFamily: 'Gotham',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 1,
                              color: Color(0xff313131),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(
                  height: 8,
                ),
                firstLine(context, loggedUserRol),
                dashboard(context, loggedUserRol),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // barSearch(context),
                      if (loggedUserRol == UserRoles.admin)
                        optionsAndLogout(context)
                      else
                        Container(),
                    ],
                  ),
                ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 4),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: categories.map((category) {
                //         return categoriesProducts(
                //           context,
                //           category.name,
                //           category.image,
                //         );
                //       }).toList(),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Todos los productos',
                    style: TextStyle(
                      fontFamily: 'Gotham',
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                _productsHome(context, data),
                const SizedBox(
                  height: kBottomNavigationBarHeight + 16.0,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          shoppingCart(context),
          const SizedBox(
            height: 8,
          ),
          BottomNavBar(
            viewSelected: viewIndex,
          ),
        ],
      ),
    );
  }

  Widget _productsHome(BuildContext context, List<Producto> data) {
    // final bool loggedUserRol = rol == UserRoles.admin;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Column(children: [
        Expanded(
          child: BlocBuilder<ProductListCubit, List<Producto>?>(
            builder: (context, state) {
              if (state == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                data = state;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ProductsCardsItemsList(
                      listType: ListEnums.products,
                      dataToRender: data,

                    );
                  },
                );
              }
            },
          ),
        ),
      ]),
    );
  }

  Widget optionsAndLogout(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(left: 4),
      width: MediaQuery.of(context).size.width * 0.12,
      height: MediaQuery.of(context).size.width * 0.10,
      decoration: BoxDecoration(
        color: bottomNavBar,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 95, 95, 95).withOpacity(0.08),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(
              0,
              1,
            ),
          ),
        ],
      ),
      child: PopupMenuButton<String>(
        color: bottomNavBar.withOpacity(0.9),
        offset: Offset(1, MediaQuery.of(context).size.width * 0.11),
        icon: const Icon(
          Ionicons.menu_outline,
          size: 24,
        ),
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'Ver carrito',
            child: ListTile(
              leading: Icon(Ionicons.bag_handle_outline),
              title: Text('Ver carrito'),
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            value: 'opcion2',
            child: ListTile(
              leading: Icon(
                Ionicons.exit_outline,
                color: mainColor,
              ),
              title: const Text('Cerrar sesión'),
            ),
          ),
        ],
        onSelected: (value) {},
      ),
    );
  }

  InkWell shoppingCart(BuildContext context) {
    return InkWell(
      onTap: () {
        appRouter.pushNamed('/user/carrito');
      },
      child: badge.Badge(
        badgeContent: const Text(
          '4',
          style: TextStyle(color: Colors.white),
        ),
        position: badge.BadgePosition.topEnd(end: 4),
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: FloatingActionButton(
            backgroundColor: bottomNavBar,
            shape: const CircleBorder(),
            onPressed: () {
              appRouter.pushNamed('/user/carrito');
            },
            child: Icon(
              Ionicons.bag_handle_outline,
              size: 28,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }

  Padding firstLine(BuildContext context, UserRoles rol) {
    final bool loggedUserRol = rol == UserRoles.admin;
    final dateString =
        DateFormat("dd 'de' MMMM yyyy", 'es').format(DateTime.now());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: loggedUserRol
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 18,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 120,
                    height: 18,
                    child: Text(
                      'Actividad',
                      style: TextStyle(
                        color: Color(0xFF241E20),
                        fontSize: 16,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 145,
                    child: AutoSizeText(
                      'Hoy, $dateString',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF636369),
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                      minFontSize: 10,
                      maxFontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }

  Center dashboard(BuildContext context, UserRoles rol) {
    final bool loggedUserRol = rol == UserRoles.admin;

    void goToReport() {
      if (rol == UserRoles.admin) {
        appRouter.navigate(const ReportRoute());
      }
    }

    return Center(
      child: loggedUserRol
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.22,
              decoration: BoxDecoration(
                color: bottomNavBar,
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 95, 95, 95).withOpacity(0.08),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(
                      0,
                      1,
                    ),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.08,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: iconColor.withOpacity(0.7),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Ingresos semanales',
                                  style: TextStyle(
                                    fontFamily: 'Gotham',
                                    fontSize: 12,
                                    color: clearLetters,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  'S/ 1.200,00',
                                  style: TextStyle(
                                    fontFamily: 'Gotham',
                                    fontSize: 24,
                                    color: bottomNavBar,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Image.asset('assets/stacks.png'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 8.0,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.74,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: thirdColor.withOpacity(0.4),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Ionicons.checkmark,
                                        color: thirdColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Entrada',
                                          style: TextStyle(
                                            fontFamily: 'Gotham',
                                            fontSize: 11,
                                            color: iconColor,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        Text(
                                          'S/ 2.000,50',
                                          style: TextStyle(
                                            fontFamily: 'Gotham',
                                            fontSize: 16,
                                            color: iconColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: mainColor.withOpacity(0.4),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Ionicons.caret_down_outline,
                                        color: mainColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Salida',
                                          style: TextStyle(
                                            fontFamily: 'Gotham',
                                            fontSize: 11,
                                            color: iconColor,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        Text(
                                          'S/ 800,00',
                                          style: TextStyle(
                                            fontFamily: 'Gotham',
                                            fontSize: 16,
                                            color: iconColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          btnNewReport(
                            context,
                            goToReport,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }

  TextButton btnNewReport(
    BuildContext context,
    void Function() onPressed,
  ) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        margin: const EdgeInsets.only(top: 4),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: ShapeDecoration(
          color: secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: const Center(
          child: Text(
            'Nuevo informe',
            style: TextStyle(
              fontFamily: 'Gotham',
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

Container barSearch(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.76,
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    decoration: BoxDecoration(
      color: bottomNavBar,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: const Row(
      children: [
        SizedBox(
          width: 4,
        ),
        Icon(
          Ionicons.search_sharp,
          color: Color(0xff8A8991),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          'Búsqueda',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Gotham',
            fontWeight: FontWeight.w500,
            color: Color(0xff8A8991),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Container categoriesProducts(
  BuildContext context,
  String name,
  String image,
) {
  return Container(
    padding: const EdgeInsets.symmetric(
      vertical: 8,
    ),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.only(top: 15, bottom: 8),
      height: MediaQuery.of(context).size.height * 0.18,
      width: MediaQuery.of(context).size.width * 0.32,
      decoration: BoxDecoration(
        color: bottomNavBar,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 95, 95, 95)
                .withOpacity(0.08), // Color de la sombra y su opacidad
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(
              0,
              1,
            ),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              image,
              width: MediaQuery.of(context).size.width * 0.2,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'Gotham',
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Container topVector(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    alignment: Alignment.topCenter,
    child: Image.asset(
      'assets/Vector-Top.png',
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    ),
  );
}

String getGreeting(int hour) {
  if (hour >= 0 && hour < 12) {
    return 'Buenos días, ';
  } else if (hour >= 12 && hour < 18) {
    return 'Buenas tardes, ';
  } else {
    return 'Buenas noches, ';
  }
}
