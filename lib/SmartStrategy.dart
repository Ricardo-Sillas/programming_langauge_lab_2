import 'dart:math';

/// Holder for when a spot to block human was found
var block = -1;
var temp = [[0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0]];

class SmartStrategy {
  var rand = new Random();
  int pickSlot(var board) {
    block = -1;
    /// Checks if there is a winning move for either computer or human
    for(int i=0; i<7; i++) {
      resetTemp(board);
      var win = this.isWin(i, 2);
      /// If computer has a winning move, then it would return that slot
      if(win >= 0) {
        return win;
      }
      /// Resets the temporary board
      resetTemp(board);
      /// If user has a winning move, it would be placed in the holder
      if(block == -1) {
        block = this.isWin(i, 1);
      }
    }
    /// Once its gone through the board, if there was something to block, it would return that slot
    if(block >= 0) {
      return block;
    }
    /// If it has nothing to block, it would then start picking spots randomly
    var slot = rand.nextInt(7);
    /// Checks the top most position of that column to see if there is space in that slot
    if(board[0][slot] == 0) {
      return slot;
    }
    /// If the first choice was full, it would then move onto the other slots to see if theres a spot
    for(int i=0; i<6; i++) {
      if(slot != 6) {
        slot++;
      }
      else {
        slot = 0;
      }
      if(board[0][slot] == 0) {
        return slot;
      }
    }
    /// If the whole board was full, then it would return -1
    return -1;
  }

  /// Used to see if there is any positions that could be a winning spot
  int isWin(var slot, var player) {
    /// If that certain position was full, it would return -1
    if(fullCol(slot)) {
      return -1;
    }
    /// It would update the temporary board that was created
    updateTemp(slot, player);
    /// It then checks if that piece that was put down was a winning spot, and would return if it is
    if(check(slot, player)) {
      return slot;
    }
    /// Returns -1 if it wasn't a winning spot
    return -1;
  }
}

/// Used to reset the temp to the values for board
void resetTemp(var board) {
  for(int i=0; i<6; i++) {
    for(int j=0; j<7; j++) {
      temp[i][j] = board[i][j];
    }
  }
}

/// Method used to update the temporary board
void updateTemp(var slot, var player) {
  /// Checks from top to bottom to find out where to put the piece
  for(var i=1; i<6; i++) {
    if(temp[i][slot]==1 || temp[i][slot]==2) {
      temp[i-1][slot] = player;
      break;
    }
    else if(i==5) {
      temp[i][slot]=player;
    }
  }
}

/// Checks if the column that was given is full
bool fullCol(var slot) {
  if(temp[0][slot]==0) {
    return false;
  }
  return true;
}

/// Used to check if there were any winning spots
bool check(var slot, var player) {
  int save = -1;

  /// Vertical
  for(int i = 0; i < 6; i++) {
    if(temp[i][slot]==player) {
      if(i > 2) {
        break;
      }
      if(temp[i+1][slot]==player && temp[i+2][slot]==player && temp[i+3][slot]==player){
        return true;
      }
      else {
        break;
      }
    }
  }

  /// Horizontal
  for(int i = 0; i < 6; i++) {
    if(temp[i][slot]==player) {
      save = i;
      break;
    }
  }
  for(int i = 0; i < 4; i++) {
    if(temp[save][i]==player && temp[save][i+1]==player && temp[save][i+2]==player && temp[save][i+3]==player){
      return true;
    }
  }

  /// Rising diagonal
  if(slot+save > 2 && slot+save < 9) {
    if ((save + slot) % 5 == 3) {
      if (temp[3][0] == player && temp[2][1] == player && temp[1][2] == player && temp[0][3] == player) {
        return true;
      }
      else if (temp[5][3] == player && temp[4][4] == player && temp[3][5] == player && temp[2][6] == player) {
        return true;
      }
    } else if (save + slot == 4) {
      if (temp[3][1] == player && temp[2][2] == player && temp[1][3] == player) {
        if (temp[0][4] == player) {
          return true;
        } else if (temp[4][0] == player) {
          return true;
        }
      }
    } else if (save + slot == 7) {
      if (temp[4][3] == player && temp[3][4] == player && temp[2][5] == player) {
        if (temp[5][2] == player) {
          return true;
        } else if (temp[1][6] == player) {
          return true;
        }
      }
    } else {
      if (slot + save == 5) {
        if (temp[3][2] == player && temp[2][3] == player) {
          if (temp[1][4] != player) {
            if (temp[4][1] == player && temp[5][0] == player) {
              return true;
            }
          }
          else if(temp[4][1] != player) {
            if(temp[1][4] == player && temp[0][5] == player) {
              return true;
            }
          }
          else {
            return true;
          }
        }
      }
      if(slot+save == 6) {
        if (temp[3][3] == player && temp[2][4] == player) {
          if (temp[1][5] != player) {
            if (temp[4][2] == player && temp[5][1] == player) {
              return true;
            }
          }
          else if(temp[4][2] != player) {
            if(temp[1][5] == player && temp[0][6] == player) {
              return true;
            }
          }
          else {
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
      if (temp[3][6] == player && temp[2][5] == player && temp[1][4] == player && temp[0][3] == player) {
        return true;
      }
      else if (temp[5][3] == player && temp[4][2] == player && temp[3][1] == player && temp[2][0] == player) {
        return true;
      }
    } else if (save + slot == 4) {
      if (temp[3][5] == player && temp[2][4] == player && temp[1][3] == player) {
        if (temp[0][2] == player) {
          return true;
        } else if (temp[4][6] == player) {
          return true;
        }
      }
    } else if (save + slot == 7) {
      if (temp[4][3] == player && temp[3][2] == player && temp[2][1] == player) {
        if (temp[5][4] == player) {
          return true;
        } else if (temp[1][0] == player) {
          return true;
        }
      }
    } else {
      if (slot + save == 5) {
        if (temp[3][4] == player && temp[2][3] == player) {
          if (temp[1][2] != player) {
            if (temp[4][5] == player && temp[5][6] == player) {
              return true;
            }
          }
          else if(temp[4][5] != player) {
            if(temp[1][2] == player && temp[0][1] == player) {
              return true;
            }
          }
          else {
            return true;
          }
        }
      }
      if(slot+save == 6) {
        if (temp[3][3] == player && temp[2][2] == player) {
          if (temp[1][1] != player) {
            if (temp[4][4] == player && temp[5][5] == player) {
              return true;
            }
          }
          else if(temp[4][4] != player) {
            if(temp[1][1] == player && temp[0][6] == player) {
              return true;
            }
          }
          else {
            return true;
          }
        }
      }
    }
  }
  return false;
}