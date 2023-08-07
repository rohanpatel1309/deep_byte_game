import 'package:get/get.dart';

import '../controllers/tic_tac_toe_screen_controller.dart';

class TicTacToeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TicTacToeScreenController>(
      () => TicTacToeScreenController(),
    );
  }
}
