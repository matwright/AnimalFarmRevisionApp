import 'dart:ui' as prefix0;

import 'package:animal_farm/src/models/character.dart';
import 'package:animal_farm/src/widgets/bottomnav_widget.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../models/appstate.dart';
import '../models/category.dart';
import  'package:avatar_glow/avatar_glow.dart';
class BioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);


      return ValueBuilder(
          streamed: appState.numMessages,
          builder: (context, snapshotNumMessages) {

            void selectCharacter(String character){
              appState.chooseCharacter(character);
              Navigator.pushNamed(context, '/');
            }
            return Scaffold(
                bottomNavigationBar:BottomNavWidget(selectedIndex: 0),
                appBar: AppBar(

                  leading: IconButton(icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  title: Text('Choose Your Character'),
                ),


                // drawer: DrawerWidget(),
                body:

                FadeInWidget(
                  duration: 100,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: ValueBuilder(
                      streamed: appState.bioCharacter,
                      noDataChild: const CircularProgressIndicator(),
                      builder: (context, snapshot) {
                        Character character = snapshot.data;
                        String subHeader = "";

                        return Column(
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

                                        child: GestureDetector(

                                          onTap: appState.characterChoices,

                                          child: CircleAvatar(
                                            backgroundColor: (character != null
                                                ? character.color
                                                : Colors.white),

                                            backgroundImage: AssetImage(
                                                'assets/images/avatar/' +
                                                    (character == null
                                                        ? 'noavatar'
                                                        : character.id) +
                                                    '.png'),
                                            radius: 100.0,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: <Widget>[
                                              ],
                                            ),
                                          ),
                                        )
                                    ),
                                  ),
                                ),


                                Container(

                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  child:
                                  Center(
                                      child:
                                      Text(

                                        '"' + character.strapLine + '"',
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
                                      color: character.color,
                                      child:Container(
                                          height: 170,
                                          alignment: Alignment.center,
                                          child: new Scrollbar(

                                              child:new SingleChildScrollView(
                                                  scrollDirection: Axis.vertical,
                                                  reverse: false,primary: true,
                                                  child:



                                                  Text(
                                                    character.bio,

                                                    style: TextStyle(
                                                      fontSize: 16.0,
letterSpacing: 1,fontWeight: FontWeight.w300,
                                                      color: character.textColor,

                                                      shadows: [
                                                      ],
                                                    ),
                                                  )
                                              )))
                                  ),




                                )


                              ],
                            ),
                            GestureDetector(
                              child: Container(
                                alignment: Alignment.center,
                                height: 60,
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                decoration: BoxDecoration(
                                    color: Theme
                                        .of(context)
                                        .primaryColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(35),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.blue,
                                          blurRadius: 2.0,
                                          spreadRadius: 2.5),
                                    ]),
                                child: Text(
                                  "Play As " + character.name,
                                  style: TextStyle(

                                    fontWeight: FontWeight.w400,
                                    fontSize: 20.0,),
                                ),
                              ),
                                onTap: ()=>selectCharacter(character.id)

                            ),
                          ],
                        );
                      },
                    ),
                  ),
                )

            );
          }
      );
    }

  }

