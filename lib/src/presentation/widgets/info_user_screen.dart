// ignore_for_file: unnecessary_string_interpolations, use_build_context_synchronously

import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/domain/models/user_info/user_info_model.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/user_logged_cubit.dart';
import 'package:wayllu_project/src/presentation/views/admin/register_products.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/presentation/widgets/top_vector.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';
import 'package:wayllu_project/src/utils/firebase/firebase_helper.dart';

@RoutePage()
class InfoUserScreen extends HookWidget {
  final bool isAdmin;
  final int viewIndex;
  final UserInfo? user;

  final appRouter = getIt<AppRouter>();
  final ImagePicker imagePicker = ImagePicker();

  Future<void> _updateInfo(
    Map<String, dynamic> dataToUpdate,
    BuildContext context,
  ) async {
    final userLoggedInfo = context.read<UserLoggedInfoCubit>();
    await userLoggedInfo.updateUserInfo(dataToUpdate);
  }

  InfoUserScreen({
    required this.viewIndex,
    this.user,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomNavBar(
        viewSelected: viewIndex,
      ),
      backgroundColor: bgPrimary,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 48.0,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: TopVector(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                if (user != null)
                  Wrap(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BuildAvatar(user!.URL_IMAGE),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          _buildInfoContainer(
                            'Informacion Personal',
                            user!.userInfo,
                            isAdmin,
                            context,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          _buildInfoContainer(
                            'Informacion de Contacto',
                            user!.userContactInfo,
                            isAdmin,
                            context,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          // if (isAdmin)
                          //   _buildInhabilitButton(context)
                          // else
                          //   Container(),
                        ],
                      ),
                    ],
                  )
                else
                  BlocBuilder<UserLoggedInfoCubit, UserInfo?>(
                    builder: (context, loggeUser) {
                      if (loggeUser == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return Wrap(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BuildAvatar(loggeUser.URL_IMAGE),
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              _buildInfoContainer(
                                'Informacion Personal',
                                loggeUser.userInfo,
                                isAdmin,
                                context,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              _buildInfoContainer(
                                'Informacion de Contacto',
                                loggeUser.userContactInfo,
                                isAdmin,
                                context,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CustomButton(
                                colorOne: '#800080',
                                colorTwo: '#C3C3DD',
                                text: 'Cerrar Sesión',
                                onTap: () {
                                  unregisterDependenciesAndEnpoints();
                                  appRouter.navigateNamed('login');
                                },
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInhabilitButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20.0),
          backgroundColor: mainColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        child: Text(
          'Deshabilitar',
          style: TextStyle(
            color: bgPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoContainer(
    String container,
    InfoBase data,
    bool isAdmin,
    BuildContext context,
  ) {
    final BoxShadow boxShadow = BoxShadow(
      color: Colors.grey.withOpacity(0.5), // Color of the shadow
      spreadRadius: 1, // Spread radius of the shadow
      blurRadius: 7, // Blur radius of the shadow
      offset: const Offset(0, 3), // Offset of the shadow
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: bgContainer,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            boxShadow,
          ],
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                container,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildGrid(data.entries, isAdmin, context),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(List<List> data, bool isAdmin, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => _buildGridRow(
          data[index],
          isAdmin,
          context,
        ),
        separatorBuilder: (c, i) => const Divider(),
        itemCount: data.length,
      ),
    );
  }

  Widget _buildGridRow(List entry, bool isAdmin, BuildContext context) {
    if (entry[0] == 'Clave' && !isAdmin) {
      return Container();
    }

    if (entry[0] == 'Clave') {
      return StatefulBuilder(
        builder: (context, setState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: Text(
                  'Cambiar Clave',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
              ),
              Flexible(
                child: _buildGridRowEditButton(
                  context,
                  entry[0].toString(),
                  '',
                  fieldHint: 'Nueva Clave',
                ),
              ),
            ],
          );
        },
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          entry[0].toString(),
          style: const TextStyle(fontWeight: FontWeight.w300),
        ),
        Row(
          children: [
            Text(
              entry[1] == null ? 'Sin Definir' : entry[1].toString(),
            ),
            const Gap(5),
            if (entry[2] as bool)
              _buildGridRowEditButton(
                context,
                entry[0].toString(),
                entry[1].toString(),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildGridRowEditButton(
    BuildContext context,
    String field,
    String actualValue, {
    String fieldHint = '',
  }) {
    const double size = 30;
    final TextEditingController textEditingController =
        TextEditingController(text: actualValue);

    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return _updateDialog(
              textEditingController,
              field,
              context,
              hint: fieldHint,
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: bgPrimary, width: 5),
          borderRadius: const BorderRadius.all(Radius.circular(40)),
        ),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: const Icon(
            Ionicons.pencil,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _updateDialog(
    TextEditingController textController,
    String field,
    BuildContext context, {
    String hint = '',
  }) {
    return AlertDialog(
      title: Text(
        'Modificar $field',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(hintText: hint),
              controller: textController,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(secondaryColor),
              ),
              onPressed: () async {
                await _updateInfo(
                  {
                    '${field.toUpperCase()}': textController.text,
                  },
                  context,
                );
                Navigator.pop(context);
              },
              child: const Text(
                'Modificar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildAvatar extends HookWidget {
  final ImagePicker imagePicker = ImagePicker();
  final String? urlImage;

  Future<void> _updateInfo(
    Map<String, dynamic> dataToUpdate,
    BuildContext context,
  ) async {
    final userLoggedInfo = context.read<UserLoggedInfoCubit>();
    await userLoggedInfo.updateUserInfo(dataToUpdate);
  }

  BuildAvatar(this.urlImage);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<File?> profileImage = useState(null);
    final loading = useState(false);

    Future selectImage() async {
      final XFile? image =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        loading.value = true;
        final String imageUrl = await uploadImageToFirebase(File(image.path));
        await _updateInfo(
          {
            'URL_IMAGE': imageUrl,
          },
          context,
        );
        loading.value = false;
        profileImage.value = File(image.path);
      }
    }

    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        CircleAvatar(
          radius: 80.0,
          backgroundImage:
              (profileImage.value != null || urlImage != null) && !loading.value
                  ? profileImage.value != null
                      ? FileImage(profileImage.value!) as ImageProvider
                      : NetworkImage(urlImage!)
                  : null,
          backgroundColor: Colors.grey,
          child: (profileImage.value != null || urlImage != null)
              ? loading.value
                  ? const CircularProgressIndicator()
                  : null
              : const Icon(
                  Ionicons.person,
                  size: 60,
                  color: Colors.white,
                ),
        ),
        InkWell(
          onTap: selectImage,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: bgPrimary, width: 5),
              borderRadius: const BorderRadius.all(Radius.circular(40)),
            ),
            child: CircleAvatar(
              backgroundColor: secondaryColor,
              child: const Icon(
                Ionicons.pencil,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
