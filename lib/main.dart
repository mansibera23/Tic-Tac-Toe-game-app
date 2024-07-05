// Develop a Tic Tac Toe game app where two players can take turns to place their symbols (X or O) on a 3x3 grid. The objective is to form a horizontal, vertical, or diagonal line of three of their symbols to win the game. The app should also include a reset option to start a new game.

import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/colors.dart';
import 'package:tic_tac_toe_app/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String lastValue = Player.x;
  bool gameOver = false;
  int turn = 0;
  String result = "";
  List<int> scoreboard = [0,0,0,0,0,0,0,0];

  Game game = Game();

  @override
  void initState(){
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }


  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MainColor.bgColor1,
      appBar: AppBar(
        backgroundColor: MainColor.bgColor1,
        title:  Center( child: Text('Tic-Tac-Toe',style: TextStyle( color: Colors.black,fontSize: 20),),),
      ),
      body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:CrossAxisAlignment.center,
        children: [
          Text(
            "It's ${lastValue} turn".toUpperCase(),style: TextStyle( color: Colors.black,fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              crossAxisCount: 3,
              padding: EdgeInsets.all(16),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: List.generate(Game.boardLength, (index){
              return InkWell (
                onTap: gameOver? null : (){
                  if(game.board[index]== Player.empty) {
                    setState(() {
                      game.board[index] = lastValue;
                      turn++;
                      gameOver = game.winner(lastValue, index, scoreboard, 3);
                      if(gameOver){
                        result = "$lastValue win!";
                      }
                      else if(!gameOver && turn == 9){
                        result = "Draw!";
                        gameOver = true;
                      }
                      lastValue = (lastValue == Player.x) ? Player.o : Player.x;
                    });
                  }
                },
                child: Container(
                height: boardWidth/3,
                width: boardWidth/3,
                decoration: BoxDecoration(
                  color: MainColor.bgColor2,
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Center(
                  child: Text(
                    game.board![index],
                    style: TextStyle(
                      color: game.board![index] == Player.x ? Colors.blue : Colors.pink,
                      fontSize: 64.0,
                    ),
                  ),
                ),
              ),
              );
            }),),
          ),
          SizedBox(
            height: 24.0,
          ),
          Text(result,
            style: TextStyle(color: MainColor.accentColor,fontSize: 50.0),
          ),
          ElevatedButton.icon(
              onPressed: (){
                setState(() {
                  game.board = Game.initGameBoard();
                  lastValue = Player.x;
                  gameOver = false;
                  turn = 0;
                  result = "";
                  scoreboard = [0,0,0,0,0,0,0,0];
                });
              },
            style: ElevatedButton.styleFrom(
              backgroundColor: MainColor.bgColor2,
            ),
              icon: Icon(Icons.replay),
              label: Text("Restart",style: TextStyle(fontSize: 25),),
          ),

      ],
      ),
      ),
    );
  }
}
