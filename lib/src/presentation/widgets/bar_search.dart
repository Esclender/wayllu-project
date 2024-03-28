import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/domain/enums/lists_enums.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/presentation/widgets/list_generator.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

class CustomSearchWidget extends StatefulWidget {
  final List<CardTemplate> allData;

  const CustomSearchWidget({
    required this.allData,
  });

  @override
  _CustomSearchWidgetState createState() => _CustomSearchWidgetState();
}

class _CustomSearchWidgetState extends State<CustomSearchWidget> {
  late TextEditingController _searchController;
  List<CardTemplate> _filteredData = [];
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredData = widget.allData;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    final List<CardTemplate> filteredList = widget.allData.where((item) {
      final name = item.nombre.toLowerCase();
      return name.contains(query);
    }).toList();

    setState(() {
      _filteredData = filteredList;
// Mostrar solo las primeras 5 sugerencias
    });
   
  }

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: bottomNavBar,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [simpleShadow],),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Ionicons.search),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.82,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      fillColor: bottomNavBar,
                      border: InputBorder.none,
                      hintText: 'Busca por nombre',
                      suffixIcon:  _searchController.text.isNotEmpty
                      ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                              },
                            )
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchController.text.isEmpty) {
      return CardTemplateItemsList(
        listType: ListEnums.users,
        dataToRender: _filteredData,
        isScrollable: false,
      );
    } else if (_filteredData.isEmpty) {
      return const Center(child: Text('No se encontraron resultados'));
    } else {
      return ListView.builder(
        itemCount: _filteredData.length,
        itemBuilder: (context, index) {
          return CardTemplateItemsList(
            listType: ListEnums.users,
            dataToRender: _filteredData,
            isScrollable: false,
          );
        },
      );
    }
  }
}


/*
class CustomSearchWidget extends StatefulWidget {
  final List<CardTemplate> usersData;
  final List<String>? productsData; // Lista de productos

  CustomSearchWidget({
    required this.usersData,
     this.productsData,
  });

  @override
  _CustomSearchWidgetState createState() => _CustomSearchWidgetState();
}

class _CustomSearchWidgetState extends State<CustomSearchWidget> {
  late TextEditingController _searchController;
  List<CardTemplate> _suggestions = [];
  List<CardTemplate> _filteredUserData = [];
  List<String>? _filteredProductData = []; // Lista de productos filtrados
  List<CardTemplate> _userSuggestions = [];
  List<String> _productSuggestions = []; // Lista de productos sugeridos

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredUserData = widget.usersData;
    _filteredProductData = widget.productsData;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    List<CardTemplate> filteredUserList = widget.usersData.where((user) {
      final name = user.nombre.toLowerCase();
      return name.contains(query);
    }).toList();

    /*List<String> filteredProductList = widget.productsData.where((product) {
      final id = product.toLowerCase();
      return id.contains(query);
    }).toList();*/

    setState(() {
      _filteredUserData = filteredUserList;
      _userSuggestions = filteredUserList.length < 5 ? 
      filteredUserList : filteredUserList.sublist(0, 6);

    //  _filteredProductData = filteredProductList;
    //  _productSuggestions = filteredProductList.length < 5 ? filteredProductList : filteredProductList.sublist(0, 6);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: bottomNavBar,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [simpleShadow],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Ionicons.search),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.82,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      fillColor: bottomNavBar,
                      border: InputBorder.none,
                      hintText: 'Search...',
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                              },
                            )
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                _buildSearchResults(_filteredUserData, _userSuggestions),
               
                //_buildProductSearchResults(_filteredProductData, _productSuggestions),
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget _buildSearchResults(List<CardTemplate> filteredData, List<CardTemplate> suggestions) {
  if (_searchController.text.isEmpty) {
    return CardTemplateItemsList(
      listType: ListEnums.users,
      dataToRender: filteredData,
      isScrollable: false,
    );
  } else if (filteredData.isEmpty) {
    return Center(child: Text('No results found'));
  }  else {
      return ListView.builder(
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          final user = _userSuggestions[index];
          return CardTemplateItemsList(
            listType: ListEnums.users,
            dataToRender: filteredData,
            isScrollable: false,
          );
        },
    );
  }
}

/*
  Widget _buildProductSearchResults(List<String> filteredData, List<String> suggestions) {
    if (_searchController.text.isEmpty) {
      return StringItemsList(
        listType: ListEnums.products,
        dataToRender: filteredData,
        isScrollable: false,
      );
    } else if (filteredData.isEmpty) {
      return Center(child: Text('No results found'));
    } else {
      return ListView.builder(
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          final product = filteredData[index];
          return StringItemsList(
            listType: ListEnums.products,
            dataToRender: filteredData,
            isScrollable: false,
          );
        },
      );
    }
  }


}*/*/
