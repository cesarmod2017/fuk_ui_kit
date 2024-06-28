import 'package:fuk_ui_kit_sample/modules/order/controller/order_controller.dart';
import 'package:get/get.dart';

class OrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() => OrderController(), fenix: true);
  }
}
