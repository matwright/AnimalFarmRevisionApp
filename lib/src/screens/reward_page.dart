import 'dart:ui' as prefix0;

import 'package:animal_farm/src/models/reward.dart';
import 'package:animal_farm/src/widgets/bottomnav_widget.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../models/appstate.dart';
import '../models/category.dart';
import  'package:avatar_glow/avatar_glow.dart';
class RewardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);


      return ValueBuilder(
          streamed: appState.rewardInfoStream,

          builder: (context, snapshot) {
            Reward reward = snapshot.data;
            String subHeader = "";

            return Scaffold(
                bottomNavigationBar:BottomNavWidget(selectedIndex: 0),
                appBar: AppBar(

                  leading: IconButton(icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  title: Text('Choose Your Reward'),
                ),


                // drawer: DrawerWidget(),
                body:

                FadeInWidget(
                  duration: 100,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child:


                         Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[






                                Container(
                                  width: double.infinity,

                                  child: AvatarGlow(
                                    startDelay: Duration(milliseconds: 1000),
                                    glowColor: Colors.yellow,
                                    endRadius: 120.0,

                                    duration: Duration(milliseconds: 2000),
                                    repeat: true,
                                    showTwoGlows: true,
                                    repeatPauseDuration: Duration(
                                        milliseconds: 100),
                                    child: Material(
                                        elevation: 8.0,
                                        shape: CircleBorder(

                                        ),
                                        color: Colors.white70,




                                          child: CircleAvatar(
                                            backgroundColor:  Theme.of(context).backgroundColor,

                                            backgroundImage: AssetImage(
                                                'assets/images/badge/' +
                                                    (reward == null
                                                        ? 'noavatar'
                                                        : 'firstHour') +
                                                    '.png'),
                                            radius: 100.0,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: <Widget>[
                                              ],
                                            ),
                                          ),

                                    ),
                                  ),
                                ),


                                Container(

                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  child:
                                  Center(
                                      child:
                                      Text(

                                        '"' + reward.achievement + '"',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(

                                          fontSize: 16.0,
                                          fontStyle: prefix0.FontStyle.italic,

                                          color: Colors.white,
                                          letterSpacing: 2.0,
                                          shadows: [
                                          ],
                                        ),
                                      )),


                                ),

                                Container(
                                  padding: EdgeInsets.all(20),

                                  child:

                                  Bubble(

                                      padding: BubbleEdges.all(10),

                                      child:Container(

                                          alignment: Alignment.center,
                                          child: new Scrollbar(

                                              child:new SingleChildScrollView(
                                                  scrollDirection: Axis.vertical,
                                                  reverse: false,primary: true,
                                                  child:



                                                  Text(
                                                    reward.description,

                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.0,
letterSpacing: 1,fontWeight: FontWeight.w300,


                                                      shadows: [
                                                      ],
                                                    ),
                                                  )
                                              )))
                                  ),




                                )


                              ],
                            )
                          ],

                    ),
                  ),
                )

            );
          }
      );
    }

  }

