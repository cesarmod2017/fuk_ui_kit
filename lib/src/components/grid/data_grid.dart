import 'package:flutter/material.dart';

class DataGridColumn {
  final String title;
  final double? width;
  final bool sortable;
  final String field;
  final TextStyle? textStyle;

  DataGridColumn({
    required this.title,
    this.width,
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
  final bool? searchWhenTyping;
  final bool? hoverHighlight;
  final bool? stripedRows;
  final bool? showColumnBorders;

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
    this.searchWhenTyping,
    this.hoverHighlight = true,
    this.stripedRows = false,
    this.showColumnBorders = false,
  });

  @override
  FukDataGridState createState() => FukDataGridState();
}

class FukDataGridState extends State<FukDataGrid> {
  String _searchQuery = '';
  String? _sortedColumn;
  bool _isAscending = true;
  int _hoveredIndex = -1;
  double widthMax = 0.0;

  final ScrollController scrollHeader = ScrollController();
  final ScrollController scrollBody = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollHeader.addListener(() {
      scrollBody.jumpTo(scrollHeader.offset);
    });
    scrollBody.addListener(() {
      scrollHeader.jumpTo(scrollBody.offset);
    });
  }

  void setWidthMax() {
    widthMax = 0;
    for (var column in widget.columns) {
      widthMax += column.width ?? 200;
    }
    if (widthMax < MediaQuery.of(context).size.width) {
      widthMax = MediaQuery.of(context).size.width;
    }
  }

  @override
  Widget build(BuildContext context) {
    setWidthMax();
    return Column(
      children: [
        _buildSearchBar(),
        Expanded(
          //width: MediaQuery.of(context).size.width * 0.8,
          child: RawScrollbar(
            thumbVisibility: false,
            controller: scrollHeader,
            thickness: 8.0,
            thumbColor: Theme.of(context).colorScheme.primary,
            radius: const Radius.circular(50),
            minThumbLength: 50,
            scrollbarOrientation: ScrollbarOrientation.bottom,
            child: Column(
              children: [
                _buildHeader(),
                Expanded(child: _buildBody()),
                //_buildHorizontalScrollbar(),
              ],
            ),
          ),
        ),
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
                if (widget.searchWhenTyping == true) {
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
    return SingleChildScrollView(
      controller: scrollHeader,
      scrollDirection: Axis.horizontal,
      child: Container(
        width: widthMax,
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
                width: column.width ?? 150,
                padding: const EdgeInsets.all(8.0),
                decoration: widget.showColumnBorders == true
                    ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                      )
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        column.title,
                        style: column.textStyle ??
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
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
      ),
    );
  }

  Widget _buildBody() {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        scrollbars: true,
      ),
      child: SingleChildScrollView(
        controller: scrollBody,
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: widthMax,
          child: ListView.builder(
            itemCount: widget.data.length,
            itemBuilder: (context, index) {
              final row = widget.data[index];
              final isHovered =
                  widget.hoverHighlight == true && _hoveredIndex == index;
              final isStriped = widget.stripedRows == true && index % 2 == 0;
              return MouseRegion(
                onEnter: (_) {
                  setState(() {
                    _hoveredIndex = index;
                  });
                },
                onExit: (_) {
                  setState(() {
                    _hoveredIndex = -1;
                  });
                },
                child: Container(
                  color: isHovered
                      ? Theme.of(context).hoverColor
                      : isStriped
                          ? Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest
                          : Theme.of(context).colorScheme.surface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: widget.columns.map((column) {
                          return Container(
                            width: column.width ?? 150,
                            padding: const EdgeInsets.all(8.0),
                            child: row[column.field] is Widget
                                ? row[column.field]
                                : Text(
                                    row[column.field]?.toString() ?? '',
                                    style: column.textStyle,
                                  ),
                          );
                        }).toList(),
                      ),
                      if (widget.showColumnBorders == true)
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
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
