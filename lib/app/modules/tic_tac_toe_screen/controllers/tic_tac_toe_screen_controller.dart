import 'dart:convert';

import 'package:deep_byte_game/app/data/preference_helper.dart';
import 'package:get/get.dart';

class TicTacToeScreenController extends GetxController {


  // 1st player is O
  RxBool player1Turn = true.obs;
  RxInt player1Score = 0.obs;
  RxInt player2Score = 0.obs;
  RxInt totalBoxFixed = 0.obs;
  RxList cellsValue = ['', '', '', '', '', '', '', '', ''].obs;

  @override
  void onInit() {

    player1Score.value = int.parse( PreferenceHelper.getValue(key: "p1Score") ?? "0") ;
    player2Score.value = int.parse(PreferenceHelper.getValue(key: "p2Score") ?? "0");

    final String cellValueString =  PreferenceHelper.getValue(key: "gameStatus") ?? "";

    if(cellValueString.isNotEmpty){
      final List<dynamic> cellsValueList = json.decode(cellValueString);
      cellsValue.clear();
      cellsValue = [...cellsValueList].obs;
    }


    super.onInit();

  }


  /// Player turn cell filled
  void onTurn(int index, Function winnerDialog, Function drawDialog) async{
    
      if (player1Turn.value && cellsValue[index] == '') {
        cellsValue[index] = 'O';
        totalBoxFixed++;
      } else if (!player1Turn.value && cellsValue[index] == '') {
        cellsValue[index] = 'X';
        totalBoxFixed++;
      }

      player1Turn.value = !player1Turn.value;
      checkWinner(winnerDialog, drawDialog);

      await setValueInStorage();
  }

  /// Check winner
  void checkWinner(Function winnerDialog, Function drawDialog) {

    // Column
    if (cellsValue[0] == cellsValue[3] &&
        cellsValue[0] == cellsValue[6] &&
        cellsValue[0] != '') {
      winnerDialog(cellsValue[0]);
    }
    else if (cellsValue[1] == cellsValue[4] &&
        cellsValue[1] == cellsValue[7] &&
        cellsValue[1] != '') {
      winnerDialog(cellsValue[1]);
    }
    else if (cellsValue[2] == cellsValue[5] &&
        cellsValue[2] == cellsValue[8] &&
        cellsValue[2] != '') {
      winnerDialog(cellsValue[2]);
    }

    // Row
    else if (cellsValue[0] == cellsValue[1] &&
        cellsValue[0] == cellsValue[2] &&
        cellsValue[0] != '') {
      winnerDialog(cellsValue[0]);
    }
    else if (cellsValue[3] == cellsValue[4] &&
        cellsValue[3] == cellsValue[5] &&
        cellsValue[3] != '') {
      winnerDialog(cellsValue[3]);
    }
    else if (cellsValue[6] == cellsValue[7] &&
        cellsValue[6] == cellsValue[8] &&
        cellsValue[6] != '') {
      winnerDialog(cellsValue[6]);
    }

    //  Diagonal
    else if (cellsValue[0] == cellsValue[4] &&
        cellsValue[0] == cellsValue[8] &&
        cellsValue[0] != '') {
      winnerDialog(cellsValue[0]);
    }
    else if (cellsValue[2] == cellsValue[4] &&
        cellsValue[2] == cellsValue[6] &&
        cellsValue[2] != '') {
      winnerDialog(cellsValue[2]);
    } else if (totalBoxFixed.value == 9) {
      drawDialog();
    }
  }

  /// Clear board
  void clearBoard() {
      for (int i = 0; i < 9; i++) {
        cellsValue[i] = '';
      }

    totalBoxFixed.value = 0;

   PreferenceHelper.setValue(key: "gameStatus", value: "");

  }

  /// Clear scoreboard
  void clearScoreBoard() {

      player2Score.value = 0;
      player1Score.value = 0;
      for (int i = 0; i < 9; i++) {
        cellsValue[i] = '';
      }
    totalBoxFixed.value = 0;

      setValueInStorage();
  }

  /// Set value in local storage
  Future<void> setValueInStorage() async{
    await PreferenceHelper.setValue(key: "p1Score", value: player1Score.value.toString());
    await PreferenceHelper.setValue(key: "p2Score", value: player2Score.value.toString());

    final String cellValueSting = json.encode(cellsValue);

    await PreferenceHelper.setValue(key: "gameStatus", value: cellValueSting);


  }
}
