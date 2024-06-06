import 'package:flutter/material.dart';

class DataGridColumn {
  final String title;
  final double width;
  final bool sortable;
  final String field;
  final TextStyle? textStyle;

  DataGridColumn({
    required this.title,
    required this.width,
    this.sortable = false,
    required this.field,
    this.textStyle,
  });
}

class FukDataGrid extends StatefulWidget {
  final List<DataGridColumn> columns;
  final List<Map<String, dynamic>> data;
  final bool showAdvancedSearch;
  final int currentPage;
  final int totalPage;
  final Function(int) onPageChange;
  final Function(String, bool)? onSort;
  final Function(String)? onSearch;
  final VoidCallback? onAdvancedSearch;
  final String? hintText;
  final bool? searcWhenTyping;

  const FukDataGrid({
    super.key,
    required this.columns,
    required this.data,
    this.showAdvancedSearch = false,
    required this.currentPage,
    required this.totalPage,
    required this.onPageChange,
    this.onSort,
    this.onSearch,
    this.onAdvancedSearch,
    this.hintText,
    this.searcWhenTyping,
  });

  @override
  FukDataGridState createState() => FukDataGridState();
}

class FukDataGridState extends State<FukDataGrid> {
  String _searchQuery = '';
  String? _sortedColumn;
  bool _isAscending = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        _buildHeader(),
        Expanded(child: _buildBody()),
        _buildFooter(),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: widget.hintText ?? 'Search...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => widget.onSearch?.call(_searchQuery),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
                if (widget.searcWhenTyping == true) {
                  widget.onSearch?.call(_searchQuery);
                }
              },
            ),
          ),
          if (widget.showAdvancedSearch)
            IconButton(
              icon: const Icon(Icons.filter_alt),
              onPressed: widget.onAdvancedSearch,
            ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Row(
        children: widget.columns.map((column) {
          return GestureDetector(
            onTap: column.sortable
                ? () {
                    setState(() {
                      _sortedColumn = column.field;
                      _isAscending = !_isAscending;
                      widget.onSort?.call(column.field, _isAscending);
                    });
                  }
                : null,
            child: Container(
              width: column.width,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    column.title,
                    style: column.textStyle ??
                        Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                  ),
                  if (column.sortable)
                    Icon(
                      _sortedColumn == column.field
                          ? (_isAscending
                              ? Icons.arrow_upward
                              : Icons.arrow_downward)
                          : Icons.sort,
                      size: 16,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        final row = widget.data[index];
        return Row(
          children: widget.columns.map((column) {
            return Container(
              width: column.width,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                row[column.field]?.toString() ?? '',
                style: column.textStyle,
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildPagination(),
      ),
    );
  }

  List<Widget> _buildPagination() {
    List<Widget> pages = [];
    int startPage = 1;
    int endPage = 3;

    if (widget.currentPage > 2) {
      startPage = widget.currentPage - 1;
      endPage = widget.currentPage + 1;
    }

    if (widget.currentPage >= widget.totalPage - 1) {
      startPage = widget.totalPage - 2;
      endPage = widget.totalPage;
    }

    for (int i = startPage; i <= endPage; i++) {
      pages.add(_buildPageButton(i));
    }

    if (endPage < widget.totalPage) {
      pages.add(const Text('...'));
      pages.add(_buildPageButton(widget.totalPage));
    }

    return pages;
  }

  Widget _buildPageButton(int page) {
    return TextButton(
      onPressed: () => widget.onPageChange(page),
      style: TextButton.styleFrom(
        backgroundColor: page == widget.currentPage
            ? Theme.of(context).colorScheme.primary
            : null,
      ),
      child: Text(
        page.toString(),
        style: TextStyle(
          color: page == widget.currentPage
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
