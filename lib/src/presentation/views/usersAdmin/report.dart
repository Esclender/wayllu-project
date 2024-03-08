import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

@RoutePage()
class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomNavBar(),
      backgroundColor: bgPrimary,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            AutoRouter.of(context).navigateBack(); ;
          },
          child: const Icon(Ionicons.arrow_back),
        ),
        backgroundColor: bgPrimary,
        title: _buildTextHeader(),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(
                  height: 4,
                ),
                optionNewReport(context, 'Movimiento de Stock'),
                optionNewReport(context, 'Ventas por Feria'),
                optionNewReport(context, 'Ventas por Mes'),
                optionNewReport(context, 'Ventas por Fecha'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container optionNewReport(BuildContext context, String name) {
    return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 4),
                  padding: const EdgeInsets.only(left: 8),
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
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Color(0xFF241E20),
                          fontSize: 16,
                          fontFamily: 'Gotham',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                      const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Ionicons.ellipsis_vertical,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),);
  }
}

Widget _buildTextHeader() {
  return Text(
    'Nuevo Informe',
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
