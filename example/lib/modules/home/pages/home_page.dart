import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';
import 'package:fuk_ui_kit_sample/app_routes.dart';
import 'package:fuk_ui_kit_sample/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return FukContentMaster(
        //icon: const Icon(Icons.production_quantity_limits),
        topItems: [
          SideBarItems(
            title: 'Login',
            routeName: RoutesPath.login,
            leading: const Icon(Icons.smart_button),
            onTap: () {},
          ),
          SideBarItems(
            title: 'Order',
            routeName: RoutesPath.order,
            leading: const Icon(Icons.contacts_outlined),
            onTap: () {},
          ),
        ],
        bottomItems: [
          SideBarItems(
            leading: const Icon(Icons.exit_to_app),
            routeName: 'logout',
            title: 'Sair',
            onTap: () {},
          ),
        ],
        routesGetx: AppPages.routes,
      );
    });
  }
}
