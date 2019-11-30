import 'dart:ui' as prefix0;

import 'package:animal_farm/src/models/award.dart';
import 'package:animal_farm/src/widgets/bottomnav_widget.dart';
import 'package:bubble/bubble.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';

import '../models/appstate.dart';

class AwardPage extends StatelessWidget {

  AwardPage({this.backgroundColor});

  final Color backgroundColor;
  final FlareControls _controls = FlareControls();
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);

    return ValueBuilder(
        streamed: appState.awardInfoStream,
        builder: (context, snapshot) {
          Award award = snapshot.data;


          return Scaffold(
              bottomNavigationBar: BottomNavWidget(selectedIndex: 2),
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context, false),
                ),
                title: Text(award.name),
              ),
              backgroundColor: backgroundColor,
              // drawer: DrawerWidget(),
              body: FadeInWidget(
                duration: 100,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[

                          Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                            child: Center(
                                child: Text(
                             award.achievement + '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "PermanentMarker",
                                fontSize:24.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                shadows: [],
                              ),
                            )),
                          ),

                         Container(
                            padding: EdgeInsets.all(10),
                            height: 300,
                            width: 300,
                            child:(award != null
                                ?
                            FlareActor('assets/images/badge/' +
                                award.image+'.flr',
                                alignment:Alignment.center,
                                fit:BoxFit.contain,
                                controller: _controls,
                                animation: award.image,
                                color: Colors.lime,
                                isPaused:false
                            )  :
                            CircleAvatar(
                                backgroundColor:
                                Colors.white.withOpacity(0),
                                backgroundImage:
                                AssetImage(
                                    'assets/images/badge/medal.png')
                            )
                            ),
                          ),

              /*
                          Expanded(

                            child:
GestureDetector(
  onTap:()=>_controls.play("success"),
  child: FlareActor("assets/images/badge/badgeOne.flr",
      alignment:Alignment.center,
      fit:BoxFit.contain,
      controller: _controls,
      animation: "Untitled",
      color: Colors.lime,
      isPaused:false
  ) ,
)
                   ,
                          )
                */

              Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                            child: Center(
                                child: Text(
                              '"' + award.name + '"',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Raleway",
                                fontSize: 18.0,
                                fontStyle: prefix0.FontStyle.italic,
                                letterSpacing: 2.0,
                                shadows: [],
                              ),
                            )),
                          ),
                          Container(
                            child: Bubble(
                                color: Theme.of(context).secondaryHeaderColor,
                                padding: BubbleEdges.all(10),
                                margin: BubbleEdges.fromLTRB(10, 10, 10, 0),
                                child: Container(
                                    alignment: Alignment.center,
                                    child: new Scrollbar(
                                        child: new SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            reverse: false,
                                            primary: true,
                                            child: Text(
                                              award.description,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .appBarTheme
                                                    .color,
                                                fontSize: 16.0,
                                                letterSpacing: 0.8,
                                                fontWeight: FontWeight.w300,
                                                fontFamily: "Raleway",
                                                shadows: [],
                                              ),
                                            ))))),
                          )
                        ],

                  ),
                ),
              ));
        });
  }
}
