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
import 'package:wayllu_project/src/domain/models/products_info/product_info_model.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/products_list_cubit.dart';
import 'package:wayllu_project/src/presentation/cubit/users_list_cubit.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';
import 'package:wayllu_project/src/utils/firebase/firebase_helper.dart';

@RoutePage()
class EditProductsScreen extends HookWidget {
  final List<String> categoriasOptions = [
    'ACCESORIOS',
    'BOLSOS Y MONEDEROS',
    'Otra',
    'TEXTILES PARA EL HOGAR',
  ];

  final List<Map<String, String>> codFamiliasOptions = [
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

  final ImagePicker imagePicker = ImagePicker();
  final appRouter = getIt<AppRouter>();

  final ProductInfo productInfo;

  EditProductsScreen({required this.productInfo});

  Future<void> updateProduct(
    Map<String, dynamic> productInfoToSend,
    BuildContext context,
  ) async {
    final productsCubit = context.read<ProductListCubit>();
    await productsCubit.updateProduct(productInfoToSend);
    await productsCubit.getProductsLists();
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> profileImage = useState(productInfo.IMAGEN!);
    final ValueNotifier<File?> newProfileImage = useState(null);

    final ubicacionController =
        useTextEditingController(text: productInfo.UBICACION);
    final pesoController =
        useTextEditingController(text: productInfo.PESO.toString());
    final altoController =
        useTextEditingController(text: productInfo.ALTO.toString());
    final anchoController =
        useTextEditingController(text: productInfo.ANCHO.toString());
    
    final artesanoController = useTextEditingController(text: '');

    final tipoPesoController = useState<String>(productInfo.TIPO_PESO);
    final categoria = useState<String>(productInfo.CATEGORIA);
    final codFamilia = useState<String>(
      codFamiliasOptions.firstWhere((familias) =>
          familias['codigo'] == productInfo.COD_FAMILIA.toString())['valor']!,
    );

    final codigoArtesano =
        useState<String>(productInfo.COD_ARTESANA.toString());

    Future<String?> selectImage() async {
      final XFile? image =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        newProfileImage.value = File(image.path);
        return '';
      }

      return null;
    }

    return Scaffold(
      backgroundColor: bgPrimary,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            appRouter.navigate(HomeRoute(viewIndex: 0));
          },
          child: const Icon(Ionicons.arrow_back),
        ),
        backgroundColor: bgPrimary,
        surfaceTintColor: Colors.transparent,
        title: _buildTextHeader(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 8,
            ),
            photoUser(
              context,
              newProfileImage,
              profileImage,
              selectImage,
            ),
            const SizedBox(
              height: 8,
            ),
            containerTextForm(
              context,
              'Ubicacion',
              'Ingrese ubicacion',
              ubicacionController,
            ),
            Wrap(
              spacing: 16, // Spacing between elements
              runSpacing: 16, // Spacing between rows
              children: [
                DropDownMenuArtesanos(
                  menuController: artesanoController,
                  selectedOption: codigoArtesano,
                ),
                DropDownOptions<String>(
                  optionHead: 'Categoria',
                  options: categoriasOptions,
                  selectedOption: categoria,
                ),
                DropDownOptions<dynamic>(
                  optionHead: 'Codigo de Familia',
                  options:
                      codFamiliasOptions.map((map) => map['valor']).toList(),
                  selectedOption: codFamilia,
                ),
              ],
            ),
            wrappedContainerTextForm(
              context,
              pesoController,
              tipoPesoController,
              altoController,
              anchoController,
            ),
            btnRegistro(
              context,
              productInfo.id,
              ubicacionController,
              pesoController,
              tipoPesoController,
              altoController,
              anchoController,
              categoria,
              codFamilia,
              codigoArtesano,
              newProfileImage.value,
            ),
          ],
        ),
      ),
    );
  }

  TextButton btnRegistro(
    BuildContext context,
    String id,
    TextEditingController ubicacionController,
    TextEditingController pesoController,
    ValueNotifier tipoPesoController,
    TextEditingController altoController,
    TextEditingController anchoController,
    ValueNotifier<String> categoria,
    ValueNotifier<String> codFamilia,
    ValueNotifier<String?> codArtesano,
    File? image,
  ) {
    return TextButton(
      onPressed: () async {
        final String? imageUrl = image != null
            ? await uploadImageToFirebase(image, folder: 'Products_images')
            : null;

        final selectedCodFamilia = codFamiliasOptions.firstWhere(
          (element) => element['valor'] == codFamilia.value,
        )['codigo'];

        final productInfoJson = {
          'id': id,
          'UBICACION': ubicacionController.text,
          'ARTESANO': codArtesano.value,
          'PESO': pesoController.text,
          'TIPO_PESO': tipoPesoController.value,
          'ALTO': altoController.text,
          'ANCHO': anchoController.text,
          'CATEGORIA': categoria.value,
          'COD_FAMILIA': selectedCodFamilia,
        };

        final productInfo = ProductInfo.convertoToBodyRequest(productInfoJson);

        if (imageUrl != null) productInfo['IMAGEN'] = imageUrl;
        await showLoadingDialog(context, productInfo: productInfo);
        showSuccesDialog(context);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 4, bottom: 60),
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
            'Actualizar',
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
    TextEditingController controller,
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
                  height: 0,
                ),
              ),
            ),
          ),
        ],
      ),
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

  Column photoUser(
    BuildContext context,
    ValueNotifier<File?> newProfileImage,
    ValueNotifier<String> profileImage,
    Future<String?> Function() selectImage,
  ) {
    return Column(
      children: [
        InkWell(
          onTap: selectImage,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.grey,
            backgroundImage: newProfileImage.value != null
                ? FileImage(newProfileImage.value!) as ImageProvider<Object>
                : NetworkImage(profileImage.value) as ImageProvider<Object>,
            child: const Icon(
              Ionicons.camera,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Text _buildTextHeader() {
    return const Text(
      'Actualizar Producto',
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontFamily: 'Gotham',
        fontWeight: FontWeight.w500,
        height: 0,
      ),
    );
  }

  Future<void> showLoadingDialog(
    BuildContext context, {
    String text = 'Cargando...',
    required Map<String, dynamic> productInfo,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // completer.complete(context);
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: HexColor('#B80000'),
              ),
              const SizedBox(height: 20),
              Text(text),
            ],
          ),
        );
      },
    );

    await updateProduct(productInfo, context);
    appRouter.popForced();
  }

  Future<void> showSuccesDialog(
    BuildContext context, {
    String text = 'Datos actualizados!',
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // completer.complete(context);
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: HexColor('#B80000'),
              ),
              const SizedBox(height: 20),
              Text(text),
            ],
          ),
        );
      },
    );

    Timer(const Duration(seconds: 2), () {
      appRouter.popForced();
    });
  }

  void showWarningDialog(
    BuildContext context, {
    String text = 'Ingresa todos los datos...',
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // completer.complete(context);
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning,
                color: HexColor('#B80000'),
                size: 32,
              ),
              const SizedBox(height: 20),
              Text(text),
            ],
          ),
        );
      },
    );
  }
}

class DropDownMenuArtesanos extends HookWidget {
  final TextEditingController? menuController;
  final ValueNotifier<String> selectedOption;

  const DropDownMenuArtesanos({
    required this.menuController,
    required this.selectedOption,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 45.0;
    final usersListCubit = context.watch<UsersListCubit>();
    final usersListCubitRead = context.read<UsersListCubit>();
    final queryNombre = useState(selectedOption.value);

    void changeQuery(String query) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        queryNombre.value = query;
      });
    }

    void closeKeyboard(BuildContext context) {
      FocusScope.of(context).unfocus();
    }

    useEffect(
      () {
        usersListCubitRead
            .getUniqueUser({'CODIGO': int.parse(selectedOption.value)});

        return () {
          usersListCubitRead
              .getUniqueUser({'CODIGO': int.parse(selectedOption.value)});
        };
      },
      [],
    );

    // Add a post-frame callback to ensure the build is complete before handling state changes
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          queryNombre.addListener(() {
            if (queryNombre.value != selectedOption.value) {
              usersListCubitRead.getUserLists(
                nombre: queryNombre.value,
                cantidad: 5,
              );
            }
          });
        });

        // Cleanup the listener on dispose
        return () {};
      },
      [],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Artesano',
          style: TextStyle(
            color: Color(0xFF241E20),
            fontSize: 16,
            fontFamily: 'Gotham',
            fontWeight: FontWeight.w500,
            height: 1.5, // Adjust height as needed
          ),
        ),
        DropdownMenu(
          hintText: 'Asignar artesano',
          controller: menuController,
          initialSelection:
              usersListCubit.state!.isNotEmpty ? selectedOption.value : null,
          trailingIcon: const Icon(Ionicons.chevron_down),
          width: width,
          requestFocusOnTap: true,
          enableFilter: true,
          menuStyle: MenuStyle(
            side: MaterialStateProperty.all<BorderSide>(
              const BorderSide(
                color: Colors.transparent,
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onSelected: (dynamic selected) {
            selectedOption.value = selected as String;
            closeKeyboard(context);
          },
          searchCallback: (entries, query) {
            if (query.isEmpty) {
              return null;
            }

            changeQuery(query);

            final int index = entries.indexWhere(
              (DropdownMenuEntry entry) => entry.label == query,
            );
            return index != -1 ? index : null;
          },
          dropdownMenuEntries: usersListCubit.state != null
              ? usersListCubit.state!.map<DropdownMenuEntry>((value) {
                  return DropdownMenuEntry(
                    value: value.codigoArtesano.toString(),
                    label: value.nombre,
                    labelWidget: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(value.url),
                      ),
                      title: Text(value.nombre),
                    ),
                  );
                }).toList()
              : [],
        ),
      ],
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
