import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'about_screen.dart';
import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    showAlertDialog(BuildContext context) {
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
          SystemNavigator.pop();
        },
      );

      AlertDialog alert = AlertDialog(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Attention",
            style: TextStyle(
                color: Colors.black, fontSize: 28.0, fontFamily: 'RobotoMono'),
          ),
        ),
        content: Text(
          "Are you sure you want to exit?",
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

    final buttonYouVSAI = Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return GameScreen(true);
          }));
        },
        padding: EdgeInsets.all(12),
        color: Colors.yellow,
        child: Text('You VS AI',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            )),
      ),
    );

    final buttonTwoPlayers = Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return GameScreen(false);
          }));
        },
        padding: EdgeInsets.all(12),
        color: Colors.yellow,
        child: Text('2 Players',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            )),
      ),
    );

    final buttonAbout = Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AboutScreen();
          }));
        },
        padding: EdgeInsets.all(12),
        color: Colors.yellow,
        child: Text('About',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            )),
      ),
    );

    final buttonExit = Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () {
          showAlertDialog(context);
        },
        padding: EdgeInsets.all(12),
        color: Colors.yellow,
        child: Text('Exit',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            )),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Tic Tac Toe'),
        actions: <Widget>[],
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [const Color(0xFF000000), const Color(0xFF000000)])),
          padding: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(
                      Icons.close,
                      size: 140,
                      color: Colors.yellow,
                    ),
                    Text(
                      'VS',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 19.0,
                      ),
                    ),
                    Icon(
                      Icons.radio_button_unchecked,
                      size: 108,
                      color: Colors.yellow,
                    )
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: 310,
                  padding: EdgeInsets.all(0),
                  child: Text(
                    'Instructions: Create a horizontal or vertical or diagonal pattern to win.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'RobotoMono'),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  width: 310,
                  padding: EdgeInsets.all(0),
                  child: Text(
                    'Control: Tap only.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'RobotoMono'),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              buttonYouVSAI,
              buttonTwoPlayers,
              buttonAbout,
              buttonExit,
            ],
          )),
    );
  }
}
