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
