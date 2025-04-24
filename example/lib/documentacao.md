### app_routes.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\app_routes.dart

Descricao:

```dart
import 'package:fuk_ui_kit_sample/modules/home/bindings/home_bindings.dart';
import 'package:fuk_ui_kit_sample/modules/home/pages/home_page.dart';
import 'package:fuk_ui_kit_sample/modules/login/bindings/login_bindings.dart';
import 'package:fuk_ui_kit_sample/modules/login/pages/login_page.dart';
import 'package:fuk_ui_kit_sample/modules/order/bindings/order_bindings.dart';
import 'package:fuk_ui_kit_sample/modules/order/pages/order_page.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
        name: RoutesPath.home,
        page: () => const HomePage(),
        bindings: [HomeBinding()],
        transition: Transition.fadeIn),
    GetPage(
        name: RoutesPath.login,
        page: () => const LoginPage(),
        bindings: [LoginBinding()],
        transition: Transition.fadeIn),
    GetPage(
        name: RoutesPath.order,
        page: () => const OrderPage(),
        bindings: [OrderBinding()],
        transition: Transition.fadeIn),
  ];

  static final routes = {
    for (var e in pages.where((x) => x.name != RoutesPath.home).toList())
      e.name: e
  };
}

abstract class RoutesPath {
  static const String order = '/order';
  static const String home = '/home';
  static const String splashScreen = '/splashScreen';
  static const String basePage = '/';
  static const String login = '/login';
}

```

### main.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\main.dart

Descricao:

```dart
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

```

### sample_buttons.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\samples\sample_buttons.dart

Descricao:

```dart
import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';

class SampleButtonPage extends StatefulWidget {
  const SampleButtonPage({super.key});

  @override
  State<SampleButtonPage> createState() => _SampleButtonPageState();
}

class _SampleButtonPageState extends State<SampleButtonPage> {
  bool _isLoading = false;

  void _simulateLoading() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FukPage(
      header: FukHeader(
        title: 'Sample Buttons',
        // leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle settings button press
            },
          ),
        ],
      ),
      content: FukContent(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const FukLabel(
                text: 'Basic Button:',
                size: FukLabelSize.small,
              ),
              const SizedBox(height: 8),
              FukButton(
                text: 'Submit',
                onPressed: _simulateLoading,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),
              const FukLabel(
                text: 'Button with Icon (Left):',
                size: FukLabelSize.large,
              ),
              const SizedBox(height: 8),
              FukButton(
                text: 'Submit',
                icon: const Icon(
                  Icons.send,
                  size: 16,
                ),
                onPressed: _simulateLoading,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),
              const FukLabel(text: 'Button with Icon (Right):'),
              const SizedBox(height: 8),
              FukButton(
                text: 'Submit',
                icon: const Icon(Icons.send),
                iconOnRight: true,
                onPressed: _simulateLoading,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),
              const FukLabel(text: 'Button with Icon (Below Text):'),
              const SizedBox(height: 8),
              FukButton(
                text: 'Submit',
                icon: const Icon(Icons.send),
                iconBelowText: true,
                onPressed: _simulateLoading,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),
              const FukLabel(text: 'Icon Only Button:'),
              const SizedBox(height: 8),
              FukButton(
                icon: const Icon(Icons.send),
                onPressed: _simulateLoading,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),
              const FukLabel(
                  text: 'Button with Custom Colors and Rounded Border:'),
              const SizedBox(height: 8),
              FukButton(
                text: 'Submit',
                icon: const Icon(Icons.send),
                onPressed: _simulateLoading,
                isLoading: _isLoading,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                borderRadius: 16.0,
              ),
              const SizedBox(height: 16),
              const FukLabel(text: 'Full Width Button:'),
              const SizedBox(height: 8),
              FukButton(
                text: 'Submit',
                onPressed: _simulateLoading,
                isLoading: _isLoading,
                fullWidth: true,
              ),
            ],
          ),
        ),
      ),
      footer: const FukFooter(child: Text('Footer Content')),
    );
  }
}

```

### sample_codes.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\samples\sample_codes.dart

Descricao:

```dart
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';
import 'package:fuk_ui_kit_sample/samples/examples/editor_json.dart';

class SampleCodesPage extends StatefulWidget {
  const SampleCodesPage({super.key});

  @override
  State<SampleCodesPage> createState() => _SampleCodesPageState();
}

class _SampleCodesPageState extends State<SampleCodesPage> {
  static const Map<String, Widget> _editors = {
    'Json Editor': JsonEditor(),
  };

  late int _index = 0;
  @override
  Widget build(BuildContext context) {
    final Widget child = _editors.values.elementAt(_index);
    return FukPage(
      header: FukHeader(
        title: 'Sample Codes',
        // leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle settings button press
            },
          ),
        ],
      ),
      content: FukContent(
        // backgroundColor: const Color(0xFF1E1E1E),
        child: Center(
          child: Column(
            children: [
              Row(
                children: _editors.entries.mapIndexed((index, entry) {
                  return TextButton(
                    onPressed: () {
                      setState(() {
                        _index = index;
                      });
                    },
                    child: Text(
                      entry.key,
                      style: TextStyle(
                          color: _index == index ? null : Colors.black),
                    ),
                  );
                }).toList(),
              ),
              Expanded(
                  child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: child,
              ))
            ],
          ),
        ),
      ),
      footer: const FukFooter(child: Text('Footer Content')),
    );
  }
}

```

### sample_grid.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\samples\sample_grid.dart

Descricao:

```dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';

class SampleGridPage extends StatefulWidget {
  const SampleGridPage({super.key});

  @override
  State<SampleGridPage> createState() => _SampleGridPageState();
}

class _SampleGridPageState extends State<SampleGridPage> {
  int _currentPage = 1;
  int _totalPage = 10;

  final List<DataGridColumn> _columns = [
    DataGridColumn(title: 'ID', width: 50, sortable: false, field: 'id'),
    DataGridColumn(title: 'Name', width: 800, sortable: true, field: 'name'),
    DataGridColumn(title: 'Age', width: 100, sortable: true, field: 'age'),
    DataGridColumn(title: '#', width: 120, sortable: false, field: 'action'),
  ];

  List<Map<String, dynamic>> _data = List.generate(
    100,
    (index) => {
      'id': index + 1,
      'name': 'Name ${index + 1}',
      'age': 20 + (index % 10),
      'action': FukButton(
        text: 'Edit',
        onPressed: () {
          log('Edit button pressed for item $index');
        },
      ),
    },
  );

  void _onPageChange(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _onSort(String field, bool isAscending) {
    setState(() {
      if (isAscending) {
        _data.sort((a, b) => a[field].compareTo(b[field]));
      } else {
        _data.sort((a, b) => b[field].compareTo(a[field]));
      }
    });
  }

  void _onSearch(String query) {
    String date = DateTime.now().toIso8601String();
    setState(() {
      _data = List.generate(
        15,
        (index) => {
          'id': index + 1,
          'name': 'Name ${index + 1} -- $date',
          'age': 20 + (index % 10),
        },
      );
      _totalPage = 5;
      // Implemente a lógica de busca
    });
  }

  void _onAdvancedSearch() {
    // Implemente a lógica de busca avançada
  }

  @override
  Widget build(BuildContext context) {
    return FukPage(
      header: FukHeader(
        title: 'Data Grid Samples',
        // leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle settings button press
            },
          ),
        ],
      ),
      content: FukContent(
        child: FukDataGrid(
          columns: _columns,
          data: _data,
          currentPage: _currentPage,
          totalPage: _totalPage,
          onPageChange: _onPageChange,
          onSort: _onSort,
          onSearch: _onSearch,
          onAdvancedSearch: _onAdvancedSearch,
          showAdvancedSearch: true,
          hoverHighlight: true,
          hintText: 'Pesquisar ....',
          searchWhenTyping: true,
          stripedRows: false,
          showColumnBorders: true,
        ),
      ),
      footer: const FukFooter(child: Text('Footer Content')),
      // aside: Container(
      //   color: Colors.grey[800],
      //   child: const Center(
      //     child: Text('Aside Content'),
      //   ),
      // ),
    );
  }
}

```

### sample_image_editor.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\samples\sample_image_editor.dart

Descricao:

```dart
import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';

class SampleImageEditorPage extends StatefulWidget {
  const SampleImageEditorPage({super.key});

  @override
  State<SampleImageEditorPage> createState() => _SampleImageEditorPageState();
}

class _SampleImageEditorPageState extends State<SampleImageEditorPage> {
  @override
  Widget build(BuildContext context) {
    return FukPage(
      header: FukHeader(
        title: 'Image Editor Sample',
        // leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      content: const FukContent(
        child: FukImageEditor(),
      ),
      footer: const FukFooter(child: Text('Footer Content')),
      // aside: Container(
      //   color: Colors.grey[800],
      //   child: const Center(
      //     child: Text('Aside Content'),
      //   ),
      // ),
    );
  }
}

```

### sample_modal.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\samples\sample_modal.dart

Descricao:

```dart
import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';

class SampleModalPage extends StatefulWidget {
  const SampleModalPage({super.key});

  @override
  State<SampleModalPage> createState() => _SampleModalPageState();
}

class _SampleModalPageState extends State<SampleModalPage> {
  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FukModal(
          title: 'Modal Title',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              100,
              (index) => Text('Item ${index.toString()}'),
            ),
          ),
          // size: FukModalSize.fullscreen,
          leftActions: [
            FukButton(
              text: 'Custom Action',
              onPressed: () {
                // Handle custom action
              },
            ),
          ],
          rightActions: [
            FukButton(
              text: 'Submit',
              onPressed: () {
                // Handle submit action
              },
            ),
            const SizedBox(width: 10),
            FukButton(
              text: 'Cancel',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FukPage(
      header: FukHeader(
        title: 'Sample Modal',
        // leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle settings button press
            },
          ),
        ],
      ),
      content: FukContent(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const FukLabel(
                  text: 'Modal:',
                  size: FukLabelSize.small,
                ),
                FukButton(
                  text: 'Show Modal',
                  onPressed: () => _showModal(context),
                ),
              ],
            ),
          ),
        ),
      ),
      footer: const FukFooter(child: Text('Footer Content')),
    );
  }
}

```

### sample_notify.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\samples\sample_notify.dart

Descricao:

```dart
import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';

class SampleNotifyPage extends StatefulWidget {
  const SampleNotifyPage({super.key});

  @override
  State<SampleNotifyPage> createState() => _SampleNotifyPageState();
}

class _SampleNotifyPageState extends State<SampleNotifyPage> {
  int _counter = 0;
  void _showLoading(BuildContext context) {
    final loading = FukLoading();
    loading.show(
      context: context,
      alignment: _counter == 0
          ? FukLoadingAlignment.bottomRight
          : FukLoadingAlignment.topRight,
      blockScreen: false,
      title: 'Loading...',
      showDelayMessage: true,
      delayDuration: 60,
      delayMessage:
          'This is taking longer than expected. Do you want to cancel?',
      continueButtonText: 'Continue',
      cancelButtonText: 'Fechar',
      onCancel: () {
        loading.hide();
      },
    );

    // Simulate a network request or long running task
    Future.delayed(const Duration(seconds: 10), () {
      loading.hide();
    });

    _counter = _counter + 1;
    if (_counter > 1) _counter = 0;
  }

  void _showNotification(
      BuildContext context, FukNotifyType type, FukNotifyDirection direction) {
    FukNotify.show(
      context: context,
      title: 'Notification Title',
      message: 'This is the detail message for the notification.',
      type: type,
      direction: direction,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FukPage(
      header: FukHeader(
        title: 'Notify Samples',
        // leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle settings button press
            },
          ),
        ],
      ),
      content: FukContent(
        child: Center(
          child: Column(
            children: [
              FukButton(
                text: 'Show Info Notification',
                onPressed: () => _showNotification(
                    context, FukNotifyType.info, FukNotifyDirection.top),
              ),
              const SizedBox(height: 16),
              FukButton(
                text: 'Show Success Notification',
                onPressed: () => _showNotification(
                    context, FukNotifyType.success, FukNotifyDirection.bottom),
              ),
              const SizedBox(height: 16),
              FukButton(
                text: 'Show Warning Notification',
                onPressed: () => _showNotification(
                    context, FukNotifyType.warning, FukNotifyDirection.top),
              ),
              const SizedBox(height: 16),
              FukButton(
                text: 'Show Error Notification',
                onPressed: () => _showNotification(
                    context, FukNotifyType.error, FukNotifyDirection.top),
              ),
              const SizedBox(height: 16),
              FukButton(
                text: 'Show Default Notification',
                onPressed: () => _showNotification(context,
                    FukNotifyType.defaultType, FukNotifyDirection.bottom),
              ),
              const SizedBox(height: 16),
              FukButton(
                text: 'Show Loading',
                onPressed: () => _showLoading(context),
              )
            ],
          ),
        ),
      ),
      footer: const FukFooter(child: Text('Footer Content')),
      aside: Container(
        color: Colors.grey[800],
        child: const Center(
          child: Text('Aside Content'),
        ),
      ),
    );
  }
}

```

### sample_tabs.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\samples\sample_tabs.dart

Descricao:

```dart
import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';

class SampleTabsPage extends StatefulWidget {
  const SampleTabsPage({super.key});

  @override
  State<SampleTabsPage> createState() => _SampleTabsPageState();
}

class _SampleTabsPageState extends State<SampleTabsPage>
    with SingleTickerProviderStateMixin {
  final List<FukTabView> tabs = [];
  late TabController tabControler;
  @override
  void initState() {
    super.initState();
    tabControler = TabController(length: 4, vsync: this);
    loadTabs();
  }

  void loadTabs() {
    for (var i = 1; i < 5; i++) {
      tabs.add(
        FukTabView(
          index: i,
          title: "Arquivo_$i.dart",
          child: FukButton(
            text: "Tab $i",
            onPressed: () => addTab(),
          ),
          onClose: (int idx) {
            setState(() {
              tabs.removeWhere((element) => element.index == idx);
            });
          },
        ),
      );
    }
    tabs.add(
      FukTabView(
        index: 9999,
        onNewTab: () {
          setState(() {
            addTab();
          });
        },
      ),
    );
    setState(() {
      tabs.sort((a, b) => a.index.compareTo(b.index));
    });
  }

  void addTab() {
    tabs.add(
      FukTabView(
        index: tabs.length,
        title: "Arquivo_${tabs.length}.dart",
        child: Center(
          child: FukButton(
            text: "Tab ${tabs.length}",
            onPressed: () => addTab(),
          ),
        ),
        onClose: (int idx) {
          setState(() {
            tabs.removeWhere((element) => element.index == idx);
          });
        },
      ),
    );
    tabs.sort((a, b) => a.index.compareTo(b.index));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0,
      child: FukPage(
        header: FukHeader(
          title: 'Tabs Samples',
          // leading: const Icon(Icons.menu),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Handle settings button press
              },
            ),
          ],
          bottom: TabBar(
            tabs: tabs.map((tab) => tab.tab).toList(),
            indicatorColor: Colors.blue,
            isScrollable: true,
          ),
        ),
        content: FukContent(
          child: TabBarView(
            children: tabs.map((tab) => tab.view).toList(),
          ),
        ),
        footer: const FukFooter(child: Text('Footer Content')),
        // aside: Container(
        //   color: Colors.grey[800],
        //   child: const Center(
        //     child: Text('Aside Content'),
        //   ),
        // ),
      ),
    );
  }
}

```

### sample_textfield.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\samples\sample_textfield.dart

Descricao:

```dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';

class SampleTextFieldPage extends StatefulWidget {
  const SampleTextFieldPage({super.key});

  @override
  State<SampleTextFieldPage> createState() => _SampleTextFieldPageState();
}

class _SampleTextFieldPageState extends State<SampleTextFieldPage> {
  @override
  Widget build(BuildContext context) {
    return FukPage(
      header: FukHeader(
        title: 'Sample Text Field',
        // leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle settings button press
            },
          ),
        ],
      ),
      content: FukContent(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const FukLabel(
                  text: 'Modal:',
                  size: FukLabelSize.small,
                ),
                const FukTextFile(
                  isRequired: true,
                  allowedFileTypes: [
                    AllowedFileType.imagePng,
                    AllowedFileType.imageJpg
                  ],
                ),
                const SizedBox(height: 20),
                const FukTextFile(
                  isRequired: true,
                  allowedFileTypes: [
                    AllowedFileType.imagePng,
                    AllowedFileType.imageJpg
                  ],
                  label: 'Select an Image',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Image',
                  ),
                ),
                const SizedBox(height: 20),
                const FukTextFile(
                  isRequired: false,
                  allowedFileTypes: [
                    AllowedFileType.documentDocx,
                    AllowedFileType.documentPdf
                  ],
                  icon: Icon(Icons.file_open),
                  label: 'Select a Document',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                const FukTextFile(
                  isRequired: true,
                  allowedFileTypes: [AllowedFileType.folder],
                  icon: Icon(Icons.folder),
                  label: 'Select a Folder',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const FukTextField(
                  label: 'Name',
                  placeholder: 'Enter your name',
                  isRequired: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                FukTextField(
                  label: 'Email',
                  placeholder: 'Enter your email',
                  isRequired: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  icon: const Icon(Icons.email),
                  onIconPressed: () {
                    // Custom action for icon
                    log('Email icon pressed');
                  },
                ),
                const SizedBox(height: 20),
                FukTextField(
                  label: 'Password',
                  placeholder: 'Enter your password',
                  isRequired: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  isPassword: true,
                  isObscure: true,
                  onIconPressed: () {
                    // Custom action for icon
                    log('Visibility icon pressed');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      footer: const FukFooter(child: Text('Footer Content')),
    );
  }
}

```

### editor_json.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\samples\examples\editor_json.dart

Descricao:

```dart
import 'dart:math';

import 'package:dart_style/dart_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuk_ui_kit_sample/samples/examples/find.dart';
import 'package:fuk_ui_kit_sample/samples/examples/menu.dart';
import 'package:re_editor/re_editor.dart';
import 'package:re_highlight/languages/dart.dart';
import 'package:re_highlight/styles/github-dark.dart';

const List<CodePrompt> _kStringPrompts = [
  CodeFieldPrompt(word: 'length', type: 'int'),
  CodeFieldPrompt(word: 'isEmpty', type: 'bool'),
  CodeFieldPrompt(word: 'isNotEmpty', type: 'bool'),
  CodeFieldPrompt(word: 'characters', type: 'Characters'),
  CodeFieldPrompt(word: 'hashCode', type: 'int'),
  CodeFieldPrompt(word: 'codeUnits', type: 'List<int>'),
  CodeFieldPrompt(word: 'runes', type: 'Runes'),
  CodeFunctionPrompt(
      word: 'codeUnitAt', type: 'int', parameters: {'index': 'int'}),
  CodeFunctionPrompt(word: 'replaceAll', type: 'String', parameters: {
    'from': 'Pattern',
    'replace': 'String',
  }),
  CodeFunctionPrompt(word: 'contains', type: 'bool', parameters: {
    'other': 'String',
  }),
  CodeFunctionPrompt(word: 'split', type: 'List<String>', parameters: {
    'pattern': 'Pattern',
  }),
  CodeFunctionPrompt(word: 'endsWith', type: 'bool', parameters: {
    'other': 'String',
  }),
  CodeFunctionPrompt(word: 'startsWith', type: 'bool', parameters: {
    'other': 'String',
  })
];

class JsonEditor extends StatefulWidget {
  const JsonEditor({super.key});

  @override
  State<StatefulWidget> createState() => _JsonEditorState();
}

class _JsonEditorState extends State<JsonEditor> {
  final CodeLineEditingController _controller = CodeLineEditingController();

  @override
  void initState() {
    rootBundle.loadString('assets/code.dart').then((value) {
      _controller.text = value;
    });
    super.initState();
  }

  String formatDartCode(String code) {
    final formatter = DartFormatter();
    try {
      return formatter.format(code);
    } catch (e) {
      print('Erro ao formatar o código: $e');
      return code;
    }
  }

  final FocusNode _focusNode = FocusNode();
  bool _altPressed = false;

  setNewText(String newValue) {
    final currentSelection = _controller.selection;
    CodeLines codeLines = _controller.value.codeLines;

    if (currentSelection.startIndex != currentSelection.endIndex) {
      return;
    }

    final currentText = codeLines[currentSelection.startIndex];
    final newText = currentText.text.replaceRange(
        currentSelection.startOffset, currentSelection.endOffset, newValue);

    codeLines[currentSelection.startIndex] = CodeLine(newText);
    _controller.cancelSelection();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: (KeyEvent event) async {
        if (event is KeyDownEvent) {
          // Verifique se a tecla Alt está pressionada
          if (event.logicalKey == LogicalKeyboardKey.altLeft ||
              event.logicalKey == LogicalKeyboardKey.altRight) {
            _altPressed = true;
          }

          // Verifique se a tecla "1" está pressionada enquanto Alt está pressionada
          if (_altPressed && event.logicalKey == LogicalKeyboardKey.digit1) {
            // Coloque aqui o código que deve ser executado quando Alt + 1 é pressionado

            setNewText("@@namespace@@");
          } else if (_altPressed &&
              event.logicalKey == LogicalKeyboardKey.digit2) {
            // Coloque aqui o código que deve ser executado quando Alt + 1 é pressionado

            setNewText("@@TitleMin@@");
          } else if (_altPressed &&
              event.logicalKey == LogicalKeyboardKey.digit3) {
            final newCode = formatDartCode(_controller.text);
            _controller.text = newCode;
          }
        } else if (event is KeyUpEvent) {
          // Verifique se a tecla Alt foi liberada
          if (event.logicalKey == LogicalKeyboardKey.altLeft ||
              event.logicalKey == LogicalKeyboardKey.altRight) {
            _altPressed = false;
          }
        }
      },
      child: CodeAutocomplete(
          viewBuilder: (context, notifier, onSelected) {
            return _DefaultCodeAutocompleteListView(
              notifier: notifier,
              onSelected: onSelected,
            );
          },
          promptsBuilder: DefaultCodeAutocompletePromptsBuilder(
            language: langDart,
            directPrompts: [
              CodeFieldPrompt(
                  word: 'title',
                  type: 'String',
                  customAutocomplete: CodeAutocompleteResult(
                      text: "title@",
                      selection: TextSelection(
                          baseOffset: _controller.selection.baseOffset,
                          extentOffset: _controller.selection.extentOffset))),
              const CodeFunctionPrompt(
                  word: 'hello',
                  type: 'void',
                  parameters: {
                    'value': 'String',
                    'id': 'int',
                  })
            ],
            relatedPrompts: {
              'foo': _kStringPrompts,
              'bar': _kStringPrompts,
            },
          ),
          child: CodeEditor(
            style: CodeEditorStyle(
              fontSize: 18,
              codeTheme: CodeHighlightTheme(
                  languages: {'dart': CodeHighlightThemeMode(mode: langDart)},
                  theme: githubDarkTheme),
            ),
            controller: _controller,
            wordWrap: false,
            indicatorBuilder:
                (context, editingController, chunkController, notifier) {
              return Row(
                children: [
                  DefaultCodeLineNumber(
                    controller: editingController,
                    notifier: notifier,
                  ),
                  DefaultCodeChunkIndicator(
                      width: 20,
                      controller: chunkController,
                      notifier: notifier)
                ],
              );
            },
            findBuilder: (context, controller, readOnly) =>
                CodeFindPanelView(controller: controller, readOnly: readOnly),
            toolbarController: const ContextMenuControllerImpl(),
            sperator: Container(width: 1, color: Colors.blue),
          )),
    );
  }
}

class _DefaultCodeAutocompleteListView extends StatefulWidget
    implements PreferredSizeWidget {
  static const double kItemHeight = 26;

  final ValueNotifier<CodeAutocompleteEditingValue> notifier;
  final ValueChanged<CodeAutocompleteResult> onSelected;

  const _DefaultCodeAutocompleteListView({
    required this.notifier,
    required this.onSelected,
  });

  @override
  Size get preferredSize => Size(
      250,
      // 2 is border size
      min(kItemHeight * notifier.value.prompts.length, 150) + 2);

  @override
  State<StatefulWidget> createState() =>
      _DefaultCodeAutocompleteListViewState();
}

class _DefaultCodeAutocompleteListViewState
    extends State<_DefaultCodeAutocompleteListView> {
  @override
  void initState() {
    widget.notifier.addListener(_onValueChanged);
    super.initState();
  }

  @override
  void dispose() {
    widget.notifier.removeListener(_onValueChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints.loose(widget.preferredSize),
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(6)),
        child: AutoScrollListView(
          controller: ScrollController(),
          initialIndex: widget.notifier.value.index,
          scrollDirection: Axis.vertical,
          itemCount: widget.notifier.value.prompts.length,
          itemBuilder: (context, index) {
            final CodePrompt prompt = widget.notifier.value.prompts[index];
            final BorderRadius radius = BorderRadius.only(
              topLeft: index == 0 ? const Radius.circular(5) : Radius.zero,
              topRight: index == 0 ? const Radius.circular(5) : Radius.zero,
              bottomLeft: index == widget.notifier.value.prompts.length - 1
                  ? const Radius.circular(5)
                  : Radius.zero,
              bottomRight: index == widget.notifier.value.prompts.length - 1
                  ? const Radius.circular(5)
                  : Radius.zero,
            );
            return InkWell(
                borderRadius: radius,
                onTap: () {
                  widget.onSelected(widget.notifier.value
                      .copyWith(index: index)
                      .autocomplete);
                },
                child: Container(
                  width: double.infinity,
                  height: _DefaultCodeAutocompleteListView.kItemHeight,
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: index == widget.notifier.value.index
                          ? const Color.fromARGB(255, 255, 140, 0)
                          : null,
                      borderRadius: radius),
                  child: RichText(
                    text:
                        prompt.createSpan(context, widget.notifier.value.input),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ));
          },
        ));
  }

  void _onValueChanged() {
    setState(() {});
  }
}

extension _CodePromptExtension on CodePrompt {
  InlineSpan createSpan(BuildContext context, String input) {
    const TextStyle style = TextStyle();
    final InlineSpan span = style.createSpan(
      value: word,
      anchor: input,
      color: Colors.blue,
      fontWeight: FontWeight.bold,
    );
    final CodePrompt prompt = this;
    if (prompt is CodeFieldPrompt) {
      return TextSpan(children: [
        span,
        TextSpan(
            text: ' ${prompt.type}', style: style.copyWith(color: Colors.cyan))
      ]);
    }
    if (prompt is CodeFunctionPrompt) {
      return TextSpan(children: [
        span,
        TextSpan(
            text: '(...) -> ${prompt.type}',
            style: style.copyWith(color: Colors.cyan))
      ]);
    }
    return span;
  }
}

extension _TextStyleExtension on TextStyle {
  InlineSpan createSpan({
    required String value,
    required String anchor,
    required Color color,
    FontWeight? fontWeight,
    bool casesensitive = false,
  }) {
    if (anchor.isEmpty) {
      return TextSpan(
        text: value,
        style: this,
      );
    }
    final int index;
    if (casesensitive) {
      index = value.indexOf(anchor);
    } else {
      index = value.toLowerCase().indexOf(anchor.toLowerCase());
    }
    if (index < 0) {
      return TextSpan(
        text: value,
        style: this,
      );
    }
    return TextSpan(children: [
      TextSpan(text: value.substring(0, index), style: this),
      TextSpan(
          text: value.substring(index, index + anchor.length),
          style: copyWith(
            color: color,
            fontWeight: fontWeight,
          )),
      TextSpan(text: value.substring(index + anchor.length), style: this)
    ]);
  }
}

class AutoScrollListView extends StatefulWidget {
  final ScrollController controller;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final int initialIndex;
  final Axis scrollDirection;

  const AutoScrollListView({
    super.key,
    required this.controller,
    required this.itemBuilder,
    required this.itemCount,
    this.initialIndex = 0,
    this.scrollDirection = Axis.vertical,
  });

  @override
  State<StatefulWidget> createState() => _AutoScrollListViewState();
}

class _AutoScrollListViewState extends State<AutoScrollListView> {
  late final List<GlobalKey> _keys;

  @override
  void initState() {
    _keys = List.generate(widget.itemCount, (index) => GlobalKey());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoScroll();
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AutoScrollListView oldWidget) {
    if (widget.itemCount > oldWidget.itemCount) {
      _keys.addAll(List.generate(
          widget.itemCount - oldWidget.itemCount, (index) => GlobalKey()));
    } else if (widget.itemCount < oldWidget.itemCount) {
      _keys.sublist(oldWidget.itemCount - widget.itemCount);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoScroll();
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];
    for (int i = 0; i < widget.itemCount; i++) {
      widgets.add(Container(
        key: _keys[i],
        child: widget.itemBuilder(context, i),
      ));
    }
    return SingleChildScrollView(
      controller: widget.controller,
      scrollDirection: widget.scrollDirection,
      child: isHorizontal
          ? Row(
              children: widgets,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widgets,
            ),
    );
  }

  void _autoScroll() {
    final ScrollController controller = widget.controller;
    if (!controller.hasClients) {
      return;
    }
    if (controller.position.maxScrollExtent == 0) {
      return;
    }
    double pre = 0;
    double cur = 0;
    for (int i = 0; i < _keys.length; i++) {
      final RenderObject? obj = _keys[i].currentContext?.findRenderObject();
      if (obj == null || obj is! RenderBox) {
        continue;
      }
      if (isHorizontal) {
        double width = obj.size.width;
        if (i == widget.initialIndex) {
          cur = pre + width;
          break;
        }
        pre += width;
      } else {
        double height = obj.size.height;
        if (i == widget.initialIndex) {
          cur = pre + height;
          break;
        }
        pre += height;
      }
    }
    if (pre == cur) {
      return;
    }
    if (pre < widget.controller.offset) {
      controller.jumpTo(pre - 1);
    } else if (cur >
        controller.offset + controller.position.viewportDimension) {
      controller.jumpTo(cur - controller.position.viewportDimension);
    }
  }

  bool get isHorizontal => widget.scrollDirection == Axis.horizontal;
}

```

### find.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\samples\examples\find.dart

Descricao:

```dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:re_editor/re_editor.dart';

const EdgeInsetsGeometry _kDefaultFindMargin = EdgeInsets.only(right: 10);
const double _kDefaultFindPanelWidth = 360;
const double _kDefaultFindPanelHeight = 36;
const double _kDefaultReplacePanelHeight = _kDefaultFindPanelHeight * 2;
const double _kDefaultFindIconSize = 16;
const double _kDefaultFindIconWidth = 30;
const double _kDefaultFindIconHeight = 30;
const double _kDefaultFindInputFontSize = 13;
const double _kDefaultFindResultFontSize = 12;
const EdgeInsetsGeometry _kDefaultFindPadding =
    EdgeInsets.only(left: 5, right: 5, top: 2.5, bottom: 2.5);
const EdgeInsetsGeometry _kDefaultFindInputContentPadding = EdgeInsets.only(
  left: 5,
  right: 5,
);

class CodeFindPanelView extends StatelessWidget implements PreferredSizeWidget {
  final CodeFindController controller;
  final EdgeInsetsGeometry margin;
  final bool readOnly;
  final Color? iconColor;
  final Color? iconSelectedColor;
  final double iconSize;
  final double inputFontSize;
  final double resultFontSize;
  final Color? inputTextColor;
  final Color? resultFontColor;
  final EdgeInsetsGeometry padding;
  final InputDecoration decoration;

  const CodeFindPanelView(
      {super.key,
      required this.controller,
      this.margin = _kDefaultFindMargin,
      required this.readOnly,
      this.iconSelectedColor,
      this.iconColor,
      this.iconSize = _kDefaultFindIconSize,
      this.inputFontSize = _kDefaultFindInputFontSize,
      this.resultFontSize = _kDefaultFindResultFontSize,
      this.inputTextColor,
      this.resultFontColor,
      this.padding = _kDefaultFindPadding,
      this.decoration = const InputDecoration(
        filled: true,
        contentPadding: _kDefaultFindInputContentPadding,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)), gapPadding: 0),
      )});

  @override
  Size get preferredSize => Size(
      double.infinity,
      controller.value == null
          ? 0
          : ((controller.value!.replaceMode
                  ? _kDefaultReplacePanelHeight
                  : _kDefaultFindPanelHeight) +
              margin.vertical));

  @override
  Widget build(BuildContext context) {
    if (controller.value == null) {
      return const SizedBox(width: 0, height: 0);
    }
    return Container(
        margin: margin,
        alignment: Alignment.topRight,
        height: preferredSize.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: _kDefaultFindPanelWidth,
            child: Column(
              children: [
                _buildFindInputView(context),
                if (controller.value!.replaceMode)
                  _buildReplaceInputView(context),
              ],
            ),
          ),
        ));
  }

  Widget _buildFindInputView(BuildContext context) {
    final CodeFindValue value = controller.value!;
    final String result;
    if (value.result == null) {
      result = 'none';
    } else {
      result = '${value.result!.index + 1}/${value.result!.matches.length}';
    }
    return Row(
      children: [
        SizedBox(
            width: _kDefaultFindPanelWidth / 1.75,
            height: _kDefaultFindPanelHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildTextField(
                    context: context,
                    controller: controller.findInputController,
                    focusNode: controller.findInputFocusNode,
                    iconsWidth: _kDefaultFindIconWidth * 1.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildCheckText(
                        context: context,
                        text: 'Aa',
                        checked: value.option.caseSensitive,
                        onPressed: () {
                          controller.toggleCaseSensitive();
                        }),
                    _buildCheckText(
                        context: context,
                        text: '.*',
                        checked: value.option.regex,
                        onPressed: () {
                          controller.toggleRegex();
                        })
                  ],
                )
              ],
            )),
        Text(result,
            style: TextStyle(color: resultFontColor, fontSize: resultFontSize)),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildIconButton(
                  onPressed: value.result == null
                      ? null
                      : () {
                          controller.previousMatch();
                        },
                  icon: Icons.arrow_upward,
                  tooltip: 'Previous'),
              _buildIconButton(
                  onPressed: value.result == null
                      ? null
                      : () {
                          controller.nextMatch();
                        },
                  icon: Icons.arrow_downward,
                  tooltip: 'Next'),
              _buildIconButton(
                  onPressed: () {
                    controller.close();
                  },
                  icon: Icons.close,
                  tooltip: 'Close')
            ],
          ),
        )
      ],
    );
  }

  Widget _buildReplaceInputView(BuildContext context) {
    final CodeFindValue value = controller.value!;
    return Row(
      children: [
        SizedBox(
          width: _kDefaultFindPanelWidth / 1.75,
          height: _kDefaultFindPanelHeight,
          child: _buildTextField(
            context: context,
            controller: controller.replaceInputController,
            focusNode: controller.replaceInputFocusNode,
          ),
        ),
        _buildIconButton(
            onPressed: value.result == null
                ? null
                : () {
                    controller.replaceMatch();
                  },
            icon: Icons.done,
            tooltip: 'Replace'),
        _buildIconButton(
            onPressed: value.result == null
                ? null
                : () {
                    controller.replaceAllMatches();
                  },
            icon: Icons.done_all,
            tooltip: 'Replace All')
      ],
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required FocusNode focusNode,
    double iconsWidth = 0,
  }) {
    return Padding(
      padding: padding,
      child: TextField(
        maxLines: 1,
        focusNode: focusNode,
        style: TextStyle(color: inputTextColor, fontSize: inputFontSize),
        decoration: decoration.copyWith(
            contentPadding: (decoration.contentPadding ?? EdgeInsets.zero)
                .add(EdgeInsets.only(right: iconsWidth))),
        controller: controller,
      ),
    );
  }

  Widget _buildCheckText({
    required BuildContext context,
    required String text,
    required bool checked,
    required VoidCallback onPressed,
  }) {
    final Color selectedColor =
        iconSelectedColor ?? Theme.of(context).primaryColor;
    return GestureDetector(
        onTap: onPressed,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: SizedBox(
            width: _kDefaultFindIconWidth * 0.75,
            child: Text(text,
                style: TextStyle(
                  color: checked ? selectedColor : iconColor,
                  fontSize: inputFontSize,
                )),
          ),
        ));
  }

  Widget _buildIconButton(
      {required IconData icon, VoidCallback? onPressed, String? tooltip}) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: iconSize,
      ),
      constraints: const BoxConstraints(
          maxWidth: _kDefaultFindIconWidth, maxHeight: _kDefaultFindIconHeight),
      tooltip: tooltip,
      splashRadius: max(_kDefaultFindIconWidth, _kDefaultFindIconHeight) / 2,
    );
  }
}

```

### menu.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\samples\examples\menu.dart

Descricao:

```dart
import 'package:flutter/material.dart';
import 'package:re_editor/re_editor.dart';

class ContextMenuItemWidget extends PopupMenuItem<void>
    implements PreferredSizeWidget {
  ContextMenuItemWidget({
    super.key,
    required String text,
    required VoidCallback super.onTap,
  }) : super(child: Text(text));

  @override
  Size get preferredSize => const Size(150, 25);
}

class ContextMenuControllerImpl implements SelectionToolbarController {
  const ContextMenuControllerImpl();

  @override
  void hide(BuildContext context) {}

  @override
  void show({
    required BuildContext context,
    required CodeLineEditingController controller,
    required TextSelectionToolbarAnchors anchors,
    Rect? renderRect,
    required LayerLink layerLink,
    required ValueNotifier<bool> visibility,
  }) {
    showMenu(
        context: context,
        position: RelativeRect.fromSize(
            anchors.primaryAnchor & const Size(150, double.infinity),
            MediaQuery.of(context).size),
        items: [
          ContextMenuItemWidget(
            text: 'Cut',
            onTap: () {
              controller.cut();
            },
          ),
          ContextMenuItemWidget(
            text: 'Copy',
            onTap: () {
              controller.copy();
            },
          ),
          ContextMenuItemWidget(
            text: 'Paste',
            onTap: () {
              controller.paste();
            },
          ),
        ]);
  }
}

```

### home_bindings.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\modules\home\bindings\home_bindings.dart

Descricao:

```dart
import 'package:fuk_ui_kit_sample/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController(), permanent: true);
  }
}

```

### home_controller.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\modules\home\controller\home_controller.dart

Descricao:

```dart
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeController();
}

```

### home_page.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\modules\home\pages\home_page.dart

Descricao:

```dart
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

```

### login_bindings.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\modules\login\bindings\login_bindings.dart

Descricao:

```dart
import 'package:fuk_ui_kit_sample/modules/login/controller/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
  }
}

```

### login_controller.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\modules\login\controller\login_controller.dart

Descricao:

```dart
import 'package:get/get.dart';

class LoginController extends GetxController {
  LoginController();
}

```

### login_page.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\modules\login\pages\login_page.dart

Descricao:

```dart
import 'package:flutter/material.dart';
import 'package:fuk_ui_kit_sample/modules/login/controller/login_controller.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Login",
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: const Column(
          children: [
            Center(
              child: Text("Login"),
            ),
          ],
        ),
      );
    });
  }
}

```

### order_bindings.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\modules\order\bindings\order_bindings.dart

Descricao:

```dart
import 'package:fuk_ui_kit_sample/modules/order/controller/order_controller.dart';
import 'package:get/get.dart';

class OrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() => OrderController(), fenix: true);
  }
}

```

### order_controller.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\modules\order\controller\order_controller.dart

Descricao:

```dart
import 'package:get/get.dart';

class OrderController extends GetxController {
  OrderController();
}

```

### order_page.dart
Path: D:\Projetos\fuk_ui_kit\example\lib\modules\order\pages\order_page.dart

Descricao:

```dart
import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';
import 'package:fuk_ui_kit_sample/modules/order/controller/order_controller.dart';
import 'package:get/get.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final FukTreeViewController _controller = FukTreeViewController();

  final List<FukTreeViewItem> _items = [
    FukTreeViewItem(
      title: 'Raiz',
      isFolder: true,
      children: [
        FukTreeViewItem(
          title: 'Pasta 1',
          isFolder: true,
          children: [
            FukTreeViewItem(title: 'Arquivo 1', icon: const Icon(Icons.image)),
            FukTreeViewItem(
                title: 'Arquivo 2',
                isReadOnly: true,
                icon: const Icon(Icons.insert_drive_file)),
          ],
        ),
        FukTreeViewItem(
          title: 'Pasta 2',
          isFolder: true,
          children: [
            FukTreeViewItem(
                title: 'Arquivo 3',
                icon: const Icon(
                  Icons.picture_as_pdf,
                  color: Colors.green,
                )),
            FukTreeViewItem(
                title: 'Arquivo 4',
                icon: const Icon(
                  Icons.music_note,
                  color: Colors.red,
                )),
            FukTreeViewItem(
              title: 'Pasta 3',
              isFolder: true,
              children: [
                FukTreeViewItem(
                    title: 'Arquivo 5', icon: const Icon(Icons.video_library)),
                FukTreeViewItem(
                    title: 'Arquivo 6', icon: const Icon(Icons.code)),
              ],
            ),
          ],
        ),
      ],
    ),
  ];

  void _onSelectionChanged(List<FukTreeViewItem> selectedItems) {
    print(
        'Selected Items: ${selectedItems.map((item) => item.title).join(', ')}');
  }

  void _onOptionSelected(FukTreeViewItem item) {
    print('Option selected for item: ${item.title}');
  }

  void _loadJson() {
    String json =
        '[{"id":"1","title":"Raiz","isFolder":true,"isReadOnly":false,"children":[{"id":"2","title":"Pasta 1","isFolder":true,"isReadOnly":false,"children":[{"id":"3","title":"Arquivo 1","isFolder":false,"isReadOnly":false,"children":[],"icon":58372},{"id":"4","title":"Arquivo 2","isFolder":false,"isReadOnly":true,"children":[],"icon":57770},{"id":"6","title":"Arquivo 3","isFolder":false,"isReadOnly":false,"children":[],"icon":59668}],"icon":null},{"id":"5","title":"Pasta 2","isFolder":true,"isReadOnly":false,"children":[{"id":"7","title":"Arquivo 4","isFolder":false,"isReadOnly":false,"children":[],"icon":57360}],"icon":null}],"icon":null}]';
    _controller.loadFromJson(json);
    setState(() {});
  }

  void _generateJson() {
    String json = _controller.generateJson();
    print('Generated JSON: $json');
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Order",
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: _loadJson,
              child: const Text('Load JSON'),
            ),
            ElevatedButton(
              onPressed: _generateJson,
              child: const Text('Generate JSON'),
            ),
            Expanded(
              child: FukTreeView(
                items: _controller.items.isEmpty ? _items : _controller.items,
                showCheckbox: true,
                initiallyExpanded: true,
                onSelectionChanged: _onSelectionChanged,
                sortAlphabetically: true,
                options: [
                  FukTreeViewOption(
                    title: 'Duplicar',
                    icon: Icons.copy,
                    onTap: _onOptionSelected,
                  ),
                  FukTreeViewOption(
                    title: 'Excluir',
                    icon: Icons.delete,
                    onTap: _onOptionSelected,
                  ),
                ],
                controller: _controller,
              ),
            ),
          ],
        ),
      );
    });
  }
}

```

