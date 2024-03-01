import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/domain/models/models_products.dart';
import 'package:wayllu_project/src/presentation/cubit/is_admin_cubit.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

@RoutePage()
class HomeScreen extends HookWidget {
  const HomeScreen();

  int get viewIndex => 0;

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final int hour = now.hour;
    final String greeting = getGreeting(hour);
    final isAdmin = context.read<UserLoggedCubit>().state;

    return Scaffold(
      backgroundColor: bgPrimary,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
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
                dashboard(context, isAdmin),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [barSearch(context), shoppingCart(context)],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        categoriesProducts(
                          context,
                          'Gorros',
                          'assets/images/product/gorro-category.png',
                        ),
                        categoriesProducts(
                          context,
                          'Ponchos',
                          'assets/images/product/poncho-category.png',
                        ),
                        categoriesProducts(
                          context,
                          'Mantos',
                          'assets/images/product/manto-category.png',
                        ),
                        categoriesProducts(
                          context,
                          'Ponchos',
                          'assets/images/product/poncho-category.png',
                        ),
                        categoriesProducts(
                          context,
                          'Mantos',
                          'assets/images/product/manto-category.png',
                        ),
                        categoriesProducts(
                          context,
                          'Gorros',
                          'assets/images/product/gorro-category.png',
                        ),
                        categoriesProducts(
                          context,
                          'Ponchos',
                          'assets/images/product/poncho-category.png',
                        ),
                        categoriesProducts(
                          context,
                          'Mantos',
                          'assets/images/product/manto-category.png',
                        ),
                        categoriesProducts(
                          context,
                          'Ponchos',
                          'assets/images/product/poncho-category.png',
                        ),
                        categoriesProducts(
                          context,
                          'Mantos',
                          'assets/images/product/manto-category.png',
                        ),
                      ],
                    ),
                  ),
                ),
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
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Column(
                    children: List.generate(
                      productos.length ~/ 2, // Usar la mitad de la longitud
                      (index) {
                        final evenIndex = index * 2;
                        final oddIndex = evenIndex + 1;
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: productsHome(
                                    context,
                                    productos[evenIndex],
                                    isAdmin,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: oddIndex < productos.length
                                      ? productsHome(
                                          context,
                                          productos[oddIndex],
                                          isAdmin,
                                        )
                                      : Container(),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomNavBar(
        viewSelected: viewIndex,
      ),
    );
  }

  Center dashboard(BuildContext context, UserRoles rol) {
    final bool isAdmin = rol == UserRoles.admin;

    return Center(
      child: isAdmin
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.24,
              decoration: BoxDecoration(
                color: bottomNavBar,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 95, 95, 95)
                        .withOpacity(0.08), // Color de la sombra y su opacidad
                    spreadRadius: 2, // Radio de propagación de la sombra
                    blurRadius: 4, // Radio de desenfoque de la sombra
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
                        height: MediaQuery.of(context).size.height * 0.09,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: iconColor.withOpacity(0.7),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),),
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
                            Image.asset('assets/stacks.png')
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                color: thirdColor.withOpacity(0.4),
                                shape: BoxShape.circle,),
                            child: Icon(
                              Ionicons.checkmark,
                              color: thirdColor,
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                color: thirdColor.withOpacity(0.4),
                                shape: BoxShape.circle,),
                            child: Icon(
                              Ionicons.checkmark,
                              color: thirdColor,
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                    ],
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}

Container productsHome(BuildContext context, Producto producto, UserRoles rol) {
  final bool isAdmin = rol == UserRoles.admin;

  return Container(
    width: MediaQuery.of(context).size.width * 0.45,
    height: MediaQuery.of(context).size.height * 0.285,
    decoration: BoxDecoration(
      color: bottomNavBar,
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 95, 95, 95)
              .withOpacity(0.08), // Color de la sombra y su opacidad
          spreadRadius: 2, // Radio de propagación de la sombra
          blurRadius: 4, // Radio de desenfoque de la sombra
          offset: const Offset(
            0,
            1,
          ),
        ),
      ],
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.19,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: AssetImage(producto.imagen),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 8.0, // Ajusta la posición del botón según sea necesario
              right: 8.0,
              child: !isAdmin
                  ? Container(
                      padding: const EdgeInsets.all(4.5),
                      decoration: BoxDecoration(
                        color: bottomNavBar,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 0.2, color: iconColor),
                      ),
                      child: Icon(
                        Ionicons.add,
                        color: iconColor,
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: EdgeInsets.only(right: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                producto.name,
                style: const TextStyle(
                  fontFamily: 'Gotham',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                producto.description,
                style: const TextStyle(
                  fontFamily: 'Gotham',
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'S/${producto.price}',
                    style: const TextStyle(
                      fontFamily: 'Gotham',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (isAdmin)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical:4, horizontal: 6),
                      decoration: BoxDecoration(
                        color:
                            secondaryColor, // Puedes cambiar el color según tus necesidades
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'Editar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Container shoppingCart(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.11,
    height: MediaQuery.of(context).size.width * 0.11,
    decoration: BoxDecoration(
      color: bottomNavBar,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 95, 95, 95)
              .withOpacity(0.08), // Color de la sombra y su opacidad
          spreadRadius: 2, // Radio de propagación de la sombra
          blurRadius: 4, // Radio de desenfoque de la sombra
          offset: const Offset(
            0,
            1,
          ), // Desplazamiento de la sombra (en este caso, hacia abajo)
        ),
      ],
    ),
    child: const Icon(Ionicons.bag_handle_outline),
  );
}

Container barSearch(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.75,
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
      height: MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.width * 0.35,
      decoration: BoxDecoration(
        color: bottomNavBar,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 95, 95, 95)
                .withOpacity(0.08), // Color de la sombra y su opacidad
            spreadRadius: 2, // Radio de propagación de la sombra
            blurRadius: 4, // Radio de desenfoque de la sombra
            offset: const Offset(
              0,
              1,
            ), // Desplazamiento de la sombra (en este caso, hacia abajo)
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(alignment: Alignment.center, child: Image.asset(image)),
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
