// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/domain/dtos/registerProductDto/product_rep.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/product_register_cubit.dart';
import 'package:wayllu_project/src/presentation/views/admin/usersScreens/register_screen.dart';
import 'package:wayllu_project/src/presentation/views/home_screen.dart';
import 'package:wayllu_project/src/presentation/widgets/gradient_widgets.dart';
import 'package:wayllu_project/src/presentation/widgets/register_user/my_text_label.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';
import 'package:wayllu_project/src/utils/firebase/firebase_helper.dart';


@RoutePage()
class RegisterProductsScreen extends HookWidget {
  RegisterProductsScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> codFamiliasOptions = const [
    {'codigo': '1', 'valor': '1 (BOLSA ASA CUERO)'},
    {'codigo': '2', 'valor': '2 (BOLSA ASA TELA)'},
    {'codigo': '3', 'valor': '3 (BOLSO ASA CUERO)'},
    {'codigo': '4', 'valor': '4 (BOLSO ASA TELA)'},
    {'codigo': '5', 'valor': '5 (BOLSO ASA TELA)'},
    {'codigo': '6', 'valor': '6 (CAMINO DE MESA - PIE DE CAMA)'},
    {'codigo': '7', 'valor': '7 (CAMINO MESA LATERAL)'},
    {'codigo': '8', 'valor': '8 (COJIN)'},
    {'codigo': '9', 'valor': '9 (CORREA)'},
    {'codigo': '10', 'valor': '10 (INDIVIDUAL)'},
    {'codigo': '11', 'valor': '11 (LLAVERO TIRA)'},
    {'codigo': '12', 'valor': '12 (MONEDERO CHICO)'},
    {'codigo': '13', 'valor': '13 (MONEDERO GRANDE)'},
    {'codigo': '14', 'valor': '14 (PORTA CELULARES)'},
    {'codigo': '15', 'valor': '15 (PORTA LAPTOP)'},
    {'codigo': '16', 'valor': '16 (POSAVASOS)'},
  ];

  final List<String> categoriasOptions = const [
    'ACCESORIOS',
    'BOLSOS Y MONEDEROS',
    'TEXTILES PARA EL HOGAR',
  ];



  final appRouter = getIt<AppRouter>();
  void _showAlertDialog(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning,
                color: HexColor('#B80000'),
              ),
              const SizedBox(height: 20),
              Text(message),
            ],
          ),
        );
      },
    );
  }

  void _showLoadingDialog(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: HexColor('#B80000'),
              ),
              const SizedBox(height: 20),
              Text(message),
            ],
          ),
        );
      },
    );
  }

  Future<void> _submit(
      BuildContext context,
      String? ancho,
      String? alto,
      String? tipoPeso,
      String? peso,
      String? selectedCategoria,
      String? descripcion,
      Map<String, String>? selectedCodFamilia,
      String? selectedArtesano,
      String? ubicacion,
      String? cantidad,
      String? urlImage) async {
    if (ancho == null ||
        alto == null ||
        tipoPeso == null ||
        peso == null ||
        selectedCategoria == null ||
        descripcion == null ||
        selectedCodFamilia == null ||
        selectedArtesano == null ||
        ubicacion == null ||
        cantidad == null) {
      _showAlertDialog(context, 'Please fill all required fields');
      return;
    }

    _showLoadingDialog(context, 'Submitting...');
    appRouter.popForced();

    const String defaultImageUrl =
        'gs://wayllu.appspot.com/Product_Images/default.jpg';
    final String finalImageUrl = urlImage ?? defaultImageUrl;

    final producto = ProductDto(
      ANCHO: int.parse(ancho),
      ALTO: int.parse(alto),
      TIPO_PESO: tipoPeso,
      PESO: int.parse(peso),
      CATEGORIA: selectedCategoria,
      IMAGEN: finalImageUrl,
      DESCRIPCION: descripcion,
      COD_FAMILIA: int.parse(selectedCodFamilia['codigo']!),
      COD_ARTESANA: int.parse(selectedArtesano),
      COD_PRODUCTO: '',
      UBICACION: ubicacion,
      CANTIDAD: int.parse(cantidad),
    );

    try {
      await context.read<ProductRegisterCubit>().registerNewProduct(producto);
      _showLoadingDialog(context, 'Product registered..');
      Timer(const Duration(seconds: 2), () {
        appRouter.popForced();
        //appRouter.replaceAll([HomeScreen(viewIndex: 0)]);
      });
    } catch (error) {
      _showAlertDialog(context, 'Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<File?> productImage = useState(null);
    final anchoController = useTextEditingController();
    final altoController = useTextEditingController();
    final tipoPesoController = useState<String>('gramos');
    ;
    final pesoController = useTextEditingController();
    final descripcionController = useTextEditingController();
    final ubicacionController = useTextEditingController();
    final cantidadController = useTextEditingController();
    final selectedCategoria = useState<String?>(null);
    final selectedCodFamilia = useState<Map<String, String>?>(null);
    final selectedArtesano = useTextEditingController();

    final selectedImage = useState<File?>(null);
    final urlImage = useState<String?>(null);
    final formKey = GlobalKey<FormState>();


     final ImagePicker imagePicker = ImagePicker();

  Future<String?> selectImage() async {
  final XFile? image =
      await imagePicker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    productImage.value = File(image.path);
    return '';
  }

  return null;
}

    return Scaffold(
      backgroundColor: bgPrimary,
      appBar: AppBar(
        backgroundColor: bgPrimary,
        surfaceTintColor: Colors.transparent,
        leading: InkWell(
          onTap: () => {
            appRouter.navigate(HomeRoute(viewIndex: 0))
          },
          child: const Icon(Ionicons.arrow_back),
        ),
        title: GradientText(
          text: 'Registro de Producto',
          fontSize: 25.0,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            photoUser(
              context,
              productImage,
              selectImage,
            ),
            wrappedContainerTextForm(
              context,
              pesoController,
              tipoPesoController,
              altoController,
              anchoController,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyTextLabel(hintText: 'Descripción'),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: descripcionController,
                    onChanged: (text) {},
                    onSaved: (val) {
                      // nothing here, handled by useState
                    },
                    hintText: 'Descripción',
                    obscureText: false,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyTextLabel(hintText: 'Código de Artesana'),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: selectedArtesano,
                    onChanged: (text) {},
                    onSaved: (val) {
                      // nothing here, handled by useState
                    },
                    hintText: 'Código de artesana',
                    obscureText: false,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyTextLabel(hintText: 'Ubicación'),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: ubicacionController,
                    onChanged: (text) {},
                    onSaved: (val) {
                      // nothing here, handled by useState
                    },
                    hintText: 'Ubicación',
                    obscureText: false,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyTextLabel(hintText: 'Cantidad'),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: cantidadController,
                    onChanged: (text) {},
                    onSaved: (val) {},
                    hintText: 'Cantidad',
                    obscureText: false,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyTextLabel(hintText: 'Categoría'),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedCategoria.value,
                    onChanged: (String? newValue) {
                      selectedCategoria.value = newValue;
                    },
                    items: categoriasOptions
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      hintText: 'Seleccione una categoría',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyTextLabel(hintText: 'Código de Familia'),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<Map<String, String>>(
                    value: selectedCodFamilia.value,
                    onChanged: (Map<String, String>? newValue) {
                      selectedCodFamilia.value = newValue;
                    },
                    items: codFamiliasOptions
                        .map<DropdownMenuItem<Map<String, String>>>(
                            (Map<String, String> value) {
                      return DropdownMenuItem<Map<String, String>>(
                        value: value,
                        child: Text(value['valor']!),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      hintText: 'Seleccione un código de familia',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              colorOne: '#800080',
              colorTwo: '#C3C3DD',
              text: 'Registrar',
              onTap: () {
                formKey.currentState?.save();
                _submit(
                  context,
                  anchoController.text,
                  altoController.text,
                  tipoPesoController.value,
                  pesoController.text,
                  selectedCategoria.value,
                  descripcionController.text,
                  selectedCodFamilia.value,
                  selectedArtesano.text,
                  ubicacionController.text,
                  cantidadController.text,
                  urlImage.value,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String title,
    String? description,
    TextEditingController? controller, {
    bool isCombo = false,
    ValueNotifier? valueNotifier,
  }) {
    if (isCombo) {
      return SizedBox(
        width: (MediaQuery.of(context).size.width * 0.85) / 2 - 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF241E20),
                fontSize: 16,
                fontFamily: 'Gotham',
                fontWeight: FontWeight.w500,
                height: 1.5, // Adjust height as needed
              ),
            ),
            const SizedBox(height: 6),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(
                      0xFFCCCCCC), // Replace bottomNavBarStroke with a color
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                isExpanded: true,
                value: valueNotifier!.value,
                hint: const Text('Tipo de peso'),
                icon: const Icon(Ionicons.chevron_down),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                onChanged: (newValue) {
                  if (newValue != null) {
                    valueNotifier.value = newValue;
                  }
                },
                items: ['gramos'].map<DropdownMenuItem>((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox(
      width: (MediaQuery.of(context).size.width * 0.85) / 2 - 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF241E20),
              fontSize: 16,
              fontFamily: 'Gotham',
              fontWeight: FontWeight.w500,
              height: 1.5, // Adjust height as needed
            ),
          ),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(
                  0xFFCCCCCC,
                ), // Replace bottomNavBarStroke with a color
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: controller,
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
                  height: 1.5, // Adjust height as needed
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function(String?) onSaved;
  final String hintText;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.onSaved,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      onSaved: onSaved,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      obscureText: obscureText,
    );
  }
}

class DropDownOptions<T> extends HookWidget {
  final String optionHead;
  final List<T> options;
  final ValueNotifier<T> selectedOption;

  DropDownOptions({
    required this.optionHead,
    required this.options,
    required this.selectedOption,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          optionHead,
          style: const TextStyle(
            color: Color(0xFF241E20),
            fontSize: 16,
            fontFamily: 'Gotham',
            fontWeight: FontWeight.w500,
            height: 1.5, // Adjust height as needed
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                style: BorderStyle.solid,
                color: bottomNavBarStroke,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: DropdownButton<T>(
            isExpanded: true,
            value: selectedOption.value,
            hint: Text(optionHead),
            icon: const Icon(Ionicons.chevron_down),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.transparent,
            ),
            onChanged: (T? newValue) {
              if (newValue != null) {
                selectedOption.value = newValue;
              }
            },
            items: options.map<DropdownMenuItem<T>>((T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

Widget _buildTextField(
  BuildContext context,
  String title,
  String? description,
  TextEditingController? controller, {
  bool isCombo = false,
  ValueNotifier? valueNotifier,
}) {
  if (isCombo) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width * 0.85) / 2 - 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF241E20),
              fontSize: 16,
              fontFamily: 'Gotham',
              fontWeight: FontWeight.w500,
              height: 1.5, // Adjust height as needed
            ),
          ),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(
                  0xFFCCCCCC,
                ), // Replace bottomNavBarStroke with a color
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              isExpanded: true,
              value: valueNotifier!.value,
              hint: const Text('Tipo de peso'),
              icon: const Icon(Ionicons.chevron_down),
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.transparent,
              ),
              onChanged: (newValue) {
                if (newValue != null) {
                  valueNotifier.value = newValue;
                }
              },
              items: ['gramos'].map<DropdownMenuItem>((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  return SizedBox(
    width: (MediaQuery.of(context).size.width * 0.85) / 2 - 8,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF241E20),
            fontSize: 16,
            fontFamily: 'Gotham',
            fontWeight: FontWeight.w500,
            height: 1.5, // Adjust height as needed
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  Color(0xFFCCCCCC), // Replace bottomNavBarStroke with a color
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
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
                height: 1.5, // Adjust height as needed
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Column photoUser(
  BuildContext context,
  ValueNotifier<File?> productImage,
  Future<String?> Function() selectImage,
) {
  return Column(
    children: [
      InkWell(
        onTap: selectImage,
        child: CircleAvatar(
          radius: 70,
          backgroundColor: Colors.grey,
          backgroundImage: productImage.value != null
              ? FileImage(productImage.value!)
              : null,
          child: productImage.value == null
              ? const Icon(Ionicons.camera_outline, color: Colors.white)
              : null,
        ),
      ),
    ],
  );
}

SizedBox wrappedContainerTextForm(
  BuildContext context,
  TextEditingController pesoController,
  ValueNotifier<String> tipoPesoController,
  TextEditingController altoController,
  TextEditingController anchoController,
) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.85,
    height:
        MediaQuery.of(context).size.height * 0.24, // Adjust height as needed
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Wrap(
          spacing: 16, // Spacing between elements
          runSpacing: 16, // Spacing between rows
          children: [
            _buildTextField(
              context,
              'Peso',
              'Ingresa el Peso',
              pesoController,
            ),
            _buildTextField(
              context,
              'Tipo de peso',
              null,
              null,
              isCombo: true,
              valueNotifier: tipoPesoController,
            ),
            _buildTextField(
              context,
              'Alto',
              'Alto del producto',
              altoController,
            ),
            _buildTextField(
              context,
              'Ancho',
              'Ancho del producto',
              anchoController,
            ),
          ],
        ),
      ],
    ),
  );
}

class CustomButton extends StatelessWidget {
  final String colorOne;
  final String colorTwo;
  final String text;
  final VoidCallback onTap;

  const CustomButton({
    required this.colorOne,
    required this.colorTwo,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [btnprimary, btnsecondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
