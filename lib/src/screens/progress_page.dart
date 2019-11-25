import 'package:animal_farm/src/models/character.dart';
import 'package:animal_farm/src/models/location.dart';
import 'package:animal_farm/src/models/message.dart';
import 'package:animal_farm/src/widgets/avatar_dialog_widget.dart';
import 'package:animal_farm/src/widgets/bottomnav_widget.dart';
import 'package:animal_farm/src/widgets/message_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../util/data.dart';
import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';

import '../models/appstate.dart';

class ProgressPage extends StatelessWidget {

  ProgressPage({this.backgroundColor});

  final Color backgroundColor;


  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);
    appState.loadMessages();




    return Scaffold(
        bottomNavigationBar: BottomNavWidget(selectedIndex: 3),
        appBar:
            AppBar(leading: Icon(Icons.chat), title: Text('App Progress')),
        backgroundColor: backgroundColor,
        body: FadeInWidget(
            duration: 20,
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ValueBuilder<List<Message>>(
                    streamed: appState.messagesStream,
                    noDataChild: const CircularProgressIndicator(),
                    builder: (context, snapshot) {
                      double indicatorWidth=MediaQuery.of(context).size.width/2;
                      return Scaffold(
                          backgroundColor: backgroundColor,
                          body:
                          ListView(
                          children: <Widget>[
                          new CircularPercentIndicator(
                          radius:indicatorWidth,
                          lineWidth: 25.0,
                          percent: 0.8,
                          header: new Text("Icon header"),
                      center: new Icon(
                      Icons.person_pin,
                      size: 50.0,
                      color: Colors.blue,
                      ),
                      backgroundColor: Colors.grey,
                      progressColor: Colors.blue,
                      ),
                      new CircularPercentIndicator(
                      radius:indicatorWidth,
                      animation: true,
                      animationDuration: 1200,
                      lineWidth: 20.0,
                      percent: 0.4,
                      center: new Text(
                      "40 hours",
                      style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                        footer: new Text(
                          "Hours Revised",
                          style:
                          new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                        ),
                      circularStrokeCap: CircularStrokeCap.butt,
                      backgroundColor: Colors.yellow,
                      progressColor: Colors.red,
                      ),
                      new CircularPercentIndicator(
                      radius: indicatorWidth,
                      lineWidth: 20.0,
                      animation: true,
                      percent: ((snapshot.data.length/240).toDouble()),
                      center: new Text(
                        (((snapshot.data.length/240)*100).ceil().toString())+"%",
                      style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      footer: new Text(
                      "Revision Target",
                      style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.purple,
                      ),


                      ]));

                    }))));
  }
}
