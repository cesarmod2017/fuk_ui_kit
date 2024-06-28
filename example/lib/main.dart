import 'package:flutter/material.dart';
import 'package:fuk_ui_kit_sample/app_routes.dart';
import 'package:fuk_ui_kit_sample/modules/home/bindings/home_bindings.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      initialRoute: RoutesPath.home,
      initialBinding: HomeBinding(),
    );
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return FukContentMaster(
//       //icon: const Icon(Icons.production_quantity_limits),
//       topItems: [
//         SideBarItems(
//           title: 'Buttons',
//           routeName: 'buttons',
//           leading: const Icon(Icons.smart_button),
//           onTap: () {},
//         ),
//         SideBarItems(
//           title: 'Modal',
//           routeName: 'modal',
//           leading: const Icon(Icons.contacts_outlined),
//           onTap: () {},
//         ),
//         SideBarItems(
//           title: 'Notify',
//           routeName: 'notify',
//           leading: const Icon(Icons.notifications_sharp),
//           onTap: () {},
//         ),
//         SideBarItems(
//           title: 'Data Grid',
//           routeName: 'grid',
//           leading: const Icon(Icons.grid_view),
//           onTap: () {},
//         ),
//         SideBarItems(
//           title: 'Codes',
//           routeName: 'code',
//           leading: const Icon(Icons.code),
//           onTap: () {},
//         ),
//         SideBarItems(
//           title: 'Image Editor',
//           routeName: 'imageeditor',
//           leading: const Icon(Icons.picture_in_picture),
//           onTap: () {},
//         ),
//         SideBarItems(
//           title: 'Text Field',
//           routeName: 'textfield',
//           leading: const Icon(Icons.text_fields),
//           onTap: () {},
//         ),
//         SideBarItems(
//           title: 'Tabs',
//           routeName: 'tabs',
//           leading: const Icon(Icons.tab),
//           onTap: () {},
//         ),
//       ],
//       bottomItems: [
//         SideBarItems(
//           leading: const Icon(Icons.exit_to_app),
//           routeName: 'logout',
//           title: 'Sair',
//           onTap: () {},
//         ),
//       ],
//       routes: const {
//         'buttons': SampleButtonPage(),
//         'modal': SampleModalPage(),
//         'notify': SampleNotifyPage(),
//         'grid': SampleGridPage(),
//         'imageeditor': SampleImageEditorPage(),
//         'textfield': SampleTextFieldPage(),
//         'code': SampleCodesPage(),
//         'tabs': SampleTabsPage(),
//       },
//     );
//   }
// }
