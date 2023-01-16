import 'dart:io';

class ConsoleUI {

  /// Messages to show which strategy was chosen
  int showMessage(var selection) {
    try {
      if (selection < 1 || selection > 2) {
        print("Invalid selection: $selection");
      }
      else if (selection == 1) {
        print("Selected Strategy: Smart");
        return 0;
      }
      else {
        print("Selected Strategy: Random");
        return 1;
      }
    } on FormatException {
      print("Incorrect format, please give an integer.");
    }
    return 2;
  }

  /// Gets user to enter a valid url
  String promptServer(String defaults) {
    stdout.write('Enter the server URL [default: $defaults] ');
    var url = stdin.readLineSync();
    print("Obtaining server information ......");
    if(url == "") {
      url = defaults;
    }
    return url;
  }

  /// Has user choose strategy
  int promptStrategy(List<String> info) {
    var Smart = info[0];
    var Random = info[1];
    var pick = 1;
    stdout.write('Select the server strategy: 1. $Smart 2. $Random [default: $pick] ');
    var line = stdin.readLineSync();
    if(line == "") {
      return 1;
    }
    else {
      return int.parse(line);
    }
  }

  /// Has user pick slot
  int promptMove() {
    stdout.write("Select a slot [1-7]: ");
    var move = int.parse(stdin.readLineSync());
    return move;
  }
}