import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/domain/models/models_products.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

class HomeScreen extends HookWidget {
  const HomeScreen(param0, {super.key});

  @override
  Widget build(BuildContext context) {
    // Determinar el saludo según la hora
    DateTime now = DateTime.now();
    int hour = now.hour;
    String greeting = getGreeting(hour);
    return Scaffold(
      backgroundColor: bgPrimary,
      /* appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const SizedBox(
                    width: 45,
                    height: 45,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/admin2.jpg"),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        greeting + "Mariano",
                        style: const TextStyle(
                          fontFamily: 'Gotham',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1,
                          color: Color(0xff313131),
                        ),
                        maxLines:
                            1, // Establece el número máximo de líneas que el texto puede ocupar
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        flexibleSpace: Column(
          children: [
            topVector(context),
          ],
        ),
      ),*/
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 68.0, // Altura expandida del SliverAppBar
            floating:
                true, // La barra de herramientas no se "desvanece" hacia arriba
            pinned:
                false, 
            backgroundColor: Colors.transparent,// La barra de herramientas se "ancla" en la parte superior
            flexibleSpace: FlexibleSpaceBar(
              
              background: topVector(context),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const SizedBox(
                        width: 45,
                        height: 45,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/admin2.jpg"),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            "Mariano", // Cambiado a un nombre fijo para simplificar
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
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
                        categoriesProducts(context, "Ponchos",
                            "assets/images/product/poncho-category.png"),
                        categoriesProducts(context, "Mantos",
                            "assets/images/product/manto-category.png"),
                        categoriesProducts(
                          context,
                          'Gorros',
                          'assets/images/product/gorro-category.png',
                        ),
                        categoriesProducts(context, "Ponchos",
                            "assets/images/product/poncho-category.png"),
                        categoriesProducts(context, "Mantos",
                            "assets/images/product/manto-category.png"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Todos los productos",
                    style: TextStyle(
                        fontFamily: "Gotham",
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              /*  SizedBox(
                  height: 10,
                ),*/
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: productos.length,
                    itemBuilder: (context, index) {
                      final producto = productos[index];

                      return index.isEven
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: productsHome(context, producto),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Expanded(
                                      child: index + 1 < productos.length
                                          ? productsHome(
                                              context, productos[index + 1])
                                          : Container(),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                              ],
                            )
                          : Container();
                    },
                  ),
                ),
              ],
            ),
          ),
           
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomNavBar(),
    );
  }

  Container productsHome(BuildContext context, Producto producto) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height * 0.285,
      decoration: BoxDecoration(
        color: bottomNavBar,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 95, 95, 95)
                .withOpacity(0.08), // Color de la sombra y su opacidad
            spreadRadius: 2, // Radio de propagación de la sombra
            blurRadius: 4, // Radio de desenfoque de la sombra
            offset: Offset(0,
                1), // Desplazamiento de la sombra (en este caso, hacia abajo)
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: DecorationImage(
                  image: AssetImage(producto.imagen),
                  fit: BoxFit.cover,
                )),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  producto.name,
                  style: const TextStyle(
                      fontFamily: 'Gotham',
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  producto.description,
                  style: TextStyle(
                      fontFamily: "Gotham",
                      fontSize: 10,
                      fontWeight: FontWeight.w300),
                ),
                Text(
                  'S/' + producto.price.toString(),
                  style: TextStyle(
                      fontFamily: "Gotham",
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
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
            color: Color.fromARGB(255, 95, 95, 95)
                .withOpacity(0.08), // Color de la sombra y su opacidad
            spreadRadius: 2, // Radio de propagación de la sombra
            blurRadius: 4, // Radio de desenfoque de la sombra
            offset: Offset(0,
                1), // Desplazamiento de la sombra (en este caso, hacia abajo)
          ),
        ],
      ),
      child: Icon(Ionicons.bag_handle_outline),
    );
  }

  Container barSearch(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
          color: bottomNavBar,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
                fontFamily: "Gotham",
                fontWeight: FontWeight.w500,
                color: Color(0xff8A8991)),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Container categoriesProducts(
      BuildContext context, String name, String image) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.only(top: 15, bottom: 8),
        height: MediaQuery.of(context).size.height * 0.20,
        width: MediaQuery.of(context).size.width * 0.35,
        decoration: BoxDecoration(
          color: bottomNavBar,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 95, 95, 95)
                  .withOpacity(0.08), // Color de la sombra y su opacidad
              spreadRadius: 2, // Radio de propagación de la sombra
              blurRadius: 4, // Radio de desenfoque de la sombra
              offset: Offset(0,
                  1), // Desplazamiento de la sombra (en este caso, hacia abajo)
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
                    fontSize: 16),
              ),
            )
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
}
