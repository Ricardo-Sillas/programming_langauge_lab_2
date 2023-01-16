import 'dart:io';
import '../lib/ConsoleUI.dart';
import '../lib/WebClient.dart';
import '../lib/RandomStrategy.dart';
import '../lib/SmartStrategy.dart';
import '../lib/board.dart';

/// Used to keep track of the board
var board = [
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0]
];

void main() async {
  var strategy;
  var url = ConsoleUI().promptServer(
      "https://cssrvlab01.utep.edu/Classes/cs3360/rrsillas/info");
  var info = await WebClient().getInfo(url.trim());

  /// Has user to pick a strategy
  while (true) {
    var selection = ConsoleUI().promptStrategy(info);
    var strat = ConsoleUI().showMessage(selection);
    if(strat==0) {
      strategy = new SmartStrategy();
      break;
    }
    else if(strat == 1) {
      strategy = new RandomStrategy();
      break;
    }
  }

  /// Where the game is being played
  while (true) {
    var move = ConsoleUI().promptMove();
    while (move < 1 || move > 7) {
      print("Invalid Selection: $move");
      move = ConsoleUI().promptMove();
    }
    move--;
    board = updateBoard(move, 1, board);
    if(checkWin(1, move, board)) {
      printBoard(board, true);
      print("User wins");
      exit(0);
    }
    var comp = strategy.pickSlot(board);
    board = updateBoard(comp, 2, board);
    if(checkWin(2, comp, board)) {
      printBoard(board, true);
      print("Computer wins");
      exit(0);
    }
    if(boardFull(board)) {
      print("Board is full");
      exit(0);
    }
    printBoard(board, false);
  }
}