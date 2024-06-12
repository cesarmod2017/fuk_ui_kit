import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';
import 'package:fuk_ui_kit_sample/samples/sample_buttons.dart';
import 'package:fuk_ui_kit_sample/samples/sample_grid.dart';
import 'package:fuk_ui_kit_sample/samples/sample_image_editor.dart';
import 'package:fuk_ui_kit_sample/samples/sample_modal.dart';
import 'package:fuk_ui_kit_sample/samples/sample_notify.dart';
import 'package:fuk_ui_kit_sample/samples/sample_textfield.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FukContentMaster(
      //icon: const Icon(Icons.production_quantity_limits),
      topItems: [
        SideBarItems(
          title: 'Buttons',
          routeName: 'buttons',
          leading: const Icon(Icons.smart_button),
          onTap: () {},
        ),
        SideBarItems(
          title: 'Modal',
          routeName: 'modal',
          leading: const Icon(Icons.contacts_outlined),
          onTap: () {},
        ),
        SideBarItems(
          title: 'Notify',
          routeName: 'notify',
          leading: const Icon(Icons.notifications_sharp),
          onTap: () {},
        ),
        SideBarItems(
          title: 'Data Grid',
          routeName: 'grid',
          leading: const Icon(Icons.grid_view),
          onTap: () {},
        ),
        SideBarItems(
          title: 'Image Editor',
          routeName: 'imageeditor',
          leading: const Icon(Icons.picture_in_picture),
          onTap: () {},
        ),
        SideBarItems(
          title: 'Text Field',
          routeName: 'textfield',
          leading: const Icon(Icons.text_fields),
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
      routes: const {
        'buttons': SampleButtonPage(),
        'modal': SampleModalPage(),
        'notify': SampleNotifyPage(),
        'grid': SampleGridPage(),
        'imageeditor': SampleImageEditorPage(),
        'textfield': SampleTextFieldPage(),
      },
    );
  }
}
