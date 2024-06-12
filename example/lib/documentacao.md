### main.dart

Path: D:\Projetos\fuk_ui_kit\example\lib\main.dart

Descricao:

```dart
import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';
import 'package:fuk_ui_kit_sample/samples/sample_buttons.dart';
import 'package:fuk_ui_kit_sample/samples/sample_grid.dart';
import 'package:fuk_ui_kit_sample/samples/sample_image_editor.dart';
import 'package:fuk_ui_kit_sample/samples/sample_modal.dart';
import 'package:fuk_ui_kit_sample/samples/sample_notify.dart';

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
      },
    );
  }
}

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
      footer: const FukFooter(text: 'Footer Content Dashboard'),
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
      footer: const FukFooter(text: 'Footer Content'),
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
      footer: const FukFooter(text: 'Footer Content'),
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
      footer: const FukFooter(text: 'Footer Content Dashboard'),
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
      footer: const FukFooter(text: 'Footer Content'),
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
