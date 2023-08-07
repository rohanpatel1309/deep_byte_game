import 'package:deep_byte_game/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  // Navigate to game
  void navigateToGame(){
    Get.toNamed(Routes.TIC_TAC_TOE_SCREEN);
  }

}
