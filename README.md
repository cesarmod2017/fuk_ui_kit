# Flutter UI Kit

A Flutter UI Kit for desktop and web applications.

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  fuk_ui_kit: ^0.0.1
```

### Usage

Import the Package

```dart
import 'package:fuk_ui_kit/fuk_ui_kit.dart';
```

### FukSidebar

The FukSidebar widget allows you to create a sidebar with hierarchical menu items.

## Example

```dart
import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          FukSidebar(
            items: [
              SideBarItems(
                title: 'Dashboard',
                leading: const Icon(Icons.dashboard),
                changePage: () {
                  // Handle navigation or state change here
                },
              ),
              SideBarItems(
                title: 'Profile',
                leading: const Icon(Icons.person),
                children: [
                  SideBarItems(
                    title: 'Profile 1',
                    leading: const Icon(Icons.person_outline),
                    changePage: () {
                      // Handle navigation or state change here
                    },
                  ),
                  SideBarItems(
                    title: 'Profile 2',
                    leading: const Icon(Icons.person_outline),
                    children: [
                      SideBarItems(
                        title: 'Profile 2.1',
                        leading: const Icon(Icons.person_add),
                        changePage: () {
                          // Handle navigation or state change here
                        },
                      ),
                      SideBarItems(
                        title: 'Profile 2.2',
                        leading: const Icon(Icons.person_add),
                        changePage: () {
                          // Handle navigation or state change here
                        },
                      ),
                    ],
                  ),
                  SideBarItems(
                    title: 'Profile 3',
                    leading: const Icon(Icons.person_outline),
                    changePage: () {
                      // Handle navigation or state change here
                    },
                  ),
                ],
              ),
            ],
            bottomItems: [
              SideBarItems(
                title: 'Minha Conta',
                leading: const Icon(Icons.account_circle),
                changePage: () {
                  // Handle navigation or state change here
                },
              ),
              SideBarItems(
                title: 'Sair',
                leading: const Icon(Icons.exit_to_app),
                changePage: () {
                  // Handle navigation or state change aqui
                },
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Text('Select an option from the sidebar'),
            ),
          ),
        ],
      ),
    );
  }
}

```

### FukPage

The FukPage widget allows you to create a structured page layout with a header, content, footer, and an optional aside.

## Example

```dart
import 'package:flutter/material.dart';
import 'package:fuk_ui_kit/fuk_ui_kit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FukPage(
      header: FukHeader(
        title: 'Dashboard',
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle settings button press
            },
          ),
        ],
      ),
      content: const FukContent(
        child: Center(
          child: Text('This is the Dashboard page.'),
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

## Components

### FukHeader

A header component for your pages.

```dart
FukHeader(
  title: 'Dashboard',
  leading: const Icon(Icons.menu),
  actions: [
    IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        // Handle settings button press
      },
    ),
  ],
)
```

### FukContent

A content component for your pages.

```dart
FukContent(
    child: Center(
        child: Text('This is the content area.'),
    ),
)
```

### FukFooter

A footer component for your pages.

```dart
    FukFooter(text: 'Footer Content')
```

### FukButton

The FukButton widget provides several configurations, including different layouts for text and icon, loading state, custom colors, rounded borders, and full-width option.

#### Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/flutter_ui_kit.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter UI Kit Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FukLabel(text: 'Basic Button:'),
            const SizedBox(height: 8),
            FukButton(
              text: 'Submit',
              onPressed: _simulateLoading,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 16),
            const FukLabel(text: 'Button with Icon (Left):'),
            const SizedBox(height: 8),
            FukButton(
              text: 'Submit',
              icon: Icons.send,
              onPressed: _simulateLoading,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 16),
            const FukLabel(text: 'Button with Icon (Right):'),
            const SizedBox(height: 8),
            FukButton(
              text: 'Submit',
              icon: Icons.send,
              iconOnRight: true,
              onPressed: _simulateLoading,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 16),
            const FukLabel(text: 'Button with Icon (Below Text):'),
            const SizedBox(height: 8),
            FukButton(
              text: 'Submit',
              icon: Icons.send,
              iconBelowText: true,
              onPressed: _simulateLoading,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 16),
            const FukLabel(text: 'Icon Only Button:'),
            const SizedBox(height: 8),
            FukButton(
              icon: Icons.send,
              onPressed: _simulateLoading,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 16),
            const FukLabel(text: 'Button with Custom Colors and Rounded Border:'),
            const SizedBox(height: 8),
            FukButton(
              text: 'Submit',
              icon: Icons.send,
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
    );
  }
}

```

### FukLabel

The FukLabel widget allows you to display text with configurable sizes (small, medium, large).

#### Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/flutter_ui_kit.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter UI Kit Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FukLabel(
              text: 'Small Label',
              size: FukLabelSize.small,
            ),
            const SizedBox(height: 8),
            const FukLabel(
              text: 'Medium Label (Default)',
            ),
            const SizedBox(height: 8),
            const FukLabel(
              text: 'Large Label',
              size: FukLabelSize.large,
            ),
            const SizedBox(height: 16),
            const FukLabel(
              text: 'Custom Styled Label',
              style: TextStyle(
                color: Colors.red,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```

### FukModal

The FukModal widget provides a customizable modal dialog with header, content, and footer sections.

#### Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/flutter_ui_kit.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showModal(BuildContext context, FukModalSize size) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FukModal(
          title: 'Modal Title',
          content: const Text('This is the content of the modal. ' * 20),
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
              text: 'Cancel',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FukButton(
              text: 'Submit',
              onPressed: () {
                // Handle submit action
              },
            ),
          ],
          size: size,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter UI Kit Example')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FukButton(
              text: 'Show Small Modal',
              onPressed: () => _showModal(context, FukModalSize.small),
            ),
            const SizedBox(height: 16),
            FukButton(
              text: 'Show Medium Modal',
              onPressed: () => _showModal(context, FukModalSize.medium),
            ),
            const SizedBox(height: 16),
            FukButton(
              text: 'Show Large Modal',
              onPressed: () => _showModal(context, FukModalSize.large),
            ),
            const SizedBox(height: 16),
            FukButton(
              text: 'Show Fullscreen Modal',
              onPressed: () => _showModal(context, FukModalSize.fullscreen),
            ),
          ],
        ),
      ),
    );
  }
}

```

### Features

Sidebar with hierarchical menus Page structure with header, content, footer, and optional aside Easy integration with Flutter applications Contributing Contributions are welcome! Please open an issue or submit a pull request on GitHub.

### License

This project is licensed under the MIT License - see the LICENSE file for details.

```perl
    Este exemplo de `README.md` fornece uma visão geral clara do seu package, instruções de instalação, exemplos de uso e informações adicionais úteis. Ajuste conforme necessário para atender aos seus requisitos específicos. Se precisar de mais alguma coisa, estarei à disposição!
```
