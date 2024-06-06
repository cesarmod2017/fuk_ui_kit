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

```Dart
import 'package:fuk_ui_kit/fuk_ui_kit.dart';
```

### FukSidebar

The FukSidebar widget allows you to create a sidebar with hierarchical menu items.

## Example

```Dart
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

```Dart
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

```Dart
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

```Dart
FukContent(
    child: Center(
        child: Text('This is the content area.'),
    ),
)
```

### FukFooter

A footer component for your pages.

```Dart
    FukFooter(text: 'Footer Content')
```

### Features

Sidebar with hierarchical menus Page structure with header, content, footer, and optional aside Easy integration with Flutter applications Contributing Contributions are welcome! Please open an issue or submit a pull request on GitHub.

### License

This project is licensed under the MIT License - see the LICENSE file for details.

```perl
    Este exemplo de `README.md` fornece uma visão geral clara do seu package, instruções de instalação, exemplos de uso e informações adicionais úteis. Ajuste conforme necessário para atender aos seus requisitos específicos. Se precisar de mais alguma coisa, estarei à disposição!
```
