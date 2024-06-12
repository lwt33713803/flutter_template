import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import 'index.dart';

class LayoutPage extends GetView<LayoutController> {
  Color buttonNavBgColor = const Color(0xFF17203A);
  LayoutPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("LayoutPage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutController>(
      init: LayoutController(),
      id: "layout",
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: _buildView(),
          ),
          bottomNavigationBar: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              margin: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
              decoration: BoxDecoration(
                color: buttonNavBgColor.withOpacity(0.8),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: buttonNavBgColor.withOpacity(0.4),
                    offset: const Offset(0, 20),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      controller.tabs.length,
                      (index) {
                        final riveIcon = controller.tabs[index];
                        return GestureDetector(
                            onTap: () {
                              controller.riveIconInputs[index].change(true);
                              Future.delayed(
                                const Duration(seconds: 1),
                                () {
                                  controller.riveIconInputs[index].change(false);
                                },
                              );
                            },
                            child: SizedBox(
                              height: 34,
                              width: 36,
                              child: RiveAnimation.asset(
                                riveIcon.src,
                                artboard: riveIcon.artBoard,
                                onInit: (artBoard) {
                                  controller.riveOnInIt(artBoard,stateMachineName: riveIcon.stateMachineName);
                                },
                              ),
                            ));
                      },
                    ),
                  ))),
        );
      },
    );
  }
}
