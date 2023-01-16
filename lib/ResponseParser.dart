class ResponseParser {
  /// Returns the two different types of strategies
  List parseInfo(var info) {
    var Smart = info['strategies'][0];
    var Random = info['strategies'][1];
    return [Smart,Random];
  }
}