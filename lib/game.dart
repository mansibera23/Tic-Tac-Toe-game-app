class Player{
  static const x = "X";
  static const o = "O";
  static const empty = "";
}

class Game{
  static const int boardLength = 9;
  static const blockSize = 100.0;



  List<String> board=List.filled(boardLength, Player.empty);


  static List<String> initGameBoard() => List.filled(boardLength, Player.empty);

  bool winner (String player,int index, List<int> scoreboard, int gridSize){
    int row = index ~/ gridSize;
    int column = index % gridSize;
    int score = player == Player.x ? 1 : -1;

    scoreboard[row] += score;
    scoreboard[gridSize + column] += score;
    if(row == column) scoreboard[2*gridSize] += score;
    if(gridSize-1-column == row) scoreboard[2*gridSize+1] += score;
    if(scoreboard.contains(3) || scoreboard.contains(-3)) {
      return true;
    }

    return false;
  }
}