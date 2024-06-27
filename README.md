# fuk_ui_kit

A Flutter package for building efficient and elegant user interfaces.

## Installation

Add `fuk_ui_kit` to your `pubspec.yaml` file:

```yaml
dependencies:
  fuk_ui_kit: ^0.0.6
```

## Usage

### Import

Import the package in your Dart file:

```dart
import 'package:fuk_ui_kit/fuk_ui_kit.dart';
```

### FukHeader

The `FukHeader` component allows you to add a customizable header to your application.

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

The `FukContent` component is used to display the main content of the page.

```dart
FukContent(
  child: Center(
    child: Text('This is the content area.'),
  ),
)
```

### FukButton

The `FukButton` component allows you to create stylish buttons.

```dart
FukButton(
  text: 'Show Info Notification',
  onPressed: () {
    // Handle button press
  },
)
```

### FukFooter

The `FukFooter` component adds a footer to your application.

```dart
FukFooter(
  text: 'Footer Content',
)
```

### FukNotify

The `FukNotify` component allows you to display toast-style notifications.

```dart
FukNotify.show(
  context,
  type: FukNotifyType.info,
  direction: FukNotifyDirection.top,
  message: 'This is an info notification.',
)
```

### FukContentMaster

The `FukContentMaster` component manages the main layout of the application, including the sidebar and the main content.

```dart
FukContentMaster(
  topItems: [
    SideBarItems(
      title: 'Buttons',
      routeName: 'buttons',
      leading: const Icon(Icons.smart_button),
      onTap: () {},
    ),
    // Other items...
  ],
  content: FukContent(
    child: Center(
      child: Column(
        children: [
          FukButton(
            text: 'Show Info Notification',
            onPressed: () {
              // Handle button press
            },
          ),
          // Other buttons...
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
)
```

### FukModal

The `FukModal` component is used to display modal dialogs in your application.

```dart
// Show the modal
showDialog(
  context: context,
  builder: (BuildContext context) {
    return FukModal(
      title: 'Modal Title',
      content: Text('This is the modal content.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the modal
          },
          child: Text('Close'),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle action
          },
          child: Text('Save'),
        ),
      ],
    );
  },
);
```

### FukDataGrid

The `FukDataGrid` component is used to display data in a grid format.

```dart
FukDataGrid(
  columns: const [
    DataColumn(label: Text('ID')),
    DataColumn(label: Text('Name')),
    DataColumn(label: Text('Age')),
  ],
  rows: const [
    DataRow(cells: [
      DataCell(Text('1')),
      DataCell(Text('Alice')),
      DataCell(Text('23')),
    ]),
    DataRow(cells: [
      DataCell(Text('2')),
      DataCell(Text('Bob')),
      DataCell(Text('34')),
    ]),
    DataRow(cells: [
      DataCell(Text('3')),
      DataCell(Text('Charlie')),
      DataCell(Text('29')),
    ]),
  ],
)
```

### FukTextFile

The `FukTextFile` component allows you to select files or folders with specific configurations.

```dart
const FukTextFile(
  isRequired: true,
  allowedFileTypes: [AllowedFileType.folder],
  icon: Icon(Icons.folder),
  label: 'Select a Folder',
  decoration: InputDecoration(
    border: OutlineInputBorder(),
  ),
)
```

### FukTextField

The `FukTextField` component allows you to create text fields with customizable labels and placeholders.

```dart
const FukTextField(
  label: 'Name',
  placeholder: 'Enter your name',
  isRequired: true,
  decoration: InputDecoration(
    border: OutlineInputBorder(),
  ),
)
```

## Examples

For more usage examples, check out the example code in the `example` directory.

---
