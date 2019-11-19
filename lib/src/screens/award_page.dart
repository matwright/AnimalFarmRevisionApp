import 'dart:ui' as prefix0;

import 'package:animal_farm/src/models/award.dart';
import 'package:animal_farm/src/widgets/bottomnav_widget.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../models/appstate.dart';
import '../models/category.dart';
import  'package:avatar_glow/avatar_glow.dart';
class AwardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);


      return ValueBuilder(
          streamed: appState.awardInfoStream,

          builder: (context, snapshot) {
            Award award = snapshot.data;
            String subHeader = "";

            return Scaffold(
                bottomNavigationBar:BottomNavWidget(selectedIndex: 0),
                appBar: AppBar(

                  leading: IconButton(icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  title: Text(award.name),
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

                                  padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                                  child:
                                  Center(
                                      child:
                                      Text(

                                        'Achievement: ' + award.achievement + '!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(

                                          fontSize: 16.0,
fontWeight: FontWeight.bold,

                                          color: Colors.white,
                                          letterSpacing: 2.0,
                                          shadows: [
                                          ],
                                        ),
                                      )),


                                ),



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
                                                    (award.image == null
                                                        ? 'noavatar.png'
                                                        : award.image)
                                                 ),
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

                                        '"' + award.name + '"',
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
                                      color: Theme.of(context).primaryColor,
                                      padding: BubbleEdges.all(10),

                                      child:Container(

                                          alignment: Alignment.center,
                                          child: new Scrollbar(

                                              child:new SingleChildScrollView(
                                                  scrollDirection: Axis.vertical,
                                                  reverse: false,primary: true,
                                                  child:



                                                  Text(
                                                    award.description,

                                                    style: TextStyle(
                                                      color: Theme.of(context).appBarTheme.color,
                                                      fontSize: 16.0,
letterSpacing: 0.8,fontWeight: FontWeight.w300,


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

