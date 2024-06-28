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
