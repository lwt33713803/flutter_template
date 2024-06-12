import 'package:flutter_template/common/index.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class LayoutController extends GetxController {
  LayoutController();

  _initData() {
    update(["layout"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  RxList riveIconInputs = [].obs;
  RxList controllers = [].obs;
  RxInt selectedNavIndex = 0.obs;

  RxList<RiveModel> tabs= [
    RiveModel(
        src: "assets/animate/tabs.riv",
        artBoard: "HOME",
        stateMachineName: "HOME_interactivity"),
    RiveModel(
        src: "assets/animate/tabs.riv",
        artBoard: "BELL",
        stateMachineName: "BELL_Interactivity"),
    RiveModel(
        src: "assets/animate/tabs.riv",
        artBoard: "LIKE/STAR",
        stateMachineName: "STAR_Interactivity"),
    RiveModel(
        src: "assets/animate/tabs.riv",
        artBoard: "USER",
        stateMachineName: "USER_Interactivity"),
  ].obs;

  void riveOnInIt(Artboard artBoard, {required String stateMachineName}) {
    StateMachineController? controller =
    StateMachineController.fromArtboard(artBoard, stateMachineName);
    artBoard.addController(controller!);
    controllers.add(controller);
    riveIconInputs.add(controller.findInput<bool>('active') as SMIBool);
  }
}
