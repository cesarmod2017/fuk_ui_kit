import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/flutter_ui_kit.dart';

class FukSidebar extends StatefulWidget {
  final List<SideBarItems> items;
  final List<SideBarItems>? bottomItems;
  final String? iconImage;
  final Icon? icon;

  const FukSidebar({
    super.key,
    required this.items,
    this.bottomItems,
    this.iconImage,
    this.icon,
  });

  @override
  _FukSidebarState createState() => _FukSidebarState();
}

class _FukSidebarState extends State<FukSidebar> {
  bool _isExpanded = false;

  void _toggleSidebar() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.0,
      height: MediaQuery.of(context).size.height,
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

  Widget _buildItem(SideBarItems item, {int level = 0}) {
    bool hasChildren = item.children != null && item.children!.isNotEmpty;

    return PopupMenuButton<SideBarItems>(
      tooltip: item.title,
      onSelected: (selectedItem) {
        log(selectedItem.routeName);
        if (selectedItem.changePage != null) {
          selectedItem.changePage!();
        } else {
          log('No changePage function found for ${selectedItem.routeName}');
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
