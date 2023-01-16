import 'dart:math';

class RandomStrategy {
  var rand = new Random();
  int pickSlot(var board)
  {
    var slot = rand.nextInt(7);
    /// Checks the top most position of that column to see if there is space in that slot
    if(board[0][slot] == 0) {
      return slot;
    }
    /// If the first pick was full, goes on to find an empty slot
    for(int i=0; i<6; i++) {
      if(slot != 6) {
        slot++;
      }
      else {
        slot=0;
      }
      if(board[0][slot] == 0) {
        return slot;
      }
    }
    /// Returns -1 if all slots were full
    return -1;
  }
}