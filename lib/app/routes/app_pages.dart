import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/tic_tac_toe_screen/bindings/tic_tac_toe_screen_binding.dart';
import '../modules/tic_tac_toe_screen/views/tic_tac_toe_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.TIC_TAC_TOE_SCREEN,
      page: () => const TicTacToeScreenView(),
      binding: TicTacToeScreenBinding(),
    ),
  ];
}
