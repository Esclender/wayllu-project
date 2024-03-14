import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

class RegisterProducts extends StatelessWidget {
  const RegisterProducts({super.key});

  void _navigateBack() {}

  @override
  Widget build(BuildContext context) {
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
          containerTextForm(context, 'Nombre de Producto', 'Ingrese producto'),
          containerTextForm(context, 'Descripción', 'Ingrese descripción'),
        ],
      ),
    );
  }

  SizedBox containerTextForm(
      BuildContext context, String title, String description) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
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
            padding: const EdgeInsets.only(right: 4),
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
                contentPadding: const EdgeInsets.only(left: 6),
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
            height: MediaQuery.of(context).size.height * 0.23,
            width: MediaQuery.of(context).size.width * 0.8,
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
