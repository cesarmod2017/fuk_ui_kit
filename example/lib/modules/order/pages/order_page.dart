import 'package:flutter/material.dart';
import 'package:fuk_ui_kit_sample/modules/order/controller/order_controller.dart';
import 'package:get/get.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

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
        body: const Column(
          children: [
            Center(
              child: Text("Order"),
            ),
          ],
        ),
      );
    });
  }
}
