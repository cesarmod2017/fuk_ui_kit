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
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FukContentMaster(
      topItems: [
        SideBarItems(
          title: 'Dashboard',
          routeName: 'dashboard',
          leading: const Icon(Icons.dashboard),
          onTap: () {
            // Handle navigation or state change here
          },
        ),
        SideBarItems(
          title: 'Profile',
          routeName: 'profile',
          leading: const Icon(Icons.person),
          children: [
            SideBarItems(
              title: 'Profile 1',
              routeName: 'profile1',
              leading: const Icon(Icons.person_outline),
              onTap: () {
                // Handle navigation or state change here
              },
            ),
            SideBarItems(
              title: 'Profile 2',
              routeName: 'profile2',
              leading: const Icon(Icons.person_outline),
              children: [
                SideBarItems(
                  title: 'Profile 2.1',
                  routeName: 'profile21',
                  leading: const Icon(Icons.person_add),
                  onTap: () {
                    // Handle navigation or state change here
                  },
                ),
                SideBarItems(
                  title: 'Profile 2.2',
                  routeName: 'profile22',
                  leading: const Icon(Icons.person_add),
                  onTap: () {
                    // Handle navigation or state change here
                  },
                ),
              ],
            ),
            SideBarItems(
              title: 'Profile 3',
              routeName: 'profile3',
              leading: const Icon(Icons.person_outline),
              onTap: () {
                // Handle navigation or state change here
              },
            ),
          ],
        ),
      ],
      bottomItems: [
        SideBarItems(
          leading: const Icon(Icons.account_circle),
          title: 'Minha Conta',
          routeName: 'account',
          onTap: () {
            // Handle navigation or state change here
          },
        ),
        SideBarItems(
          leading: const Icon(Icons.exit_to_app),
          routeName: 'logout',
          title: 'Sair',
          onTap: () {
            // Handle navigation or state change here
          },
        ),
      ],
      routes: {
        'dashboard': FukPage(
          header: FukHeader(
            title: 'Dashboard',
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
          content: const FukContent(
            child: Center(
              child: Text('This is the Dashboard page.'),
            ),
          ),
          footer: const FukFooter(text: 'Footer Content'),
        ),
        'profile1': FukPage(
          header: FukHeader(
            title: 'Profile 1',
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
          content: const FukContent(
            child: Center(
              child: Text('This is the Profile page.'),
            ),
          ),
          footer: const FukFooter(text: 'Footer Content'),
          aside: Container(
            color: Colors.grey[800],
            child: const Center(
              child: Text('Aside Content'),
            ),
          ),
        ),
        'profile22': FukPage(
          header: FukHeader(
            title: 'Profile 22',
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
          content: const FukContent(
            child: Center(
              child: Text('This is the Profile page.'),
            ),
          ),
          footer: const FukFooter(text: 'Footer Content'),
          aside: Container(
            color: Colors.grey[800],
            child: const Center(
              child: Text('Aside Content'),
            ),
          ),
        ),
        'account': FukPage(
          header: FukHeader(
            title: 'Account',
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
          content: const FukContent(
            child: Center(
              child: Text('This is the Profile page.'),
            ),
          ),
          footer: const FukFooter(text: 'Footer Content'),
          aside: Container(
            color: Colors.grey[800],
            child: const Center(
              child: Text('Aside Content'),
            ),
          ),
        ),
      },
    );
  }
}
