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
    return Stack(
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
                    suffixIcon: _searchController.text.isNotEmpty
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
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: _buildSearchResults(widget.allData),
        ),
      ],
    );
  }

  Widget _buildSearchResults(List<CardTemplate> dataToRender) {
    if (_searchController.text.isEmpty) {
      return CardTemplateItemsList(
        listType: ListEnums.users,
        dataToRender: dataToRender, 
        isScrollable: false,
      );
    } else if (_filteredData.isEmpty) {
      return const Center(child: Text('No se encontraron resultados'));
    } else {
      return ListView.builder(
        itemCount: dataToRender.length,
        itemBuilder: (context, index) {
          return CardTemplateItemsList(
            listType: ListEnums.users,
            dataToRender: dataToRender,

            ///_filteredData
            isScrollable: false,
          );
        },
      );
    }
  }
}
