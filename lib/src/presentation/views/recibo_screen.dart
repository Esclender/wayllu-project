import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

@RoutePage()
class ReciboScreen extends HookWidget{
  ReciboScreen({super.key});

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: bgContainer,
    body:SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                RegistroExitoso(),
                SizedBox(height: 40),
                FechaRegistro(),
                SizedBox(height: 40),
                ProductosRegistrados(),
                SizedBox(height: 40),
                RegistroTotal(),
                SizedBox(height: 50),
                EnviarProducto(),
              ],
            ),
          ),
        ),
      ),
    bottomNavigationBar: BottomNavBar(
      key: key,
    ),
  );
}
}


class RegistroExitoso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: line, width: 2.0), // Borde inferior negro de 2.0 de ancho
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.check,
            size: 50.0,
            color: Colors.green,
          ),
          SizedBox(height: 20.0),
          Text(
            '¡Gracias por su registro!',
            style: TextStyle(
              color: iconColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: 'Gotham',
              ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Registro #247596',
            style: TextStyle(
              color: subs,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Gotham',
              ),
          ),
        ],
      ),
    );
  }
}

class FechaRegistro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 30.0,left: 30.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: line, width: 2.0), // Borde inferior negro de 2.0 de ancho
        ),
      ), // Añade espacio alrededor del contenido
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Fecha de registro',
            style: TextStyle(
              color: iconColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Gotham',
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Agosto 9, 2023', // Puedes sustituir esto con la fecha real
            style: TextStyle(
              color: subs,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Gotham',
              ),
          ),
        ],
      ),
    );
  }
}

class ProductosRegistrados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0), 
          child: Text(
            'Productos Registrados',
            style: TextStyle(
              color: iconColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Gotham',
              ),
          ),
        ),
        for (int i = 0; i < 2; i++)
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(30.0), // Padding para el contenido
                color: Colors.grey[200], // Color de fondo
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "../../../assets/images/img1.jpg",
                          width: 100,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0), // Espaciador entre las columnas
                    // Columna de la derecha con la información del producto
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nombre del Producto',
                            style: TextStyle(
                                color: iconColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Gotham',
                            ),
                          ),
                          Text(
                            'Categoría del Producto',
                            style: TextStyle(
                                color: subs,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Gotham',
                              ),
                          ),
                          Text(
                            '\$100.00', // Reemplaza con el precio real
                            style: TextStyle(
                                color: iconColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Gotham',
                              ),
                          ),
                          Text(
                            'Cantidad: 10', // Reemplaza con la cantidad real
                            style: TextStyle(
                                color: iconColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Gotham',
                              ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Fila con Precio Total y Monto
              SizedBox(height: 20),
             Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0), // Ajusta el padding según sea necesario
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Precio Total (10 Productos)',
                      style: TextStyle(
                        color: subs,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gotham',
                        ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '\$1000.00', // Reemplaza con el monto real
                      style: TextStyle(
                        color: iconColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gotham',
                        ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
            ],
          ),
      ],
    );
  }
}


class RegistroTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: buttontotal.withOpacity(0.6), // Color de fondo
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Gran total',
                style: TextStyle(
                  color: iconColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Gotham',
                  ),
              ),
              Text(
                'S/250', // Reemplaza con el monto real
                style: TextStyle(
                  color: iconColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gotham',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class EnviarProducto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Primera fila: Registro y Exitoso
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Registro',
                style: TextStyle(
                  color: iconColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Gotham',
                ),
              ),
              Text(
                'Exitoso',
                style: TextStyle(
                  color: estadotxt,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Gotham',
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15.0),
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color:secondaryColor, width: 2.0),
          ),
          child: TextButton(
            onPressed: () {
              // Acción cuando se presiona el botón
            },
            child: Text(
              'Compartir Registro',
              style: TextStyle(
                  color: secondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Gotham',
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15.0),
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: secondaryColor, // Color de fondo
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextButton(
            onPressed: () {
              // Acción cuando se presiona el botón
            },
            child: Text(
              'Concluir',
              style: TextStyle(
                  color: bgContainer,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Gotham',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
