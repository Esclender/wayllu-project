import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/presentation/widgets/top_navbar.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

class HomeScreen extends HookWidget {
  const HomeScreen(Key? key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPrimary,
      body: ListView(
        children: [
          TopAppVar(),
Container(
  width: 360,
  padding: EdgeInsets.all(5),
  child: Column(
    children: [
      for(int i=1; i<4; i++)
      Container(
  padding: EdgeInsets.only(bottom: 25),
  child: Column(
    children: [
      Row(
        children: [
          Container(
            width: 110,
            margin: EdgeInsets.only(left: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect( // Agregado ClipRRect para recortar la imagen según el borde del contenedor
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "../../../assets/images/img1.jpg",
                width: 100,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Producto Title",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: txtColor,
                          fontFamily: 'Gotham',
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        iconSize: 18,
                        onPressed: () {
                          // Puedes agregar lógica para eliminar este ítem del carrito aquí
                        },
                      ),
                    ],
                  ),
                ),
                Text(
                  "Descripción del producto",
                  style: TextStyle(
                    fontSize: 10,
                    color: subtxtColor,
                    fontFamily: 'Gotham',
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "S/ 20,00",
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
                        border: Border.all(color: Color(0xFF919191)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
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
                            icon: Icon(Icons.add),
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
)
],
  ),
)

      ],
      ),
      bottomNavigationBar: BottomNavBar(
        key: key,
      ),
    );
  }
}
