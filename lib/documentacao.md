### fuk_ui_kit.dart
Path: D:\Projetos\fuk_ui_kit\lib\fuk_ui_kit.dart

Descricao:

```dart
library fuk_ui_kit;

export 'src/components/buttons/button.dart';
export 'src/components/dropdown/dropdown.dart';
export 'src/components/grid/data_grid.dart';
export 'src/components/image_editor/fuk_image_editor.dart';
export 'src/components/label/label.dart';
export 'src/components/layout/aside.dart';
export 'src/components/layout/content.dart';
export 'src/components/layout/content_master.dart';
export 'src/components/layout/footer.dart';
export 'src/components/layout/header.dart';
export 'src/components/layout/page.dart';
export 'src/components/layout/sidebar.dart';
export 'src/components/loading/loading.dart';
export 'src/components/modal/modal.dart';
export 'src/components/notify/notify.dart';
export 'src/components/tabs/tab_view.dart';
export 'src/components/textfield/fuk_text_field.dart';
export 'src/components/textfield/fuk_text_file.dart';
export 'src/components/tree_view/fuk_tree_view.dart';
export 'src/models/sidebar_items.dart';

```

### sidebar_items.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\models\sidebar_items.dart

Descricao:

```dart
import 'package:flutter/material.dart';

class SideBarItems {
  late String title;
  late String routeName;
  late Widget leading;
  VoidCallback? onTap;
  Function? changePage;

  List<SideBarItems>? children;

  SideBarItems({
    required this.title,
    required this.routeName,
    required this.leading,
    this.onTap,
    this.children,
    this.changePage,
  });

  List<PopupMenuItem> toPopupMenuItems() {
    return [
      PopupMenuItem(
        child: ListTile(
          leading: leading,
          title: Text(title),
          onTap: onTap,
        ),
      ),
      if (children != null)
        ...children!.expand((child) => child.toPopupMenuItems())
    ];
  }
}

```

### button.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\buttons\button.dart

Descricao:

```dart
import 'package:flutter/material.dart';

class FukButton extends StatelessWidget {
  final String? text;
  final Icon? icon;
  final bool iconOnRight;
  final bool iconBelowText;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final bool fullWidth;

  const FukButton({
    super.key,
    this.text,
    this.icon,
    this.iconOnRight = false,
    this.iconBelowText = false,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 8.0,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor:
              textColor ?? Theme.of(context).primaryTextTheme.labelLarge?.color,
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (icon != null && text != null) {
      if (iconBelowText) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon!,
            const SizedBox(height: 4),
            Text(text!),
          ],
        );
      } else if (iconOnRight) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text!),
            const SizedBox(width: 8),
            icon!,
          ],
        );
      } else {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon!,
            const SizedBox(width: 8),
            Text(text!),
          ],
        );
      }
    } else if (icon != null) {
      return icon!;
    } else {
      return Text(text!);
    }
  }
}

```

### dropdown.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\dropdown\dropdown.dart

Descricao:

```dart
import 'package:flutter/material.dart';

class FukDropdown<T> extends StatelessWidget {
  final String? placeholder;
  final String? label;
  final List<T> data;
  final T? selectedItem;
  final ValueChanged<T?> onChanged;
  final String Function(T)? displayItem;
  final InputDecoration? decoration;
  final bool isExpanded;

  const FukDropdown({
    super.key,
    this.placeholder,
    this.label,
    required this.data,
    this.selectedItem,
    required this.onChanged,
    this.displayItem,
    this.decoration,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
        ],
        DropdownButtonFormField<T>(
          decoration: decoration?.copyWith(
                hintText: placeholder,
              ) ??
              InputDecoration(
                hintText: placeholder,
              ),
          value: selectedItem,
          isExpanded: isExpanded,
          items: data.map((T value) {
            return DropdownMenuItem<T>(
              value: value,
              child: Text(
                  displayItem != null ? displayItem!(value) : value.toString()),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

```

### data_grid.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\grid\data_grid.dart

Descricao:

```dart
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

```

### fuk_image_editor.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\image_editor\fuk_image_editor.dart

Descricao:

```dart
import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/src/components/image_editor/components/canvas_area.dart';
import 'package:fuk_ui_kit/src/components/image_editor/components/toolbar.dart';

class FukImageEditor extends StatefulWidget {
  const FukImageEditor({super.key});

  @override
  FukImageEditorState createState() => FukImageEditorState();
}

class FukImageEditorState extends State<FukImageEditor> {
  final GlobalKey<CanvasAreaState> _canvasKey = GlobalKey<CanvasAreaState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Toolbar(canvasKey: _canvasKey),
        Expanded(
          child: CanvasArea(key: _canvasKey),
        ),
      ],
    );
  }
}

```

### label.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\label\label.dart

Descricao:

```dart
import 'package:flutter/material.dart';

enum FukLabelSize { small, medium, large }

class FukLabel extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final FukLabelSize size;

  const FukLabel({
    super.key,
    required this.text,
    this.style,
    this.size = FukLabelSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = _getTextStyle(context);

    return Text(
      text,
      style: style ?? textStyle,
    );
  }

  TextStyle _getTextStyle(BuildContext context) {
    switch (size) {
      case FukLabelSize.small:
        return Theme.of(context).textTheme.bodyMedium!;
      case FukLabelSize.large:
        return Theme.of(context).textTheme.titleLarge!;
      case FukLabelSize.medium:
      default:
        return Theme.of(context).textTheme.bodyLarge!;
    }
  }
}

```

### aside.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\layout\aside.dart

Descricao:

```dart
import 'package:flutter/material.dart';

class FukAside extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  const FukAside({
    super.key,
    required this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color:
            backgroundColor ?? Theme.of(context).colorScheme.surfaceContainer,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(-2, 0),
          ),
        ],
      ),
      child: child,
    );
  }
}

```

### content.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\layout\content.dart

Descricao:

```dart
import 'package:flutter/material.dart';

class FukContent extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const FukContent({
    super.key,
    required this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color:
            backgroundColor ?? Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: child,
    );
  }
}

```

### content_master.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\layout\content_master.dart

Descricao:

```dart
import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class FukContentMaster extends StatefulWidget {
  final List<SideBarItems> topItems;
  final List<SideBarItems> bottomItems;
  final Map<String, Widget>? routes;
  final Map<String, GetPage>? routesGetx;
  final String? iconImage;
  final Icon? icon;

  const FukContentMaster({
    super.key,
    required this.topItems,
    required this.bottomItems,
    this.routes,
    this.routesGetx,
    this.iconImage,
    this.icon,
  });

  @override
  FukContentMasterState createState() => FukContentMasterState();
}

class FukContentMasterState extends State<FukContentMaster> {
  String _selectedPage = '';

  @override
  void initState() {
    super.initState();
    // Set default route if available
    if (widget.routes != null && widget.routes!.isNotEmpty) {
      _selectedPage = widget.routes!.keys.first;
    }
    if (widget.routesGetx != null && widget.routesGetx!.isNotEmpty) {
      _selectedPage = widget.routesGetx!.keys.first;
    }
  }

  void _selectPage(String pageKey) {
    if (mounted) {
      setState(() {
        _selectedPage = pageKey;
      });
    }
  }

  void handleTap(SideBarItems item) {
    if (item.onTap != null) item.onTap!();
    if (item.children != null) {
      for (var childItem in item.children!) {
        childItem.changePage = () {
          if (childItem.children == null) {
            _selectPage(childItem.routeName);
          }
        };
        handleTap(childItem);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          FukSidebar(
            icon: widget.icon,
            iconImage: widget.iconImage,
            items: widget.topItems.map((item) {
              final SideBarItems listItem = item;
              handleTap(listItem);
              return SideBarItems(
                routeName: listItem.routeName,
                leading: listItem.leading,
                title: listItem.title,
                children: listItem.children,
                changePage: () {
                  if (listItem.children != null &&
                      listItem.children!.isNotEmpty) {
                    handleTap(listItem);
                  } else {
                    _selectPage(listItem.routeName);
                  }
                },
                onTap: listItem.onTap,
              );
            }).toList(),
            bottomItems: widget.bottomItems.map((item) {
              final SideBarItems listItem = item;
              return SideBarItems(
                routeName: listItem.routeName,
                leading: listItem.leading,
                title: listItem.title,
                changePage: () {
                  if (listItem.children != null &&
                      listItem.children!.isNotEmpty) {
                    handleTap(listItem);
                  } else {
                    _selectPage(listItem.routeName);
                  }
                },
                onTap: listItem.onTap,
              );
            }).toList(),
          ),
          Expanded(
            child: _buildPageContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent() {
    // Attempt to get the page from routes if it's not null and contains the selected page.
    final pageFromRoutes = widget.routes?[_selectedPage];
    if (pageFromRoutes != null) return pageFromRoutes;

    // Attempt to get the page from routesGetx if it's not null and contains the selected page.
    final pageFromRoutesGetx = widget.routesGetx?[_selectedPage]?.page();
    if (pageFromRoutesGetx != null) {
      widget.routesGetx?[_selectedPage]?.bindings.forEach((binding) {
        binding.dependencies();
      });
      return pageFromRoutesGetx;
    }

    // Return a default 'Page not found' widget if neither routes nor routesGetx have the selected page.
    return const Center(child: Text('Page not found'));
  }
}

```

### footer.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\layout\footer.dart

Descricao:

```dart
import 'package:flutter/material.dart';

class FukFooter extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final double? width;
  const FukFooter({
    super.key,
    required this.child,
    this.backgroundColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color:
            backgroundColor ?? Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: child,
    );
  }
}

```

### header.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\layout\header.dart

Descricao:

```dart
import 'package:flutter/material.dart';

class FukHeader extends StatelessWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? bottom;
  final Color? backgroundColor;
  const FukHeader({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.bottom,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.12),
            blurRadius: 4.0,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (leading != null) leading!,
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (actions != null) ...actions!,
            ],
          ),
          bottom ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}

```

### page.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\layout\page.dart

Descricao:

```dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FukPage extends StatelessWidget {
  final Widget? header;
  final Widget content;
  final Widget? footer;
  final Widget? aside;

  const FukPage({
    super.key,
    this.header,
    required this.content,
    this.footer,
    this.aside,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (header != null) header!,
        Expanded(
          child: Row(
            children: [
              Flexible(
                child: content,
              ),
              if (aside != null)
                SizedBox(
                  width: 250.0,
                  child: aside,
                ),
            ],
          ),
        ),
        if (footer != null) footer!,
      ],
    );
  }
}

```

### sidebar.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\layout\sidebar.dart

Descricao:

```dart
import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';

class FukSidebar extends StatefulWidget {
  final List<SideBarItems> items;
  final List<SideBarItems>? bottomItems;
  final String? iconImage;
  final Color? backgroundColor;
  final Icon? icon;

  const FukSidebar({
    super.key,
    required this.items,
    this.bottomItems,
    this.iconImage,
    this.icon,
    this.backgroundColor,
  });

  @override
  FukSidebarState createState() => FukSidebarState();
}

class FukSidebarState extends State<FukSidebar> {
  final bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.0,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.12),
            blurRadius: 4.0,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          if (widget.icon != null) widget.icon!,
          if (widget.iconImage != null) Image.asset(widget.iconImage!),
          Expanded(
            child: ListView(
              children: widget.items.map((item) => _buildItem(item)).toList(),
            ),
          ),
          if (widget.bottomItems != null)
            Column(
              children: [
                const Divider(color: Colors.white70),
                ...widget.bottomItems!.map((item) => _buildItem(item)),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildItem(SideBarItems item) {
    bool hasChildren = item.children != null && item.children!.isNotEmpty;

    return PopupMenuButton<SideBarItems>(
      tooltip: item.title,
      onSelected: (selectedItem) {
        if (selectedItem.changePage != null) {
          selectedItem.changePage!();
        }
      },
      itemBuilder: (context) => hasChildren
          ? _buildPopupMenuItems(item.children!)
          : [
              PopupMenuItem<SideBarItems>(
                value: item,
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40, // Define a width for the leading widget
                        child: item.leading,
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: Text(item.title)),
                    ],
                  ),
                ),
              ),
            ],
      child: SizedBox(
        width: 200,
        height: 50,
        child: Row(
          children: [
            SizedBox(
              width: 40, // Define a width for the leading widget
              child: item.leading,
            ),
            const SizedBox(width: 10),
            if (_isExpanded) Expanded(child: Text(item.title)),
          ],
        ),
      ),
    );
  }

  List<PopupMenuEntry<SideBarItems>> _buildPopupMenuItems(
      List<SideBarItems> items) {
    List<PopupMenuEntry<SideBarItems>> popupItems = [];
    for (var item in items) {
      bool hasChildren = item.children != null && item.children!.isNotEmpty;
      popupItems.add(
        PopupMenuItem<SideBarItems>(
          value: item,
          child: SizedBox(
            width: 200,
            height: 50,
            child: Row(
              children: [
                SizedBox(
                  width: 40, // Define a width for the leading widget
                  child: item.leading,
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(item.title)),
              ],
            ),
          ),
        ),
      );
      if (hasChildren) {
        popupItems.addAll(_buildPopupMenuItems(item.children!));
      }
    }
    return popupItems;
  }
}

```

### loading.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\loading\loading.dart

Descricao:

```dart
import 'package:flutter/material.dart';

enum FukLoadingAlignment {
  centerTop,
  centerBottom,
  center,
  bottomRight,
  topRight
}

class FukLoading {
  OverlayEntry? _currentOverlay;

  void show({
    required BuildContext context,
    FukLoadingAlignment alignment = FukLoadingAlignment.center,
    bool blockScreen = true,
    String? title,
    bool showDelayMessage = false,
    int delayDuration = 5,
    String delayMessage =
        "This is taking longer than expected. Do you want to cancel?",
    String continueButtonText = "Continue",
    String cancelButtonText = "Cancel",
    VoidCallback? onCancel,
  }) {
    _currentOverlay = OverlayEntry(
      builder: (context) => _FukLoadingWidget(
        alignment: alignment,
        blockScreen: blockScreen,
        title: title,
        showDelayMessage: showDelayMessage,
        delayDuration: delayDuration,
        delayMessage: delayMessage,
        continueButtonText: continueButtonText,
        cancelButtonText: cancelButtonText,
        onCancel: onCancel,
        overlayEntry: _currentOverlay!,
      ),
    );

    Overlay.of(context).insert(_currentOverlay!);
  }

  void hide() {
    if (_currentOverlay != null) {
      _currentOverlay?.remove();
      _currentOverlay = null;
    }
  }
}

class _FukLoadingWidget extends StatefulWidget {
  final FukLoadingAlignment alignment;
  final bool blockScreen;
  final String? title;
  final bool showDelayMessage;
  final int delayDuration;
  final String delayMessage;
  final String continueButtonText;
  final String cancelButtonText;
  final VoidCallback? onCancel;
  final OverlayEntry overlayEntry;

  const _FukLoadingWidget({
    required this.alignment,
    required this.blockScreen,
    this.title,
    required this.showDelayMessage,
    required this.delayDuration,
    required this.delayMessage,
    required this.continueButtonText,
    required this.cancelButtonText,
    this.onCancel,
    required this.overlayEntry,
  });

  @override
  State<_FukLoadingWidget> createState() => __FukLoadingWidgetState();
}

class __FukLoadingWidgetState extends State<_FukLoadingWidget> {
  bool _showDelayMessage = false;

  @override
  void initState() {
    super.initState();
    if (widget.showDelayMessage) {
      Future.delayed(Duration(seconds: widget.delayDuration), () {
        if (mounted) {
          setState(() {
            _showDelayMessage = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.blockScreen)
          ModalBarrier(
            dismissible: false,
            color: Colors.black.withOpacity(0.5),
          ),
        Align(
          alignment: _getAlignment(),
          child: Material(
            color: Colors.transparent,
            child: _showDelayMessage ? _buildDelayMessage() : _buildLoading(),
          ),
        ),
      ],
    );
  }

  Alignment _getAlignment() {
    switch (widget.alignment) {
      case FukLoadingAlignment.centerTop:
        return Alignment.topCenter;
      case FukLoadingAlignment.centerBottom:
        return Alignment.bottomCenter;
      case FukLoadingAlignment.bottomRight:
        return Alignment.bottomRight;
      case FukLoadingAlignment.topRight:
        return Alignment.topRight;
      case FukLoadingAlignment.center:
      default:
        return Alignment.center;
    }
  }

  Widget _buildLoading() {
    return Padding(
      padding: (widget.alignment == FukLoadingAlignment.bottomRight ||
              widget.alignment == FukLoadingAlignment.topRight)
          ? const EdgeInsets.all(24.0)
          : const EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: (widget.alignment == FukLoadingAlignment.center ||
                widget.alignment == FukLoadingAlignment.centerBottom ||
                widget.alignment == FukLoadingAlignment.centerTop)
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator(),
                  ),
                  if (widget.title != null) ...[
                    const SizedBox(height: 5),
                    Text(
                      widget.title!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ],
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator(),
                  ),
                  if (widget.title != null) ...[
                    const SizedBox(width: 10),
                    Text(
                      widget.title!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ],
                ],
              ),
      ),
    );
  }

  Widget _buildDelayMessage() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.delayMessage,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _showDelayMessage = false;
                  });
                },
                child: Text(widget.continueButtonText),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () {
                  widget.onCancel?.call();
                  if (widget.overlayEntry.mounted) {
                    widget.overlayEntry.remove();
                  }
                },
                child: Text(widget.cancelButtonText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

```

### modal.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\modal\modal.dart

Descricao:

```dart
import 'package:flutter/material.dart';

enum FukModalSize { small, medium, large, fullscreen }

class FukModal extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget> leftActions;
  final List<Widget> rightActions;
  final Color? headerColor;
  final Color? contentColor;
  final Color? footerColor;
  final FukModalSize size;

  const FukModal({
    super.key,
    required this.title,
    required this.content,
    this.leftActions = const [],
    this.rightActions = const [],
    this.headerColor,
    this.contentColor,
    this.footerColor,
    this.size = FukModalSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: _getConstraints(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            _buildContent(context),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  BoxConstraints _getConstraints(BuildContext context) {
    double width;
    double height;

    switch (size) {
      case FukModalSize.small:
        width = MediaQuery.of(context).size.width * 0.3;
        height = MediaQuery.of(context).size.height * 0.3;
        break;
      case FukModalSize.large:
        width = MediaQuery.of(context).size.width * 0.8;
        height = MediaQuery.of(context).size.height * 0.8;
        break;
      case FukModalSize.fullscreen:
        width = MediaQuery.of(context).size.width;
        height = MediaQuery.of(context).size.height;
        break;
      case FukModalSize.medium:
      default:
        width = MediaQuery.of(context).size.width * 0.5;
        height = MediaQuery.of(context).size.height * 0.5;
        break;
    }

    return BoxConstraints(
      maxWidth: width,
      maxHeight: height,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: headerColor ?? Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            color: Theme.of(context).colorScheme.onSurface,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        color: contentColor ?? Theme.of(context).colorScheme.primaryContainer,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: content,
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      color: footerColor ?? Theme.of(context).colorScheme.secondaryContainer,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: leftActions),
          Row(children: rightActions),
        ],
      ),
    );
  }
}

```

### notify.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\notify\notify.dart

Descricao:

```dart
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

enum FukNotifyType { info, warning, success, error, defaultType }

enum FukNotifyDirection { top, bottom }

class FukNotify {
  static void show({
    required BuildContext context,
    required String title,
    String? message,
    int duration = 3,
    FukNotifyType type = FukNotifyType.defaultType,
    FukNotifyDirection direction = FukNotifyDirection.top,
  }) {
    late OverlayEntry overlayEntry;
    Future.delayed(Duration.zero, () {
      overlayEntry = OverlayEntry(
        builder: (context) => _FukNotifyWidget(
          title: title,
          message: message,
          duration: duration,
          direction: direction,
          type: type,
          onDismiss: () {
            if (overlayEntry.mounted) {
              overlayEntry.remove();
            }
          },
        ),
      );

      Overlay.of(context).insert(overlayEntry);

      Future.delayed(Duration(seconds: duration), () {
        if (overlayEntry.mounted) {
          overlayEntry.remove();
        }
      });
    });
  }
}

class _FukNotifyWidget extends StatelessWidget {
  final String title;
  final String? message;
  final int duration;
  final FukNotifyType type;
  final FukNotifyDirection? direction;
  final VoidCallback onDismiss;

  const _FukNotifyWidget({
    required this.title,
    this.message,
    required this.duration,
    required this.type,
    required this.onDismiss,
    this.direction = FukNotifyDirection.top,
  });

  Color _getTypeColor(FukNotifyType type, BuildContext context) {
    switch (type) {
      case FukNotifyType.info:
        return Colors.blue;
      case FukNotifyType.success:
        return Colors.green;
      case FukNotifyType.warning:
        return Colors.yellow;
      case FukNotifyType.error:
        return Colors.red;
      case FukNotifyType.defaultType:
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: direction == FukNotifyDirection.top ? 50 : null,
      bottom: direction == FukNotifyDirection.bottom ? 50 : null,
      left:
          (kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux)
              ? MediaQuery.of(context).size.width * 0.5
              : MediaQuery.of(context).size.width * 0.1,
      right: 25,
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black87,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 70,
                color: _getTypeColor(type, context),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: message == null
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                              textAlign: message == null
                                  ? TextAlign.center
                                  : TextAlign.start,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              size: 16,
                            ),
                            color: Theme.of(context).colorScheme.onSurface,
                            onPressed: onDismiss,
                          ),
                        ],
                      ),
                      if (message != null) ...[
                        const SizedBox(height: 3),
                        Text(
                          message!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

```

### tab_view.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\tabs\tab_view.dart

Descricao:

```dart
import 'package:flutter/material.dart';

class FukTabView extends StatelessWidget {
  final String? title;
  final Widget? child;
  final ValueSetter<int>? onClose;
  final VoidCallback? onNewTab;
  final int index;

  const FukTabView({
    super.key,
    required this.index,
    this.title,
    this.child,
    this.onClose,
    this.onNewTab,
  });

  Tab get tab => Tab(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            title != null
                ? Flexible(
                    child: Text(title!,
                        style: const TextStyle(
                          fontSize: 12,
                        )),
                  )
                : const SizedBox.shrink(),
            IconButton(
              icon: Icon(
                onClose != null ? Icons.close : Icons.add,
                size: onClose != null ? 12 : 18,
                color: onClose != null ? Colors.red : Colors.blue,
              ),
              onPressed: () {
                if (onClose != null) {
                  onClose!(index);
                } else {
                  onNewTab!();
                }
              },
            ),
          ],
        ),
      );

  Widget get view => child ?? const SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

```

### fuk_text_field.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\textfield\fuk_text_field.dart

Descricao:

```dart
import 'package:flutter/material.dart';

class FukTextField extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final bool isRequired;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final Icon? icon;
  final VoidCallback? onIconPressed;
  final bool validate;
  final bool isPassword;
  final bool isObscure;
  final TextInputType? keyboardType;
  final int? minLines;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onTap;
  final FormFieldSetter<String>? onSaved;
  final TapRegionCallback? onTapOutside;

  const FukTextField({
    super.key,
    this.label,
    this.placeholder,
    this.isRequired = false,
    this.controller,
    this.decoration,
    this.icon,
    this.onIconPressed,
    this.validate = true,
    this.isPassword = false,
    this.isObscure = true,
    this.keyboardType,
    this.minLines,
    this.maxLines,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onTap,
    this.onSaved,
    this.onTapOutside,
  });

  @override
  FukTextFieldState createState() => FukTextFieldState();
}

class FukTextFieldState extends State<FukTextField> {
  late TextEditingController _controller;
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _obscureText = widget.isPassword ? widget.isObscure : false;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String? _validateField(String? value) {
    if (widget.isRequired && (value == null || value.isEmpty)) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: _controller,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          validator: widget.validate ? _validateField : null,
          obscureText: _obscureText,
          onChanged: widget.onChanged,
          onTapOutside: widget.onTapOutside,
          onFieldSubmitted: widget.onFieldSubmitted,
          onEditingComplete: widget.keyboardType == TextInputType.multiline
              ? () {
                  widget.onFieldSubmitted?.call(_controller.text);
                }
              : widget.onEditingComplete,
          onTap: widget.onTap,
          onSaved: widget.onSaved,
          decoration: widget.decoration?.copyWith(
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: _toggleObscureText,
                      )
                    : widget.icon != null
                        ? IconButton(
                            icon: widget.icon!,
                            onPressed: widget.onIconPressed,
                          )
                        : null,
                hintText: widget.placeholder,
              ) ??
              InputDecoration(
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: _toggleObscureText,
                      )
                    : widget.icon != null
                        ? IconButton(
                            icon: widget.icon!,
                            onPressed: widget.onIconPressed,
                          )
                        : null,
                hintText: widget.placeholder,
              ),
        ),
      ],
    );
  }
}

```

### fuk_text_file.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\textfield\fuk_text_file.dart

Descricao:

```dart
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

enum AllowedFileType {
  all,
  imagePng,
  imageJpg,
  imageJpeg,
  documentPdf,
  documentDoc,
  documentDocx,
  documentXls,
  documentXlsx,
  folder,
}

class FukTextFile extends StatefulWidget {
  final bool isRequired;
  final List<AllowedFileType> allowedFileTypes;
  final TextEditingController? controller;
  final Icon? icon;
  final bool validate;
  final String? label;
  final InputDecoration? decoration;

  const FukTextFile({
    super.key,
    this.isRequired = false,
    this.allowedFileTypes = const [AllowedFileType.all],
    this.controller,
    this.icon,
    this.validate = true,
    this.label,
    this.decoration,
  });

  @override
  FukTextFileState createState() => FukTextFileState();
}

class FukTextFileState extends State<FukTextFile> {
  late TextEditingController _controller;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  Future<void> _pickFile() async {
    FileType fileType = _mapAllowedFileType(widget.allowedFileTypes);

    if (widget.allowedFileTypes.contains(AllowedFileType.folder)) {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory != null) {
        setState(() {
          _filePath = selectedDirectory;
          _controller.text = _filePath!;
        });
      }
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: fileType,
        allowedExtensions: _getAllowedExtensions(widget.allowedFileTypes),
      );

      if (result != null) {
        setState(() {
          _filePath = result.files.single.path;
          _controller.text = _filePath!;
        });
      }
    }
  }

  FileType _mapAllowedFileType(List<AllowedFileType> types) {
    if (types.contains(AllowedFileType.folder)) {
      return FileType.any; // Handle folder separately
    } else if (types.length == 1) {
      switch (types.first) {
        case AllowedFileType.all:
          return FileType.any;
        case AllowedFileType.imagePng:
        case AllowedFileType.imageJpg:
        case AllowedFileType.imageJpeg:
          return FileType.image;
        case AllowedFileType.documentPdf:
        case AllowedFileType.documentDoc:
        case AllowedFileType.documentDocx:
        case AllowedFileType.documentXls:
        case AllowedFileType.documentXlsx:
          return FileType.custom;
        default:
          return FileType.any;
      }
    } else {
      return FileType.custom;
    }
  }

  List<String>? _getAllowedExtensions(List<AllowedFileType> types) {
    if (types.contains(AllowedFileType.folder)) {
      return null; // No extensions needed for folder selection
    } else if (types.isNotEmpty) {
      return types
          .map((type) {
            switch (type) {
              case AllowedFileType.imagePng:
                return 'png';
              case AllowedFileType.imageJpg:
                return 'jpg';
              case AllowedFileType.imageJpeg:
                return 'jpeg';
              case AllowedFileType.documentPdf:
                return 'pdf';
              case AllowedFileType.documentDoc:
                return 'doc';
              case AllowedFileType.documentDocx:
                return 'docx';
              case AllowedFileType.documentXls:
                return 'xls';
              case AllowedFileType.documentXlsx:
                return 'xlsx';
              default:
                return null;
            }
          })
          .where((ext) => ext != null)
          .cast<String>()
          .toList();
    }
    return null;
  }

  String? _validateFile(String? value) {
    if (widget.isRequired && (value == null || value.isEmpty)) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: _controller,
          validator: widget.validate ? _validateFile : null,
          decoration: widget.decoration?.copyWith(
                suffixIcon: IconButton(
                  icon: widget.icon ?? const Icon(Icons.attach_file),
                  onPressed: _pickFile,
                ),
                hintText: 'Select a file',
              ) ??
              InputDecoration(
                suffixIcon: IconButton(
                  icon: widget.icon ?? const Icon(Icons.attach_file),
                  onPressed: _pickFile,
                ),
                hintText: 'Select a file',
              ),
        ),
      ],
    );
  }
}

```

### fuk_tree_view.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\tree_view\fuk_tree_view.dart

Descricao:

```dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FukTreeViewItem {
  final String id;
  final String title;
  final bool isFolder;
  final bool isReadOnly;
  List<FukTreeViewItem> children;
  final Icon? icon;

  FukTreeViewItem({
    String? id,
    required this.title,
    this.isFolder = false,
    this.isReadOnly = false,
    this.children = const [],
    this.icon,
  }) : id = id ?? const Uuid().v4();

  FukTreeViewItem copyWith({
    String? id,
    String? title,
    bool? isFolder,
    bool? isReadOnly,
    List<FukTreeViewItem>? children,
    Icon? icon,
  }) {
    return FukTreeViewItem(
      id: id ?? this.id,
      title: title ?? this.title,
      isFolder: isFolder ?? this.isFolder,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      children: children ?? this.children,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isFolder': isFolder,
      'isReadOnly': isReadOnly,
      'children': children.map((child) => child.toJson()).toList(),
      'icon': icon?.icon?.codePoint,
    };
  }

  static FukTreeViewItem fromJson(Map<String, dynamic> json) {
    return FukTreeViewItem(
      id: json['id'],
      title: json['title'],
      isFolder: json['isFolder'],
      isReadOnly: json['isReadOnly'],
      children: (json['children'] as List)
          .map((childJson) => FukTreeViewItem.fromJson(childJson))
          .toList(),
      icon: json['icon'] != null
          ? Icon(IconData(json['icon'], fontFamily: 'MaterialIcons'))
          : null,
    );
  }
}

class FukTreeViewController {
  List<FukTreeViewItem> items = [];

  void loadFromJson(String json) {
    final List<dynamic> jsonData = jsonDecode(json);
    items =
        jsonData.map((itemJson) => FukTreeViewItem.fromJson(itemJson)).toList();
  }

  String generateJson() {
    return jsonEncode(items.map((item) => item.toJson()).toList());
  }
}

class FukTreeView extends StatefulWidget {
  final List<FukTreeViewItem> items;
  final bool showCheckbox;
  final Function(List<FukTreeViewItem>)? onSelectionChanged;
  final bool initiallyExpanded;
  final List<FukTreeViewOption> options;
  final FukTreeViewController? controller;
  final bool sortAlphabetically;

  const FukTreeView({
    super.key,
    required this.items,
    this.showCheckbox = false,
    this.onSelectionChanged,
    this.initiallyExpanded = false,
    this.options = const [],
    this.controller,
    this.sortAlphabetically = false,
  });

  @override
  FukTreeViewState createState() => FukTreeViewState();
}

class FukTreeViewState extends State<FukTreeView> {
  final List<FukTreeViewItem> _selectedItems = [];
  final Map<FukTreeViewItem, bool> _expandedItems = {};
  FukTreeViewItem? _highlightedItem;
  FukTreeViewItem? _draggedItem;

  @override
  void initState() {
    super.initState();
    if (widget.initiallyExpanded) {
      _expandAllItems(widget.items);
    }
    widget.controller?.items = widget.items;
    if (widget.sortAlphabetically) {
      _sortItems(widget.items);
    }
  }

  void _expandAllItems(List<FukTreeViewItem> items) {
    for (var item in items) {
      _expandedItems[item] = true;
      if (item.children.isNotEmpty) {
        _expandAllItems(item.children);
      }
    }
  }

  void _onItemChanged(FukTreeViewItem item, bool? selected) {
    setState(() {
      if (selected == true) {
        _selectItem(item);
      } else {
        _deselectItem(item);
      }
    });

    if (widget.onSelectionChanged != null) {
      widget.onSelectionChanged!(_selectedItems);
    }
  }

  void _selectItem(FukTreeViewItem item) {
    if (!_selectedItems.contains(item)) {
      _selectedItems.add(item);
    }
    for (var child in item.children) {
      _selectItem(child);
    }
  }

  void _deselectItem(FukTreeViewItem item) {
    _selectedItems.remove(item);
    for (var child in item.children) {
      _deselectItem(child);
    }
  }

  void _showContextMenu(
      BuildContext context, Offset position, FukTreeViewItem item) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        position & const Size(40, 40),
        Offset.zero & overlay.size,
      ),
      items: widget.options
          .map((option) => PopupMenuItem(
                child: ListTile(
                  leading: Icon(
                    option.icon,
                  ),
                  title: Text(option.title),
                  onTap: () {
                    Navigator.pop(context);
                    option.onTap(item);
                  },
                ),
              ))
          .toList(),
    );
  }

  void _onDragStart(FukTreeViewItem item) {
    setState(() {
      _draggedItem = item;
    });
  }

  void _onDragEnd(FukTreeViewItem item) {
    if (_draggedItem != null && _draggedItem != item && item.isFolder) {
      setState(() {
        item.children.add(_draggedItem!);
        _removeItem(_draggedItem!, widget.items);
        _draggedItem = null;
        if (widget.sortAlphabetically) {
          _sortItems(widget.items);
        }
      });
    } else {
      setState(() {
        _draggedItem = null;
      });
    }
  }

  void _removeItem(FukTreeViewItem item, List<FukTreeViewItem> items) {
    for (var i = 0; i < items.length; i++) {
      if (items[i] == item) {
        items.removeAt(i);
        return;
      } else if (items[i].children.isNotEmpty) {
        _removeItem(item, items[i].children);
      }
    }
  }

  void _handleDragAccept(FukTreeViewItem item) {
    if (_draggedItem != null && _draggedItem != item && item.isFolder) {
      setState(() {
        _removeItem(_draggedItem!, widget.items);
        item.children.add(_draggedItem!);
        _draggedItem = null;
        if (widget.sortAlphabetically) {
          _sortItems(widget.items);
        }
      });
    }
  }

  void _sortItems(List<FukTreeViewItem> items) {
    items.sort((a, b) => a.title.compareTo(b.title));
    for (var item in items) {
      if (item.children.isNotEmpty) {
        _sortItems(item.children);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.items.map((item) => _buildTreeViewItem(item)).toList(),
    );
  }

  Widget _buildTreeViewItem(FukTreeViewItem item, {int level = 0}) {
    bool isExpanded = _expandedItems[item] ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.0 * level),
          child: Row(
            children: [
              if (widget.showCheckbox)
                Checkbox(
                  value: _selectedItems.contains(item),
                  onChanged: item.isReadOnly
                      ? null
                      : (selected) => _onItemChanged(item, selected),
                ),
              GestureDetector(
                onSecondaryTapDown: (details) {
                  _showContextMenu(context, details.globalPosition, item);
                },
                onTap: () {
                  if (item.isFolder) {
                    setState(() {
                      _expandedItems[item] = !isExpanded;
                    });
                  }
                  setState(() {
                    _highlightedItem = item;
                  });
                },
                child: Draggable<FukTreeViewItem>(
                  data: item,
                  onDragStarted: () => _onDragStart(item),
                  onDraggableCanceled: (_, __) => _onDragEnd(item),
                  feedback: Material(
                    child: _buildTreeItemContent(item, level),
                  ),
                  child: DragTarget<FukTreeViewItem>(
                    onAcceptWithDetails: (receivedItem) =>
                        _handleDragAccept(item),
                    builder: (context, candidateData, rejectedData) {
                      return _buildTreeItemContent(item, level);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isExpanded)
          Column(
            children: item.children
                .map((child) => _buildTreeViewItem(child, level: level + 1))
                .toList(),
          ),
      ],
    );
  }

  Widget _buildTreeItemContent(FukTreeViewItem item, int level) {
    return Row(
      children: [
        Icon(
          item.isFolder
              ? (_expandedItems[item] == true
                  ? Icons.folder_open
                  : Icons.folder)
              : (item.icon?.icon ?? Icons.insert_drive_file),
          color: item.icon?.color ?? Colors.white,
        ),
        const SizedBox(width: 8),
        Text(
          item.title,
          style: TextStyle(
            color: item == _highlightedItem
                ? Theme.of(context).colorScheme.primary
                : item.isReadOnly
                    ? Colors.grey
                    : Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight:
                item == _highlightedItem ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class FukTreeViewOption {
  final String title;
  final IconData icon;
  final void Function(FukTreeViewItem) onTap;

  FukTreeViewOption({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}

```

### canvas_area.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\image_editor\components\canvas_area.dart

Descricao:

```dart
import 'package:flutter/material.dart';

import 'shape_layer.dart';

class CanvasArea extends StatefulWidget {
  const CanvasArea({super.key});

  @override
  CanvasAreaState createState() => CanvasAreaState();
}

class CanvasAreaState extends State<CanvasArea> {
  List<Widget> layers = [];
  double _canvasWidth = 500;
  double _canvasHeight = 500;
  double _scale = 1.0;
  Set<int> selectedIndices = {};

  void addLayer(Widget layer) {
    setState(() {
      layers.add(layer);
    });
  }

  void clearLayers() {
    setState(() {
      layers.clear();
      selectedIndices.clear();
    });
  }

  void setCanvasSize(double width, double height) {
    setState(() {
      _canvasWidth = width;
      _canvasHeight = height;
    });
  }

  void zoomIn() {
    setState(() {
      _scale += 0.1;
    });
  }

  void zoomOut() {
    setState(() {
      _scale = (_scale - 0.1).clamp(0.1, 10.0);
    });
  }

  void selectLayer(int index) {
    setState(() {
      selectedIndices.add(index);
    });
  }

  void deselectLayer(int index) {
    setState(() {
      selectedIndices.remove(index);
    });
  }

  void deselectAllLayers() {
    setState(() {
      selectedIndices.clear();
    });
  }

  void updateSelectedLayersColor(Color color) {
    for (int index in selectedIndices) {
      if (layers[index] is ShapeLayer) {
        (layers[index] as ShapeLayerState).updateColor(color);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRect(
        child: Transform.scale(
          scale: _scale,
          child: Container(
            width: _canvasWidth,
            height: _canvasHeight,
            color: Colors.white,
            child: GestureDetector(
              onTap: () {
                deselectAllLayers();
              },
              child: Stack(
                children: List.generate(layers.length, (index) {
                  return layers[index] is ShapeLayer
                      ? ShapeLayer(
                          shapeType: (layers[index] as ShapeLayer).shapeType,
                          color: (layers[index] as ShapeLayer).color,
                          onSelect: () => selectLayer(index),
                          onDeselect: () => deselectLayer(index),
                          isSelected: selectedIndices.contains(index),
                        )
                      : layers[index];
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

```

### context_menu.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\image_editor\components\context_menu.dart

Descricao:

```dart
import 'package:flutter/material.dart';

class ContextMenu extends StatelessWidget {
  final Offset position;
  final VoidCallback onMoveToFront;
  final VoidCallback onMoveToBack;

  const ContextMenu({
    super.key,
    required this.position,
    required this.onMoveToFront,
    required this.onMoveToBack,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: PopupMenuButton(
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'front',
            child: Text('Move to Front'),
          ),
          const PopupMenuItem(
            value: 'back',
            child: Text('Move to Back'),
          ),
        ],
        onSelected: (value) {
          if (value == 'front') {
            onMoveToFront();
          } else if (value == 'back') {
            onMoveToBack();
          }
        },
      ),
    );
  }
}

```

### image_layer.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\image_editor\components\image_layer.dart

Descricao:

```dart
import 'package:flutter/material.dart';

class ImageLayer extends StatelessWidget {
  final String imagePath;
  const ImageLayer({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 100,
      top: 100,
      child: Draggable(
        feedback: Image.asset(imagePath),
        child: Image.asset(imagePath),
        onDragEnd: (details) {
          // Atualizar a posição da imagem
        },
      ),
    );
  }
}

```

### shape_layer.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\image_editor\components\shape_layer.dart

Descricao:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ShapeLayer extends StatefulWidget {
  final ShapeType shapeType;
  final Color color;
  final double width;
  final double height;
  final Function onSelect;
  final bool isSelected;
  final Function onDeselect;

  const ShapeLayer({
    super.key,
    required this.shapeType,
    required this.color,
    required this.onSelect,
    required this.onDeselect,
    this.width = 100,
    this.height = 100,
    this.isSelected = false,
  });

  @override
  ShapeLayerState createState() => ShapeLayerState();
}

class ShapeLayerState extends State<ShapeLayer> {
  late double _x;
  late double _y;
  late double _rotation;
  late double _width;
  late double _height;
  late Color _color;
  bool _isResizing = false;

  @override
  void initState() {
    super.initState();
    _x = 100;
    _y = 100;
    _rotation = 0;
    _width = widget.width;
    _height = widget.height;
    _color = widget.color;
  }

  void updateColor(Color color) {
    setState(() {
      _color = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _x,
      top: _y,
      child: GestureDetector(
        onDoubleTap: () {
          setState(() {
            _isResizing = !_isResizing;
          });
        },
        onTap: () {
          if (widget.isSelected) {
            widget.onDeselect();
          } else {
            widget.onSelect();
          }
        },
        onPanUpdate: (details) {
          if (_isResizing) {
            setState(() {
              _width += details.delta.dx;
              _height += details.delta.dy;
            });
          } else {
            setState(() {
              _x += details.delta.dx;
              _y += details.delta.dy;
            });
          }
        },
        child: Transform.rotate(
          angle: _rotation,
          child: Container(
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              color: _color.withOpacity(0.7),
              shape: widget.shapeType == ShapeType.circle
                  ? BoxShape.circle
                  : BoxShape.rectangle,
              border: widget.isSelected
                  ? Border.all(color: Colors.blue, width: 2)
                  : null,
            ),
            child: Stack(
              children: [
                if (widget.isSelected) ...[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _width -= details.delta.dx;
                          _height -= details.delta.dy;
                          _x += details.delta.dx;
                          _y += details.delta.dy;
                        });
                      },
                      child:
                          const Icon(Icons.circle, size: 8, color: Colors.blue),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _width += details.delta.dx;
                          _height -= details.delta.dy;
                          _y += details.delta.dy;
                        });
                      },
                      child:
                          const Icon(Icons.circle, size: 8, color: Colors.blue),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _width -= details.delta.dx;
                          _height += details.delta.dy;
                          _x += details.delta.dx;
                        });
                      },
                      child:
                          const Icon(Icons.circle, size: 8, color: Colors.blue),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _width += details.delta.dx;
                          _height += details.delta.dy;
                        });
                      },
                      child:
                          const Icon(Icons.circle, size: 8, color: Colors.blue),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        _showColorPicker(context).then((color) {
                          if (color != null) {
                            setState(() {
                              _color = color;
                            });
                          }
                        });
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        color: Colors.transparent,
                        child: const Icon(Icons.color_lens, size: 16),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _rotation += details.delta.dx * 0.01;
                        });
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        color: Colors.transparent,
                        child: const Icon(Icons.rotate_right, size: 16),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Color?> _showColorPicker(BuildContext context) async {
    Color selectedColor = _color;
    return showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                selectedColor = color;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Got it'),
              onPressed: () {
                Navigator.of(context).pop(selectedColor);
              },
            ),
          ],
        );
      },
    );
  }
}

enum ShapeType { rectangle, circle, line }

```

### text_layer.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\image_editor\components\text_layer.dart

Descricao:

```dart
import 'package:flutter/material.dart';

class TextLayer extends StatefulWidget {
  final String initialText;
  final double width;
  final double height;
  final Function onSelect;
  final bool isSelected;
  final Function onDeselect;

  const TextLayer({
    super.key,
    required this.initialText,
    required this.onSelect,
    required this.onDeselect,
    this.width = 200,
    this.height = 100,
    this.isSelected = false,
  });

  @override
  TextLayerState createState() => TextLayerState();
}

class TextLayerState extends State<TextLayer> {
  late double _x;
  late double _y;
  late double _rotation;
  late double _width;
  late double _height;
  late String _text;
  bool _isEditing = false;
  TextStyle _textStyle = const TextStyle(fontSize: 20, color: Colors.black);

  @override
  void initState() {
    super.initState();
    _x = 100;
    _y = 100;
    _rotation = 0;
    _width = widget.width;
    _height = widget.height;
    _text = widget.initialText;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _x,
      top: _y,
      child: GestureDetector(
        onDoubleTap: () {
          setState(() {
            _isEditing = !_isEditing;
          });
        },
        onTap: () {
          if (widget.isSelected) {
            widget.onDeselect();
          } else {
            widget.onSelect();
          }
        },
        onPanUpdate: (details) {
          if (_isEditing) {
            setState(() {
              _width += details.delta.dx;
              _height += details.delta.dy;
            });
          } else {
            setState(() {
              _x += details.delta.dx;
              _y += details.delta.dy;
            });
          }
        },
        child: Transform.rotate(
          angle: _rotation,
          child: Container(
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: widget.isSelected ? Colors.blue : Colors.transparent,
              ),
            ),
            child: Stack(
              children: [
                if (widget.isSelected) ...[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _width -= details.delta.dx;
                          _height -= details.delta.dy;
                          _x += details.delta.dx;
                          _y += details.delta.dy;
                        });
                      },
                      child:
                          const Icon(Icons.circle, size: 8, color: Colors.blue),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _width += details.delta.dx;
                          _height -= details.delta.dy;
                          _y += details.delta.dy;
                        });
                      },
                      child:
                          const Icon(Icons.circle, size: 8, color: Colors.blue),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _width -= details.delta.dx;
                          _height += details.delta.dy;
                          _x += details.delta.dx;
                        });
                      },
                      child:
                          const Icon(Icons.circle, size: 8, color: Colors.blue),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _width += details.delta.dx;
                          _height += details.delta.dy;
                        });
                      },
                      child:
                          const Icon(Icons.circle, size: 8, color: Colors.blue),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _rotation += details.delta.dx * 0.01;
                        });
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        color: Colors.transparent,
                        child: const Icon(Icons.rotate_right, size: 16),
                      ),
                    ),
                  ),
                ],
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      _text,
                      style: _textStyle,
                    ),
                  ),
                ),
                if (_isEditing)
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: TextField(
                        onSubmitted: (value) {
                          setState(() {
                            _text = value;
                            _isEditing = false;
                          });
                        },
                        style: _textStyle,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter text',
                        ),
                      ),
                    ),
                  ),
                if (widget.isSelected)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: PopupMenuButton<TextStyle>(
                      onSelected: (style) {
                        setState(() {
                          _textStyle = style;
                        });
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: TextStyle(fontSize: 20, color: Colors.black),
                          child: Text('Default'),
                        ),
                        const PopupMenuItem(
                          value: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          child: Text('Bold'),
                        ),
                        const PopupMenuItem(
                          value: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                          ),
                          child: Text('Italic'),
                        ),
                        const PopupMenuItem(
                          value: TextStyle(fontSize: 30, color: Colors.black),
                          child: Text('Large'),
                        ),
                      ],
                      icon: const Icon(Icons.text_fields),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

```

### toolbar.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\image_editor\components\toolbar.dart

Descricao:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fuk_ui_kit/src/components/image_editor/components/image_layer.dart';

import '../utils/file_picker.dart';
import 'canvas_area.dart';
import 'shape_layer.dart';
import 'text_layer.dart';

class Toolbar extends StatelessWidget {
  final GlobalKey<CanvasAreaState> canvasKey;

  const Toolbar({super.key, required this.canvasKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.create_new_folder),
            onPressed: () {
              canvasKey.currentState?.clearLayers();
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_photo_alternate),
            onPressed: () async {
              final file = await pickFile();
              if (file != null) {
                canvasKey.currentState?.addLayer(
                  ImageLayer(imagePath: file),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.crop),
            onPressed: () {
              // Cortar imagem
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter),
            onPressed: () {
              // Adicionar efeitos
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Salvar imagem
            },
          ),
          PopupMenuButton<ShapeType>(
            onSelected: (shape) {
              _showColorPicker(context).then((color) {
                if (color != null) {
                  canvasKey.currentState?.addLayer(
                    ShapeLayer(
                      shapeType: shape,
                      color: color,
                      onSelect: () {},
                      onDeselect: () {},
                    ),
                  );
                }
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: ShapeType.rectangle,
                child: Text('Add Rectangle'),
              ),
              const PopupMenuItem(
                value: ShapeType.circle,
                child: Text('Add Circle'),
              ),
              const PopupMenuItem(
                value: ShapeType.line,
                child: Text('Add Line'),
              ),
            ],
            icon: const Icon(Icons.add_box),
          ),
          IconButton(
            icon: const Icon(Icons.text_fields),
            onPressed: () {
              canvasKey.currentState?.addLayer(
                TextLayer(
                  initialText: 'Your Text Here',
                  onSelect: () {},
                  onDeselect: () {},
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (size) {
              switch (size) {
                case '500x500':
                  canvasKey.currentState?.setCanvasSize(500, 500);
                  break;
                case '800x800':
                  canvasKey.currentState?.setCanvasSize(800, 800);
                  break;
                case '1080x1024':
                  canvasKey.currentState?.setCanvasSize(1080, 1024);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: '500x500',
                child: Text('500x500'),
              ),
              const PopupMenuItem(
                value: '800x800',
                child: Text('800x800'),
              ),
              const PopupMenuItem(
                value: '1080x1024',
                child: Text('1080x1024'),
              ),
            ],
            icon: const Icon(Icons.aspect_ratio),
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () {
              canvasKey.currentState?.zoomIn();
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () {
              canvasKey.currentState?.zoomOut();
            },
          ),
          IconButton(
            icon: const Icon(Icons.color_lens),
            onPressed: () {
              _showColorPicker(context).then((color) {
                if (color != null) {
                  canvasKey.currentState?.updateSelectedLayersColor(color);
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Future<Color?> _showColorPicker(BuildContext context) async {
    Color selectedColor = Colors.blue;
    return showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                selectedColor = color;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Got it'),
              onPressed: () {
                Navigator.of(context).pop(selectedColor);
              },
            ),
          ],
        );
      },
    );
  }
}

```

### layer_model.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\image_editor\models\layer_model.dart

Descricao:

```dart
class LayerModel {
  final String id;
  final String type; // 'image', 'shape', 'text'
  final dynamic data;

  LayerModel({required this.id, required this.type, required this.data});
}

```

### file_picker.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\image_editor\utils\file_picker.dart

Descricao:

```dart
import 'package:file_picker/file_picker.dart';

Future<String?> pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    return result.files.single.path;
  }
  return null;
}

```

### image_operations.dart
Path: D:\Projetos\fuk_ui_kit\lib\src\components\image_editor\utils\image_operations.dart

Descricao:

```dart
import 'package:flutter/material.dart';

class ImageOperations {
  static Widget resizeImage(Widget image, double width, double height) {
    return SizedBox(width: width, height: height, child: image);
  }

  static Widget rotateImage(Widget image, double angle) {
    return Transform.rotate(angle: angle, child: image);
  }

  // Adicionar mais operações conforme necessário
}

```

