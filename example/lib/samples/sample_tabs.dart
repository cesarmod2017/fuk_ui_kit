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
        footer: const FukFooter(text: 'Footer Content'),
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
