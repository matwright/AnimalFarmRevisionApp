import 'package:animal_farm/src/models/message.dart';
import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../models/appstate.dart';

class ProgressPage extends StatelessWidget {
  ProgressPage({this.backgroundColor});

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);
    appState.loadMessages();

    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
            title: Text('App Progress')),
        backgroundColor: backgroundColor,
        body: FadeInWidget(
            duration: 20,
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ValueBuilder<int>(
                    streamed: appState.stopwatchStream,
                    builder: (context, stopwatch) {
                      int hoursSpent = (stopwatch.data / 3600).ceil();

                      return ValueBuilder<int>(
                          streamed: appState.awardsUnseenStream,
                          builder: (context, unseenAwards) {
                            double awardsCompleted = (unseenAwards.data / 15);

                            return ValueBuilder<List<Message>>(
                                streamed: appState.messagesStream,
                                noDataChild: const CircularProgressIndicator(),
                                builder: (context, snapshot) {
                                  double indicatorWidth =
                                      MediaQuery.of(context).size.width / 2;
                                  return Scaffold(
                                      backgroundColor: backgroundColor,
                                      body: ListView(children: <Widget>[
                                        new CircularPercentIndicator(
                                          radius: indicatorWidth,
                                          lineWidth: 25.0,
                                          percent: ((snapshot.data.length / 240)
                                              .toDouble()),
                                          header: new Text("App Progress"),
                                          center: new Text(
                                            (((snapshot.data.length / 240) *
                                                        100)
                                                    .ceil()
                                                    .toString()) +
                                                "%",
                                            style: new TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0),
                                          ),
                                          backgroundColor: Colors.grey,
                                          progressColor: Colors.blue,
                                        ),
                                        new CircularPercentIndicator(
                                          radius: indicatorWidth,
                                          animation: true,
                                          animationDuration: 1200,
                                          lineWidth: 20.0,
                                          percent: (hoursSpent / 20),
                                          center: new Text(
                                            hoursSpent.toString() + " hours",
                                            style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          header:
                                              new Text("Time Spent Revising"),
                                          circularStrokeCap:
                                              CircularStrokeCap.butt,
                                          backgroundColor: Colors.yellow,
                                          progressColor: Colors.red,
                                        ),
                                        new CircularPercentIndicator(
                                          radius: indicatorWidth,
                                          lineWidth: 20.0,
                                          animation: true,
                                          percent: awardsCompleted,
                                          center: new Text(
                                            ((awardsCompleted * 100)
                                                    .ceil()
                                                    .toString()) +
                                                "%",
                                          ),
                                          header: new Text("Awards Achieved"),
                                          circularStrokeCap:
                                              CircularStrokeCap.round,
                                          progressColor: Colors.purple,
                                        ),
                                      ]));
                                });
                          });
                    }))));
  }
}
