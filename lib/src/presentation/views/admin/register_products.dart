import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

@RoutePage()
class RegisterProductsScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final counter = useState(0.0);

    void incrementCounter() {
      counter.value++;
    }

    void decrementCounter() {
      if (counter.value > 0.00) {
        counter.value--;
      }
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomNavBar(),
      backgroundColor: bgPrimary,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            AutoRouter.of(context).back();
          },
          child: const Icon(Ionicons.arrow_back),
        ),
        backgroundColor: bgPrimary,
        title: _buildTextHeader(),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          photoUser(context),
          const SizedBox(
            height: 8,
          ),
          containerTextForm(context, 'Nombre de Producto', 'Ingrese producto'),
          containerTextForm(context, 'Descripción', 'Ingrese descripción'),
          priceCounter(
            context,
            counter.value,
            incrementCounter,
            decrementCounter,
          ),
          categoriesList(context),
          btnNewReport(context),
        ],
      ),
    );
  }

  SizedBox priceCounter(
    BuildContext context,
    double counter,
    void Function() incrementCounter,
    void Function() decrementCounter,
  ) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.11,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Precio',
            style: TextStyle(
              color: Color(0xFF241E20),
              fontSize: 16,
              fontFamily: 'Gotham',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.06,
                margin: const EdgeInsets.only(top: 6),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: bottomNavBar,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 95, 95, 95)
                          .withOpacity(0.08),
                      spreadRadius: 2,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$counter',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff919191),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 16.0),
                        GestureDetector(
                          onTap: incrementCounter,
                          child: Icon(
                            Ionicons.chevron_up,
                            size: 16,
                            color: bottomNavBarStroke,
                          ),
                        ),
                        const SizedBox(height: 1), // Espacio entre los botones
                        GestureDetector(
                          onTap: decrementCounter,
                          child: Icon(
                            Ionicons.chevron_down,
                            size: 16,
                            color: bottomNavBarStroke,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.06,
                margin: const EdgeInsets.only(top: 6),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: bottomNavBar,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 95, 95, 95)
                          .withOpacity(0.08),
                      spreadRadius: 2,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'S/.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox categoriesList(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.11,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Categoria',
            style: TextStyle(
              color: Color(0xFF241E20),
              fontSize: 16,
              fontFamily: 'Gotham',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.56,
            height: MediaQuery.of(context).size.height * 0.06,
            margin: const EdgeInsets.only(top: 6),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: bottomNavBar,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 95, 95, 95).withOpacity(0.08),
                  spreadRadius: 2,
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Poncho',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xff919191),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 16.0),
                    GestureDetector(
                      child: Icon(
                        Ionicons.chevron_up,
                        size: 16,
                        color: bottomNavBarStroke,
                      ),
                    ),
                    const SizedBox(height: 1.0), // Espacio entre los botones
                    GestureDetector(
                      // ignore: avoid_redundant_argument_values
                      onTap: null,
                      child: Icon(
                        Ionicons.chevron_down,
                        size: 16,
                        color: bottomNavBarStroke,
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

  TextButton btnNewReport(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 4),
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: ShapeDecoration(
          color: mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Center(
          child: Text(
            'Registrar',
            style: TextStyle(
              fontFamily: 'Gotham',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  SizedBox containerTextForm(
    BuildContext context,
    String title,
    String description,
  ) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.11,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF241E20),
              fontSize: 16,
              fontFamily: 'Gotham',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              border: Border.all(
                color: bottomNavBarStroke,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: description,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.only(left: 12),
                hintStyle: const TextStyle(
                  color: Color(0xFF241E20),
                  fontSize: 14,
                  fontFamily: 'Gotham',
                  fontWeight: FontWeight.w300,
                  height: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container photoUser(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.22,
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              border: Border.all(color: iconColor, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Ionicons.camera_outline,
              size: 64,
              color: Color(0xff241E20),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildTextHeader() {
  return Text(
    'Registrar Producto',
    style: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.bold,
      fontFamily: 'Gotham',
      foreground: Paint()
        ..shader = LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [btnprimary, btnsecondary],
        ).createShader(
          const Rect.fromLTRB(0.0, 0.0, 100.0, 60.0),
        ),
    ),
  );
}
