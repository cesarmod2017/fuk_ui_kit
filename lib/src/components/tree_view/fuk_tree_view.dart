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
