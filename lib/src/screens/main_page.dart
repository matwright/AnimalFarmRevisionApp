import 'dart:ui' as prefix0;

import 'package:animal_farm/src/models/character.dart';
import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../models/appstate.dart';
import '../models/category.dart';
import  'package:avatar_glow/avatar_glow.dart';
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);

    return FadeInWidget(
      duration: 750,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 36.0),
        child: ValueBuilder<List<Character>>(
          streamed: appState.characterStream,
          noDataChild: const CircularProgressIndicator(),
          builder: (context, snapshot) {


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
                        glowColor: Colors.white,
                        endRadius: 100.0,
                        duration: Duration(milliseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        repeatPauseDuration: Duration(milliseconds: 100),
                        child: Material(
                          elevation: 8.0,
                          shape: CircleBorder(),
                          color: Colors.green,
                          child: CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            backgroundImage: AssetImage('assets/images/avatar/avatar.png'),
                            radius: 80.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28.0, vertical: 56.0),

                      child: const Text(
                        'Animal Farm',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Raleway' ,
                          color: Colors.white,
                          letterSpacing: 4.0,
                          shadows: [

                          ],
                        ),
                      ),


                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28.0, vertical: 1.0),

                      child: const Text(
                        'GCSE Revision App',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Raleway' ,
                          color: Colors.white,
                          letterSpacing: 4.0,
                          shadows: [

                          ],
                        ),


                      ),


                    ),

                  ],
                ),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    height: 36,
                    width: 90,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(35),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blue,
                              blurRadius: 2.0,
                              spreadRadius: 2.5),
                        ]),
                    child: const Text(
                      "Let's Revise!",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  onTap: appState.startTrivia,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
