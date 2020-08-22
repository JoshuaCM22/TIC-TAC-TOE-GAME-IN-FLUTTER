import 'dart:math';
import 'package:flutter/material.dart';

int _currentMoves = 0;
List<String> _board = ['', '', '', '', '', '', '', '', ''];
String _turnContent = 'Turn: X';
String _descriptionContent = '';
String _winner = '';
bool _youVSAI;
var _gamePageState;
var _turnState;

// ignore: must_be_immutable
class GameScreen extends StatefulWidget {
  bool isVSAI;
  GameScreen(this.isVSAI) {
    _youVSAI = this.isVSAI;
    if (_youVSAI == true) {
      _descriptionContent = 'You = X\nAI = O';
    } else {
      _descriptionContent = '1st Player = X\n2nd Player = O';
    }
    resetTheGame();
  }
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    _gamePageState = this;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            _youVSAI ? 'Tic Tac Toe: You VS AI' : 'Tic Tac Toe: 2 Players'),
        actions: <Widget>[],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 0),
        decoration: BoxDecoration(color: Colors.yellow[100]),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[Description(), _BoxContainer(), Status()],
          ),
        ),
      ),

      // for restart button UI
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAlertDialog(
              context, 'Attention', 'Do you want to restart the game?');
        },
        tooltip: 'Restart',
        child: Icon(Icons.refresh),
      ),
    );
  }
}

showAlertDialog(
    BuildContext context, String titleMessage, String contentMessage) {
  Widget noButton = FlatButton(
    child: Text(
      "No",
      style: TextStyle(
        color: Colors.black,
        fontSize: 19.0,
      ),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget yesButton = FlatButton(
    child: Text(
      "Yes",
      style: TextStyle(
        color: Colors.black,
        fontSize: 19.0,
      ),
    ),
    onPressed: () {
      _gamePageState.setState(() {
        resetTheGame();
        Navigator.pop(context);
      });
    },
  );

  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    title: Center(
      child: Text(
        titleMessage,
        style: TextStyle(
            color: Colors.black, fontSize: 28.0, fontFamily: 'RobotoMono'),
      ),
    ),
    content: Text(
      contentMessage,
      style: TextStyle(
          color: Colors.black, fontSize: 19.0, fontFamily: 'RobotoMono'),
    ),
    actions: [
      yesButton,
      noButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class Description extends StatefulWidget {
  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 27),
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Text(
            _descriptionContent,
            style: TextStyle(fontSize: 30, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ));
  }
}

class _BoxContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          border: new Border.all(color: Colors.black),
        ),
        child: Center(
            child: GridView.count(
          primary: false,
          crossAxisCount: 3,
          children: List.generate(9, (index) {
            return Box(index);
          }),
        )));
  }
}

class Box extends StatefulWidget {
  final int index;
  Box(this.index);
  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {
  void pressed() {
    setState(() {
      _currentMoves++;
      if (checkTheGame()) {
        showAlertDialog(context, 'Result: ' + _winner.toUpperCase() + ' won',
            'Do you want to play again?');
      } else if (_currentMoves >= 9) {
        showAlertDialog(context, 'Result: Draw', 'Do you want to play again?');
      }
      // for 2 players
      _turnState.setState(() {
        if (_youVSAI == false) {
          if (_currentMoves % 2 == 0) {
            _turnContent = 'Turn: X';
          } else {
            _turnContent = 'Turn: O';
          }
        }
        _gamePageState.setState(() {});
      });
    });
  }

  @override
  Widget build(context) {
    return MaterialButton(
        padding: EdgeInsets.all(0),
        child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: new Border.all(color: Colors.black)),
            child: Center(
              child: Text(
                _board[widget.index],
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        onPressed: () {
          if (_winner == '') {
            if (_board[widget.index] == '') {
              // for 2 players
              if (_youVSAI == false) {
                // 0, 2, 4, 6, 8
                if (_currentMoves % 2 == 0)
                  _board[widget.index] = 'X';
                // 1, 3, 5, 7
                else
                  _board[widget.index] = 'O';
              }
              // for you vs ai
              else if (_youVSAI == true) {
                _board[widget.index] = 'X';
                if (checkTheGame() == false) {
                  moveByAI(_board);
                }
              }
              pressed();
            }
          }
        });
  }
}

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    _turnState = this;
    return Card(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Container(
          width: 175,
          height: 50,
          color: Colors.black,
          padding: EdgeInsets.fromLTRB(20, 7, 20, 0),
          child: Text(
            _turnContent,
            style: TextStyle(fontSize: 28, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ));
  }
}

void resetTheGame() {
  _currentMoves = 0;
  _board = ['', '', '', '', '', '', '', '', ''];
  _turnContent = 'Turn: X';
  _winner = '';
  if (_youVSAI == true) {
    moveByAI(_board);
  }
}

bool checkTheGame() {
  // for horizontal pattern
  for (int i = 0; i < 9; i += 3) {
    if (_board[i] != '' &&
        _board[i] == _board[i + 1] &&
        _board[i + 1] == _board[i + 2]) {
      _winner = _board[i];
      return true;
    }
  }
  // for vertical pattern
  for (int i = 0; i < 3; i++) {
    if (_board[i] != '' &&
        _board[i] == _board[i + 3] &&
        _board[i + 3] == _board[i + 6]) {
      _winner = _board[i];
      return true;
    }
  }
  // for diagonal pattern
  if (_board[0] != '' && (_board[0] == _board[4] && _board[4] == _board[8]) ||
      (_board[2] != '' && _board[2] == _board[4] && _board[4] == _board[6])) {
    _winner = _board[4];
    return true;
  }
  return false;
}

T getRandomElement<T>(List<T> list) {
  final random = new Random();
  var i = random.nextInt(list.length);
  return list[i];
}

void moveByAI(List<String> _board) {
  var availableNumbers = new List();
  for (int i = 0; i < 9; i++) {
    if (_board[i] == '') {
      availableNumbers.add(i);
    }
  }
  var x = getRandomElement(availableNumbers);
  _board[x] = 'O';
  availableNumbers.clear();
  _currentMoves = _currentMoves + 1;
}
