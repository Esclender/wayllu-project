import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

@RoutePage()
class CarritoScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPrimary,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            AutoRouter.of(context).pop();
          },
          child: const Icon(Ionicons.arrow_back),
        ),
        backgroundColor: bgPrimary,
        title: _buildTextHeader(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: ListView(
          children: [
            for (int i = 1; i < 4; i++)
              _buildProduct(
                productName: 'Producto',
                productDescription: 'Descripcion',
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextHeader() {
    return Text(
      'Registrar Venta',
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

  Widget _buildProduct({
    required String productName,
    required String productDescription,
  }) {
    return Container(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 110,
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
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            productName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: txtColor,
                              fontFamily: 'Gotham',
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            iconSize: 18,
                            onPressed: () {
                              // Puedes agregar lógica para eliminar este ítem del carrito aquí
                            },
                          ),
                        ],
                      ),
                    ),
                    Text(
                      productDescription,
                      style: TextStyle(
                        fontSize: 10,
                        color: subtxtColor,
                        fontFamily: 'Gotham',
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'S/ 20,00',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gotham',
                            color: txtColor,
                          ),
                        ),
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF919191),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                ),
                                iconSize: 15,
                                onPressed: () {
                                  // Agrega lógica para disminuir la cantidad
                                },
                              ),
                              Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Gotham',
                                  color: txtColor,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                iconSize: 15,
                                onPressed: () {
                                  // Agrega lógica para aumentar la cantidad
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
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
}