import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/flutter_ui_kit.dart';

class FukSidebar extends StatefulWidget {
  final List<SideBarItems> items;
  final List<SideBarItems>? bottomItems;

  const FukSidebar({
    super.key,
    required this.items,
    this.bottomItems,
  });

  @override
  _FukSidebarState createState() => _FukSidebarState();
}

class _FukSidebarState extends State<FukSidebar> {
  bool _isExpanded = true;
  final Map<String, bool> _expandedState = {};

  void _toggleSidebar() {
    if (mounted) {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  void _toggleExpanded(String key) {
    if (mounted) {
      setState(() {
        _expandedState[key] = !(_expandedState[key] ?? false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _isExpanded ? 250.0 : 70.0,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
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
          IconButton(
            icon: Icon(_isExpanded ? Icons.menu_open : Icons.menu),
            onPressed: _toggleSidebar,
          ),
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

  Widget _buildItem(SideBarItems item, {int level = 0}) {
    bool hasChildren = item.children != null && item.children!.isNotEmpty;
    bool isExpanded = _expandedState[item.title] ?? false;

    return Column(
      children: [
        _isExpanded
            ? ListTile(
                leading: SizedBox(
                  width: 40.0, // Ajuste este valor conforme necessário
                  child: item.leading,
                ),
                title: _isExpanded ? Text(item.title) : null,
                onTap: () {
                  if (item.onTap != null) item.onTap!();
                  if (item.changePage != null) item.changePage!();
                  if (hasChildren) _toggleExpanded(item.title);
                },
                trailing: hasChildren
                    ? Icon(isExpanded ? Icons.expand_less : Icons.expand_more)
                    : null,
              )
            : level > 0
                ? const SizedBox.shrink()
                : Theme(
                    data: Theme.of(context).copyWith(
                      tooltipTheme: Theme.of(context).tooltipTheme.copyWith(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                    ),
                    child: Tooltip(
                      message: item.title.toString(),
                      child: GestureDetector(
                        onTap: () {
                          if (item.onTap != null) item.onTap!();
                          if (item.changePage != null) item.changePage!();
                          //aqui se o isExpanded for false, ele vai abrir o popup context menu dos children
                          if (!isExpanded && hasChildren) {
                            PopupMenuButton<String>(
                              onSelected: (String result) {
                                setState(() {});
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: "String1",
                                  child: Text('Option 1'),
                                ),
                                const PopupMenuItem<String>(
                                  value: "String2",
                                  child: Text('Option 2'),
                                ),
                              ],
                            );
                          }
                        },
                        child: item.leading as Icon,
                      ),
                    ),
                  ),
        if (hasChildren && isExpanded)
          Padding(
            padding: EdgeInsets.only(left: _isExpanded ? 16.0 : 0.0),
            child: Column(
              children: item.children!
                  .map((child) => _buildItem(child, level: level + 1))
                  .toList(),
            ),
          ),
      ],
    );
  }
}
