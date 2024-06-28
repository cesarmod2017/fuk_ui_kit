import 'package:fuk_ui_kit_sample/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController(), permanent: true);
  }
}
