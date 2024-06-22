import 'dart:async';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:logger/logger.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/domain/enums/lists_enums.dart';
import 'package:wayllu_project/src/domain/enums/user_roles.dart';
import 'package:wayllu_project/src/domain/models/models_products.dart';
import 'package:wayllu_project/src/domain/models/products_info/product_info_model.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/productos_carrito_cubit.dart';
import 'package:wayllu_project/src/presentation/cubit/products_list_cubit.dart';
import 'package:wayllu_project/src/presentation/cubit/user_logged_cubit.dart';
import 'package:wayllu_project/src/presentation/widgets/bar_search.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/presentation/widgets/list_products.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';
import 'package:wayllu_project/src/utils/extensions/scroll_controller_extension.dart';

@RoutePage()
class HomeScreen extends HookWidget {
  final int viewIndex;
  HomeScreen({
    required this.viewIndex,
  });

  final appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final productsListCubit = context.watch<ProductListCubit>();
    final loggedUserRol = context.read<UserLoggedCubit>().state;
    final userInfo = context.watch<UserLoggedInfoCubit>().state;
    final scrollController = useScrollController();
    final isSearchingProducts = useState(false);
    final isSearchingByCode = useState('');
    final pagina = useState(1);

    final DateTime now = DateTime.now();
    final int hour = now.hour;
    final String greeting = getGreeting(hour);

    Future<void> searchProductByCode(c, String code) async {
      isSearchingByCode.value = code;
      await productsListCubit.getProductsListsByCode(code);
    }

    final List<ProductInfo> data = [];
    useEffect(
      () {
        productsListCubit.getProductsLists();
        scrollController.onScrollEndsListener(
          () {
            Logger().i(isSearchingByCode.value);
            if (isSearchingByCode.value == '') {
              isSearchingProducts.value = true;
              productsListCubit.getProductsLists(pagina: pagina.value++);

              Timer(const Duration(seconds: 3), () {
                isSearchingProducts.value = false;
              });
            }
          },
        );
        return scrollController.dispose;
      },
      [],
    );

    final categoriaSeleccionada = useState<String?>(null);
    return Scaffold(
      backgroundColor: bgPrimary,
      body: Stack(
        children: [
          CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                leading: Container(),
                expandedHeight: 68.0,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  background: topVector(context),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(20),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 22),
                    child: userInfo != null
                        ? Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: 45,
                                  height: 45,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      userInfo.URL_IMAGE ??
                                          'https://firebasestorage.googleapis.com/v0/b/wayllu.appspot.com/o/Artisans_Images%2Fimg1.jpeg?alt=media',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      '$greeting${userInfo.NOMBRE_COMPLETO}',
                                      style: const TextStyle(
                                        fontFamily: 'Gotham',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        height: 1,
                                        color: Color(0xff313131),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : _buildShimmerinEfect(),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(
                      height: 8,
                    ),
                    firstLine(context, loggedUserRol),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 6,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (loggedUserRol == UserRoles.admin)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                optionsAndLogout(context),
                                const Gap(10),
                                Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: bottomNavBar,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [simpleShadow],
                                      ),
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                            ),
                                            child: Icon(Ionicons.search),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                (0.62),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.06,
                                            child: TextField(
                                              controller: searchController,
                                              onChanged: (q) {
                                                searchProductByCode(context, q);
                                              },
                                              decoration: InputDecoration(
                                                fillColor: bottomNavBar,
                                                border: InputBorder.none,
                                                hintText: 'Buscar por codigo',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          else
                            Container(),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: loggedUserRol == UserRoles.admin
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: categories.map((category) {
                                return categoriesProducts(
                                  context,
                                  category.name,
                                  category.image,
                                  (selectedCategory) {
                                    if (loggedUserRol == UserRoles.admin &&
                                        selectedCategory ==
                                            categoriaSeleccionada.value) {
                                      categoriaSeleccionada.value = null;
                                    } else {
                                      categoriaSeleccionada.value =
                                          selectedCategory;
                                    }
                                  },
                                  category.name.toUpperCase() ==
                                      categoriaSeleccionada
                                          .value, // Verifica si la categoría está seleccionada
                                );
                              }).toList(),
                            )
                          : const SizedBox(),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      alignment: Alignment.centerLeft,
                      child: categoriaSeleccionada.value == null
                          ? const Text(
                              'Todos los productos',
                              style: TextStyle(
                                fontFamily: 'Gotham',
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width * 0.32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: iconColor.withOpacity(0.5),
                                border: Border.all(
                                  color: bottomNavBarStroke,
                                  width: 0.5,
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  categoriaSeleccionada.value = null;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.filter_alt_outlined,
                                        color: bottomNavBar,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 8),
                                      buttonClearFilter(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ),
                    _productsHome(
                      context,
                      data,
                      categoriaSeleccionada.value,
                      scrollController,
                    ),
                    if (isSearchingProducts.value)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 65,
                          top: 10,
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: secondaryColor,
                          ),
                        ),
                      )
                    else
                      const Gap(65),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: loggedUserRol == UserRoles.artesano
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                shoppingCart(context),
                const Gap(8),
                BottomNavBar(
                  viewSelected: viewIndex,
                ),
              ],
            )
          : BottomNavBar(
              viewSelected: viewIndex,
            ),
    );
  }

  Widget _buildShimmerinEfect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const SizedBox(
              width: 45,
              height: 45,
              child: CircleAvatar(
                backgroundColor: Colors.white,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  height: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text buttonClearFilter() {
    return Text(
      'Quitar filtro',
      style: TextStyle(
        color: bottomNavBar,
        fontFamily: 'Gotham',
        fontWeight: FontWeight.w300,
        fontSize: 14,
      ),
    );
  }

  Widget _productsHome(
    BuildContext context,
    List<ProductInfo> data,
    String? categorySeleccionada,
    ScrollController scrollController,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child:
          dataProducts(categorySeleccionada, data, context, scrollController),
    );
  }

  Widget dataProducts(
    String? categorySeleccionada,
    List<ProductInfo> data,
    BuildContext context,
    ScrollController scrollController,
  ) {
    return BlocBuilder<ProductListCubit, List<ProductInfo>?>(
      builder: (context, state) {
        if (state == null) {
          return GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 12,
            itemBuilder: (BuildContext context, int index) {
              return _buildItemContainer(
                context,
              );
            },
          );
        } else if (categorySeleccionada != null) {
          data = state;
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ProductsCardsItemsList(
                context: context,
                listType: ListEnums.products,
                dataToRender: data,
                categoriaSeleccionada: categorySeleccionada,
                scrollController: scrollController,
              );
            },
          );
        } else {
          data = state;

          return ProductsCardsItemsList(
            context: context,
            listType: ListEnums.products,
            dataToRender: data,
            categoriaSeleccionada: categorySeleccionada,
            scrollController: scrollController,
          );
        }
      },
    );
  }

  Widget _buildItemContainer(
    BuildContext context,
  ) {
    return Stack(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.43,
              height: double.infinity,
              decoration: BoxDecoration(
                color: bottomNavBar,
                boxShadow: [
                  simpleShadow,
                ],
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: _buildShimmerEffect(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildShimmerEffect(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.43,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget optionsAndLogout(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(left: 4),
      width: MediaQuery.of(context).size.width * 0.12,
      height: MediaQuery.of(context).size.width * 0.10,
      decoration: BoxDecoration(
        color: bottomNavBar,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 95, 95, 95).withOpacity(0.08),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(
              0,
              1,
            ),
          ),
        ],
      ),
      child: PopupMenuButton<String>(
        color: bottomNavBar.withOpacity(0.9),
        offset: Offset(1, MediaQuery.of(context).size.width * 0.11),
        icon: const Icon(
          Ionicons.menu_outline,
          size: 24,
        ),
        itemBuilder: _buildPopupMenuButtonOptions(),
        onSelected: (value) {},
      ),
    );
  }

  List<PopupMenuEntry<String>> Function(BuildContext)
      _buildPopupMenuButtonOptions() {
    return (context) => [
          PopupMenuItem(
            value: 'Agregar Producto',
            child: InkWell(
              onTap: () {
                appRouter.navigateNamed('admin/registroProducto');
              },
              child: const ListTile(
                leading: Icon(Ionicons.bag_handle_outline),
                title: Text('Agregar Producto'),
              ),
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            value: 'opcion2',
            child: InkWell(
              onTap: () {
                unregisterDependenciesAndEnpoints();
                appRouter.navigateNamed('login');
              },
              child: ListTile(
                leading: Icon(
                  Ionicons.exit_outline,
                  color: mainColor,
                ),
                title: const Text('Cerrar sesión'),
              ),
            ),
          ),
        ];
  }

  Widget shoppingCart(BuildContext context) {
    final productsCubit = context.watch<ProductsCarrito>();

    if (productsCubit.itemsInCartInt == 0) {
      return InkWell(
        onTap: () {
          appRouter.pushNamed('/user/carrito');
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
          ), //bottom: 60
          child: FloatingActionButton(
            backgroundColor: bottomNavBar,
            shape: const CircleBorder(),
            onPressed: () {
              appRouter.pushNamed('/user/carrito');
            },
            child: Icon(
              Ionicons.bag_handle_outline,
              size: 28,
              color: iconColor,
            ),
          ),
        ),
      );
    }

    return BlocBuilder<ProductsCarrito, List>(
      builder: (context, state) {
        return badge.Badge(
          badgeContent: Text(
            state.length.toString(),
            style: const TextStyle(color: Colors.white),
          ),
          position: badge.BadgePosition.topEnd(end: 4),
          child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: FloatingActionButton(
              backgroundColor: bottomNavBar,
              shape: const CircleBorder(),
              onPressed: () {
                appRouter.pushNamed('/user/carrito');
              },
              child: Icon(
                Ionicons.bag_handle_outline,
                size: 28,
                color: iconColor,
              ),
            ),
          ),
        );
      },
    );
  }

  Padding firstLine(BuildContext context, UserRoles rol) {
    // ignore: unrelated_type_equality_checks
    // final bool loggedUserRol = rol == UserRoles.admin;
    // final dateString =
    //     DateFormat("dd 'de' MMMM yyyy", 'es').format(DateTime.now());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: bannerArtesanos(context, true),
    );
  }

  TextButton btnNewReport(
    BuildContext context,
    void Function() onPressed,
  ) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        margin: const EdgeInsets.only(top: 4),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: ShapeDecoration(
          color: secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: const Center(
          child: Text(
            'Nuevo informe',
            style: TextStyle(
              fontFamily: 'Gotham',
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

Container barSearch(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.76,
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    decoration: BoxDecoration(
      color: bottomNavBar,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: const Row(
      children: [
        SizedBox(
          width: 4,
        ),
        Icon(
          Ionicons.search_sharp,
          color: Color(0xff8A8991),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          'Búsqueda',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Gotham',
            fontWeight: FontWeight.w500,
            color: Color(0xff8A8991),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Container categoriesProducts(
  BuildContext context,
  String name,
  String image,
  void Function(String)? onSelectCategory,
  bool isSelected,
) {
  return Container(
    padding: const EdgeInsets.symmetric(
      vertical: 8,
    ),
    child: GestureDetector(
      onTap: () {
        if (onSelectCategory != null) {
          onSelectCategory(name.toUpperCase());
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.only(top: 15, bottom: 8),
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 0.282,
        decoration: BoxDecoration(
          color: bottomNavBar,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: isSelected
              ? Border.all(color: secondary, width: 0.5)
              : Border.all(color: Colors.transparent),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 95, 95, 95)
                  .withOpacity(0.08), // Color de la sombra y su opacidad
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(
                0,
                1,
              ),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                image,
                width: MediaQuery.of(context).size.width * 0.15,
              ),
            ),
            Text(
              name,
              style: const TextStyle(
                fontFamily: 'Gotham',
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}

Container bannerArtesanos(BuildContext context, bool rol) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.17,
    padding: const EdgeInsets.only(top: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: const DecorationImage(
        image: AssetImage(
          'assets/images/banner-artesanos.jpeg',
        ),
        fit: BoxFit.cover,
      ),
    ),
  );
}

Container topVector(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    alignment: Alignment.topCenter,
    child: Image.asset(
      'assets/Vector-Top.png',
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    ),
  );
}

String getGreeting(int hour) {
  if (hour >= 0 && hour < 12) {
    return 'Buenos días, ';
  } else if (hour >= 12 && hour < 18) {
    return 'Buenas tardes, ';
  } else {
    return 'Buenas noches, ';
  }
}
