import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';

import '../models/appstate.dart';

class InstructionsPage extends StatefulWidget {
  @override
  _InstructionsPageState createState() => _InstructionsPageState();
}

class _InstructionsPageState extends State<InstructionsPage> {
  final countdownController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);

    countdownController.text =
        (appState.triviaBloc.countdown / 1000).toStringAsFixed(0);

    amountController.text = (appState.questionsAmount.value);


    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Instructions',
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Container(
                  margin: EdgeInsets.all(20),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text('Welcome to your Animal Farm revision app.',
                          style: Theme.of(context).textTheme.headline),
                      new Container(
                        margin: const EdgeInsets.only(top: 25.0),
                      child:
                      new Text('Pick A Character'
                          ,
                          style: Theme.of(context).textTheme.subhead),
                      ),

                      new Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: new Text(
                            'Start by choosing an character to represent who you\'d like to play as. Have a look through and read each character\'s brief biography (which may give some clues to later questions) and choose who you want to help you with your revision.'),
                      ),
                    ],
                  ),
                ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Container(
                  margin: EdgeInsets.all(20),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text('Quiz & Awards',
                          style: Theme.of(context).textTheme.subhead),
                      new Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: new Text(
                            'Once you have chosen a character, you will achieve your first award! There are 15 awards to achieve which you will receive for different things, such as answering a certain number of questions correctly or your time spent using the app'),
                      ),
                    ],
                  ),
                ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Container(
                  margin: EdgeInsets.all(20),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text('Trotter Social',
                          style: Theme.of(context).textTheme.subhead),
                      new Container(
                        margin: const EdgeInsets.only(top: 5.0,bottom:20),
                        child: new Text(
                            'Keep your eyes open for Animal Farm’s social media feed, Trotter, giving you additional hints into the characters and the story.'),
                      ),
                      new Text('Happy Revision !',


                          style: TextStyle(fontFamily: "PermanentMarker",fontSize: 32),),

                    ],
                  ),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
