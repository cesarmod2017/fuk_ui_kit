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
