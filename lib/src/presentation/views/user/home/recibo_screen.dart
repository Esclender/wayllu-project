import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/domain/models/venta/venta_repo.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/productos_carrito_cubit.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';
import 'package:wayllu_project/src/utils/functions/date_converter.dart';

@RoutePage()
class ReciboScreen extends HookWidget {
  final VentaInfo ventaInfo;
  final appRouter = getIt<AppRouter>();

  ReciboScreen({
    required this.ventaInfo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgContainer,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _registroExitoso(),
              _fechaRegistro(),
              _productosRegistrados(),
              _registroTotal(),
              _enviarProducto(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        key: key,
      ),
    );
  }

  Widget _registroExitoso() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 30, top: 30),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: line,
            width: 2.0,
          ),
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.check,
            size: 50.0,
            color: Colors.green,
          ),
          const SizedBox(height: 20.0),
          Text(
            '¡Gracias por su registro!',
            style: _textStyle(iconColor, 20, FontWeight.w500),
          ),
          const SizedBox(height: 10.0),
          Text(
            'Registro #${ventaInfo.CODIGO_REGISTRO}',
            style: _textStyle(subs, 14, FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _fechaRegistro() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: line,
            width: 2.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fecha de registro',
            style: _textStyle(iconColor, 16, FontWeight.w500),
          ),
          const SizedBox(height: 10.0),
          Text(
            formatDate(ventaInfo.FECHA_REGISTRO),
            style: _textStyle(subs, 14, FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _productosRegistrados() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Text(
            'Productos Registrados',
            style: _textStyle(iconColor, 16, FontWeight.w500),
          ),
        ),
        ...getProductContainers(),
      ],
    );
  }

  List<Widget> getProductContainers() {
    return ventaInfo.PRODUCTOS.map((producto) {
      return Container(
        padding: const EdgeInsets.all(30.0),
        margin: const EdgeInsets.only(bottom: 20),
        color: Colors.grey[200],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/img1.jpg',
                  width: 100,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    producto['DESCRIPCION'] as String,
                    style: _textStyle(iconColor, 16, FontWeight.w500),
                  ),
                  Text(
                    // producto['categoria'] ?? '',
                    producto['CATEGORIA'] as String,
                    style: _textStyle(subs, 14, FontWeight.w400),
                  ),
                  Text(
                    'Cantidad: ${producto['CANTIDAD']}',
                    style: _textStyle(iconColor, 14, FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _registroTotal() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: buttontotal.withOpacity(0.6),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Productos Totales',
                style: _textStyle(iconColor, 16, FontWeight.w500),
              ),
              Text(
                ventaInfo.CANTIDAD_TOTAL_PRODUCTOS.toString(),
                style: _textStyle(iconColor, 20, FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _enviarProducto(BuildContext context) {
    final cartCubit = context.read<ProductsCarrito>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Registro',
                style: _textStyle(iconColor, 16, FontWeight.w500),
              ),
              Text(
                ventaInfo.ESTADO ? 'Exitoso' : 'Sin Registrar',
                style: _textStyle(estadotxt, 16, FontWeight.w500),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Container(
        //   width: double.infinity,
        //   padding: const EdgeInsets.all(15.0),
        //   margin: const EdgeInsets.symmetric(horizontal: 10.0),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10.0),
        //     border: Border.all(color: secondaryColor, width: 2.0),
        //   ),
        //   child: TextButton(
        //     onPressed: () {
        //       // Acción cuando se presiona el botón
        //     },
        //     child: Text(
        //       'Compartir Registro',
        //       style: _textStyle(secondaryColor, 14, FontWeight.w500),
        //     ),
        //   ),
        // ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextButton(
            onPressed: () {
              cartCubit.removeAll();
              appRouter.navigate(HomeRoute(viewIndex: 0));
            },
            child: Text(
              'Concluir',
              style: _textStyle(bgContainer, 14, FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }

  TextStyle _textStyle(Color color, double fontSize, FontWeight fontWeight) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: 'Gotham',
    );
  }
}
