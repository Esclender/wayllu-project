import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/presentation/widgets/gradient_widgets.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

@RoutePage()
class CarritoScreen extends HookWidget {
  final double checkoutBtnHeight = 150.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPrimary,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            AutoRouter.of(context).pop();
          },
          child: const Icon(Ionicons.arrow_back),
        ),
        backgroundColor: bgPrimary,
        title: _buildTextHeader(),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: checkoutBtnHeight + 10,
            ),
            child: ListView.separated(
              separatorBuilder: (_, __) => const Gap(25),
              itemCount: 10,
              itemBuilder: (_, ind) => _buildProduct(
                productName: 'Producto',
                productDescription: 'Descripcion',
              ),
            ),
          ),
          _buildConfirmCheckoutBtn(),
        ],
      ),
    );
  }

  Widget _buildTextHeader() {
    return GradientText(
      text: 'Registrar venta',
      fontSize: 25.0,
    );
  }

  Widget _buildProduct({
    required String productName,
    required String productDescription,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 110,
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
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Gotham',
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      iconSize: 18,
                      onPressed: () {
                        // Add logic to remove item from cart
                      },
                    ),
                  ],
                ),
              ),
              Text(
                productDescription,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontFamily: 'Gotham',
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'S/ 20,00',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gotham',
                      color: Colors.black,
                    ),
                  ),
                  _buildQuantityControl(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityControl() {
    return Container(
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
              // Add logic to decrease quantity
            },
          ),
          const Text(
            '1',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Gotham',
              color: Colors.black,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            iconSize: 15,
            onPressed: () {
              // Add logic to increase quantity
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmCheckoutBtn() {
    return Container(
      height: checkoutBtnHeight,
      color: bgContainer,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Gotham',
                  fontWeight: FontWeight.bold,
                  color: txtColor,
                ),
              ),
              Text(
                'S/ 100.00',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Gotham',
                  fontWeight: FontWeight.bold,
                  color: txtColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                'N° productos agregados',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Gotham',
                  color: subtxtColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Agrega aquí la lógica para registrar la venta
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: thirdColor,
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ), // Ajusta el radio de borde según tu preferencia
              ),
            ),
            child: Text(
              'Registrar Venta',
              style: TextStyle(
                fontFamily: 'Gotham',
                fontSize: 16,
                color: bgContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
