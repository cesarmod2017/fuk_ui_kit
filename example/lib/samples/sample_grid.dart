import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';

class SampleGridPage extends StatefulWidget {
  const SampleGridPage({super.key});

  @override
  State<SampleGridPage> createState() => _SampleGridPageState();
}

class _SampleGridPageState extends State<SampleGridPage> {
  int _currentPage = 1;
  int _totalPage = 10;

  final List<DataGridColumn> _columns = [
    DataGridColumn(title: 'ID', width: 50, sortable: false, field: 'id'),
    DataGridColumn(title: 'Name', width: 800, sortable: true, field: 'name'),
    DataGridColumn(title: 'Age', width: 100, sortable: true, field: 'age'),
    DataGridColumn(title: '#', width: 120, sortable: false, field: 'action'),
  ];

  List<Map<String, dynamic>> _data = List.generate(
    100,
    (index) => {
      'id': index + 1,
      'name': 'Name ${index + 1}',
      'age': 20 + (index % 10),
      'action': FukButton(
        text: 'Edit',
        onPressed: () {
          log('Edit button pressed for item $index');
        },
      ),
    },
  );

  void _onPageChange(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _onSort(String field, bool isAscending) {
    setState(() {
      if (isAscending) {
        _data.sort((a, b) => a[field].compareTo(b[field]));
      } else {
        _data.sort((a, b) => b[field].compareTo(a[field]));
      }
    });
  }

  void _onSearch(String query) {
    String date = DateTime.now().toIso8601String();
    setState(() {
      _data = List.generate(
        15,
        (index) => {
          'id': index + 1,
          'name': 'Name ${index + 1} -- $date',
          'age': 20 + (index % 10),
        },
      );
      _totalPage = 5;
      // Implemente a lógica de busca
    });
  }

  void _onAdvancedSearch() {
    // Implemente a lógica de busca avançada
  }

  @override
  Widget build(BuildContext context) {
    return FukPage(
      header: FukHeader(
        title: 'Data Grid Samples',
        // leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle settings button press
            },
          ),
        ],
      ),
      content: FukContent(
        child: FukDataGrid(
          columns: _columns,
          data: _data,
          currentPage: _currentPage,
          totalPage: _totalPage,
          onPageChange: _onPageChange,
          onSort: _onSort,
          onSearch: _onSearch,
          onAdvancedSearch: _onAdvancedSearch,
          showAdvancedSearch: true,
          hoverHighlight: true,
          hintText: 'Pesquisar ....',
          searchWhenTyping: true,
          stripedRows: false,
          showColumnBorders: true,
        ),
      ),
      footer: const FukFooter(text: 'Footer Content'),
      // aside: Container(
      //   color: Colors.grey[800],
      //   child: const Center(
      //     child: Text('Aside Content'),
      //   ),
      // ),
    );
  }
}
