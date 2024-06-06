import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';

class FukContentMaster extends StatefulWidget {
  final List<SideBarItems> topItems;
  final List<SideBarItems> bottomItems;
  final Map<String, Widget> routes;
  final String? iconImage;
  final Icon? icon;

  const FukContentMaster({
    super.key,
    required this.topItems,
    required this.bottomItems,
    required this.routes,
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
    if (widget.routes.isNotEmpty) {
      _selectedPage = widget.routes.keys.first;
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
                // onTap: () {
                //   if (listItem.onTap != null) listItem.onTap!();
                //   if (listItem.children != null ||
                //       listItem.children!.isNotEmpty) {
                //     handleTap(listItem);
                //   } else {
                //     _selectPage(listItem.routeName);
                //   }
                // },
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
                // onTap: () {
                //   _selectPage(listItem.routeName);
                //   if (listItem.onTap != null) listItem.onTap!();
                // },
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
    final pageContent = widget.routes[_selectedPage];
    return pageContent ?? const Center(child: Text('Page not found'));
  }
}
