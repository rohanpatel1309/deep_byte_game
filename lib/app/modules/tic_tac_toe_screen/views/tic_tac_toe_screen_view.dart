import 'package:deep_byte_game/app/data/size.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tic_tac_toe_screen_controller.dart';

class TicTacToeScreenView extends GetView<TicTacToeScreenController> {
  const TicTacToeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body(),
    );
  }

  /// Body
  Widget _body() {
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        children: <Widget>[

          /// Players score widget
          _playersScoreWidget(),

          /// Board
          _board(),

          /// Clear board button
          _clearBoardButtonWidget()
        ],
      ),
    );
  }

  /// Clear board button
  Widget _clearBoardButtonWidget() {
    return Padding(
      padding: EdgeInsets.all(width * 0.1),
      child: MaterialButton(
          color: Colors.black,
          textColor: Colors.white,
          onPressed: controller.clearScoreBoard,
          child: const Text("Clear Score Board"),
        ),
    );
  }

  /// Board
  Widget _board() {
    return Expanded(
      flex: 4,
      child: Padding(

        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: GridView.builder(
          padding: EdgeInsets.zero,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  controller.onTurn(index, winnerDialog,drawDialog);
                },
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Center(
                    child: Obx(() => Text(
                      controller.cellsValue[index],
                      style:
                      const TextStyle( fontSize: 35),
                    )),
                  ),
                ),
              );
            }),
      ),
    );
  }

  /// Players score widget
  Widget _playersScoreWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Obx(
          () => _scoreWidget(
              playerName: "Player 0",
              score: controller.player1Score.value.toString()),
        ),
        Obx(
          () => _scoreWidget(
              playerName: "Player X",
              score: controller.player2Score.value.toString()),
        )
      ],
    );
  }

  /// Player score widget
  Widget _scoreWidget({required String playerName, required String score}) {
    return Padding(
      padding: EdgeInsets.all(height * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            playerName,
            style: const TextStyle(
                 fontWeight: FontWeight.bold,fontSize: 22,),
          ),

          SizedBox(height: height * 0.01,),

          Text(
            score,
            style: const TextStyle(fontSize: 22,),
          ),
        ],
      ),
    );
  }

  /// Winner Dialog
  void winnerDialog(String player) {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("$player is win this game"),
            actions: [
              MaterialButton(
                child: const Text("Play Again"),
                onPressed: () {
                  controller.clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

    if (player == 'O') {
      controller.player1Score.value++;
    } else if (player == 'X') {
      controller.player2Score.value++;
    }
  }

  /// Draw Dialog
  void drawDialog() {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("This game is draw"),
            actions: [
              MaterialButton(
                child: const Text("Play Again"),
                onPressed: () {
                  controller.clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

}
