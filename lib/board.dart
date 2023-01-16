import 'dart:io';

import 'package:ansicolor/ansicolor.dart';

var winningRow = [];

/// Method being used to update the board for both computer and user
List<List<int>> updateBoard(var slot, var player, var board) {
  if(colFull(slot, board)) {
    print("Column full\n");
  }
  /// Goes from top to bottom when placing a piece
  else {
    for(int i = 0; i<6; i++) {
      if(board[i][slot]==1 || board[i][slot]==2) {
        board[i-1][slot] = player;
        return board;
      }
      else if(i==5) {
        board[i][slot] = player;
        return board;
      }
    }
  }
}

/// Checks to see if the player(either the computer or user) won with the given slot
bool checkWin(var player, var slot, var board) {
  int save = -1;

  /// Vertical
  for(int i = 0; i < 6; i++) {
    if(board[i][slot]==player) {
      if(i > 2) {
        break;
      }
      if(board[i+1][slot]==player && board[i+2][slot]==player && board[i+3][slot]==player){
        winningRow = [slot, i, slot, i+1, slot, i+2, slot, i+3];
        return true;
      }
      else {
        break;
      }
    }
  }

  /// Horizontal
  for(int i = 0; i < 6; i++) {
    if(board[i][slot]==player) {
      save = i;
      break;
    }
  }
  for(int i = 0; i < 4; i++) {
    if(board[save][i]==player && board[save][i+1]==player && board[save][i+2]==player && board[save][i+3]==player){
      winningRow = [i, save, i+1, save, i+2, save, i+3, save];
      return true;
    }
  }

  /// Rising diagonal
  if(slot+save > 2 && slot+save < 9) {
    if ((save + slot) % 5 == 3) {
      if (board[3][0] == player && board[2][1] == player && board[1][2] == player && board[0][3] == player) {
        winningRow = [0, 3, 1, 2, 2, 1, 3, 0];
        return true;
      }
      else if (board[5][3] == player && board[4][4] == player && board[3][5] == player && board[2][6] == player) {
        winningRow = [3, 5, 4, 4, 5, 3, 6, 2];
        return true;
      }
    } else if (save + slot == 4) {
      if (board[3][1] == player && board[2][2] == player && board[1][3] == player) {
        if (board[0][4] == player) {
          winningRow = [1, 3, 2, 2, 3, 1, 4, 0];
          return true;
        } else if (board[4][0] == player) {
          winningRow = [0, 4, 1, 3, 2, 2, 3, 1];
          return true;
        }
      }
    } else if (save + slot == 7) {
      if (board[4][3] == player && board[3][4] == player && board[2][5] == player) {
        if (board[5][2] == player) {
          winningRow = [2, 5, 3, 4, 4, 3, 5, 2];
          return true;
        } else if (board[1][6] == player) {
          winningRow = [3, 4, 4, 3, 5, 2, 6, 1];
          return true;
        }
      }
    } else {
      if (slot + save == 5) {
        if (board[3][2] == player && board[2][3] == player) {
          if (board[1][4] != player) {
            if (board[4][1] == player && board[5][0] == player) {
              winningRow = [0,5,1,4,2,3,3,2];
              return true;
            }
          }
          else if(board[4][1] != player) {
            if(board[1][4] == player && board[0][5] == player) {
              winningRow = [5,0,4,1,3,2,2,3];
              return true;
            }
          }
          else {
            winningRow = [1,4,2,3,3,2,4,1];
            return true;
          }
        }
      }
      if(slot+save == 6) {
        if (board[3][3] == player && board[2][4] == player) {
          if (board[1][5] != player) {
            if (board[4][2] == player && board[5][1] == player) {
              winningRow = [1,5,2,4,3,3,4,2];
              return true;
            }
          }
          else if(board[4][2] != player) {
            if(board[1][5] == player && board[0][6] == player) {
              winningRow = [6,0,5,1,4,2,3,3];
              return true;
            }
          }
          else {
            winningRow = [1,5,2,4,3,3,4,2];
            return true;
          }
        }
      }
    }
  }

  /// falling diagonal
  slot=6-slot;
  if(slot+save > 2 && slot+save < 9) {
    if ((save + slot) % 5 == 3) {
      if (board[3][6] == player && board[2][5] == player && board[1][4] == player && board[0][3] == player) {
        winningRow = [6, 3, 5, 2, 4, 1, 3, 0];
        return true;
      }
      else if (board[5][3] == player && board[4][2] == player && board[3][1] == player && board[2][0] == player) {
        winningRow = [3, 5, 2, 4, 1, 3, 0, 2];
        return true;
      }
    } else if (save + slot == 4) {
      if (board[3][5] == player && board[2][4] == player && board[1][3] == player) {
        if (board[0][2] == player) {
          winningRow = [5, 3, 4, 2, 3, 1, 2, 0];
          return true;
        } else if (board[4][6] == player) {
          winningRow = [6, 4, 5, 3, 4, 2, 3, 1];
          return true;
        }
      }
    } else if (save + slot == 7) {
      if (board[4][3] == player && board[3][2] == player && board[2][1] == player) {
        if (board[5][4] == player) {
          winningRow = [4, 5, 3, 4, 2, 3, 1, 2];
          return true;
        } else if (board[1][0] == player) {
          winningRow = [3, 4, 2, 3, 1, 2, 0, 1];
          return true;
        }
      }
    } else {
      if (slot + save == 5) {
        if (board[3][4] == player && board[2][3] == player) {
          if (board[1][2] != player) {
            if (board[4][5] == player && board[5][6] == player) {
              winningRow = [6,5,5,4,4,3,3,2];
              return true;
            }
          }
          else if(board[4][5] != player) {
            if(board[1][2] == player && board[0][1] == player) {
              winningRow = [1,0,2,1,3,2,4,3];
              return true;
            }
          }
          else {
            winningRow = [5,4,4,3,3,2,2,1];
            return true;
          }
        }
      }
      if(slot+save == 6) {
        if (board[3][3] == player && board[2][2] == player) {
          if (board[1][1] != player) {
            if (board[4][4] == player && board[5][5] == player) {
              winningRow = [5,5,4,4,3,3,2,2];
              return true;
            }
          }
          else if(board[4][4] != player) {
            if(board[1][1] == player && board[0][6] == player) {
              winningRow = [0,0,1,1,2,2,3,3];
              return true;
            }
          }
          else {
            winningRow = [5,5,4,4,3,3,2,2];
            return true;
          }
        }
      }
    }
  }
  return false;
}

/// Checks to see if the column is full
bool colFull(var slot, var board) {
  if(board[0][slot] == 0) {
    return false;
  }
  return true;
}

/// Checks to see if the board is full
bool boardFull(var board) {
  for(int i=0; i<7; i++) {
    if(board[0][i]==0) {
      return false;
    }
  }
  return true;
}

/// Prints board for both wins and moves made
void printBoard(var board, var win) {
  AnsiPen highlight = AnsiPen()..black(bg: true)..white();
  for(int i=0; i<6; i++) {
    stdout.write("|");
    for(int j=0; j<7; j++) {
      /// For wins
      if(win) {
        if((winningRow[0]==j && winningRow[1]==i)
        ||(winningRow[2]==j && winningRow[3]==i)
        ||(winningRow[4]==j && winningRow[5]==i)
        ||(winningRow[6]==j && winningRow[7]==i)) {
          stdout.write(highlight(board[i][j].toString()));
        }
        else {
          stdout.write(board[i][j]);
        }
      }
      /// For moves made
      else {
        stdout.write(board[i][j]);
      }
      stdout.write("|");
    }
    print("");
  }
}