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

  @override
  Widget build(BuildContext context) {
    return FukContentMaster(
      //icon: const Icon(Icons.production_quantity_limits),
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
          title: 'Notify',
          routeName: 'notify',
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
          content: FukContent(
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
                  const SizedBox(height: 8),
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
        ),
        'notify': FukPage(
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
                    onPressed: () => _showNotification(context,
                        FukNotifyType.success, FukNotifyDirection.bottom),
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
