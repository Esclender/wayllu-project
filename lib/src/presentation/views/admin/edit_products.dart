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
import 'package:wayllu_project/src/domain/models/families_code.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/domain/models/products_info/product_info_model.dart';
import 'package:wayllu_project/src/domain/models/user_info/user_info_model.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/products_list_cubit.dart';
import 'package:wayllu_project/src/presentation/cubit/users_list_cubit.dart';
import 'package:wayllu_project/src/presentation/widgets/forms_components.dart/build_text_field.dart';
import 'package:wayllu_project/src/presentation/widgets/forms_components.dart/container_text_form.dart';
import 'package:wayllu_project/src/presentation/widgets/forms_components.dart/options_categories.dart';
import 'package:wayllu_project/src/presentation/widgets/forms_components.dart/photo_product.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';
import 'package:wayllu_project/src/utils/firebase/firebase_helper.dart';

@RoutePage()
class EditProductsScreen extends HookWidget {
  final ImagePicker imagePicker = ImagePicker();
  final appRouter = getItAppRouter<AppRouter>();

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
    final ValueNotifier<String> productImage = useState(productInfo.IMAGEN!);
    final ValueNotifier<File?> newproductImage = useState(null);

    final ubicacionController =
        useTextEditingController(text: productInfo.UBICACION);
    final precioController =
        useTextEditingController(text: productInfo.PRECIO.toString());
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
      codFamiliasOptions.firstWhere(
        (familias) => familias['codigo'] == productInfo.COD_FAMILIA.toString(),
      )['valor']!,
    );

    final codigoArtesano =
        useState<String>(productInfo.COD_ARTESANA.toString());

    Future<String?> selectImage() async {
      final XFile? image =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        newproductImage.value = File(image.path);
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
            PhotoProduct(
              existingImageUrl: productImage,
              newProductImage: newproductImage,
              selectImage: selectImage,
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
            containerTextForm(
              context,
              'Precio',
              'Actualice el precio',
              precioController,
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
              precioController,
              categoria,
              codFamilia,
              codigoArtesano,
              newproductImage.value,
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
    TextEditingController precioController,
    ValueNotifier<String> categoria,
    ValueNotifier<String> codFamilia,
    ValueNotifier<String?> codArtesano,
    
    File? image,
  ) {
    return TextButton(
      style: const ButtonStyle(
        splashFactory: NoSplash.splashFactory,
      ),
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
          'PRECIO': precioController.text,
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
        if (selectedOption.value.isNotEmpty) {
          usersListCubitRead
              .getUniqueUser({'CODIGO': int.parse(selectedOption.value)});
        }
      },
      [],
    );

    useEffect(
      () {
        queryNombre.addListener(() {
          if (queryNombre.value != selectedOption.value) {
            usersListCubitRead.getUserLists(
              nombre: queryNombre.value,
              cantidad: 5,
            );
          }
        });

        return () {};
      },
      [],
    );

    String artisanName = 'Asignar artesano';
    if (selectedOption.value.isNotEmpty && usersListCubit.state != null) {
      for (var artisan in usersListCubit.state!) {
        if (artisan.codigoArtesano.toString() == selectedOption.value) {
          artisanName = artisan.nombre;
          break;
        }
      }
    }

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
            height: 1.5,
          ),
        ),
        DropdownMenu(
          hintText: artisanName, // Display the artisan's name
          controller: menuController,
          initialSelection: selectedOption.value,
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
