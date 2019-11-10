import 'dart:math';
import 'dart:ui' as prefix0;

import 'package:animal_farm/src/models/character.dart';
import 'package:animal_farm/src/screens/settings_page.dart';
import 'package:animal_farm/src/widgets/bottomnav_widget.dart';
import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../models/appstate.dart';
import 'package:avatar_glow/avatar_glow.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);
    bool messageShown = false;
    void _showDialog() {
      // flutter defined function
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {

          // return object of type Dialog
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.all(new Radius.circular(20.0))),
            backgroundColor: Colors.blueGrey,
            title: new Text("Welcome Comrade!"),
            contentTextStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              fontFamily: 'Raleway',
              color: Colors.white70,
              letterSpacing: 2.0,
              shadows: [],
            ),
            content: new Text(
                "To get the revolution underway, select a character by clicking the profile image. "),
            titleTextStyle: TextStyle(
              fontStyle: prefix0.FontStyle.italic,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'Raleway',
              color: Colors.white70,
              letterSpacing: 3.0,
              shadows: [],
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("okay, will do!"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return ValueBuilder(
        streamed: appState.tabController,
        builder: (context, snapshotTabs) {
          return ValueBuilder(
              streamed: appState.numMessages,
              builder: (context, snapshotNumMessages) {
               List greetings=[
                  "Production is constantly rising!",
                  "The end of the revolution is nigh!",
                      "Happy tomorrows!",
                      "Production is constantly rising!"].toList()..shuffle();




                return Scaffold(
                    appBar: AppBar(
                      title: Text('Home'),
                    ),
                    drawer: DrawerWidget(),
                    // drawer: DrawerWidget(),
                    body: FadeInWidget(
                      duration: 100,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: ValueBuilder(
                          streamed: appState.currentCharacter,
                          noDataChild: const CircularProgressIndicator(),
                          builder: (context, snapshot) {
                            Character character = snapshot.data;
                            String subHeader = greetings.first;

                            //only show notice if no avatar set and current context is this page
                            if (character.id == "noavatar" &&
                                ModalRoute.of(context).isCurrent) {
                              Future.delayed(
                                  Duration(seconds: 1), () => _showDialog());
                              subHeader =
                                  "Click avatar to select your character";
                              Prefs.savePref('messageShown', true);
                            }
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: const Text(
                                        'Animal Farm',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Raleway',
                                          color: Colors.white70,
                                          letterSpacing: 3.0,
                                          shadows: [],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 50.0),
                                      child: const Text(
                                        'GCSE Revision App',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Raleway',
                                          color: Colors.white70,
                                          letterSpacing: 3.0,
                                          shadows: [],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Text(
                                        'Hey, ' + character.name,
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Raleway',
                                          color: Colors.white,
                                          letterSpacing: 2.0,
                                          shadows: [],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 50.0),
                                      child: Text(
                                        subHeader,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Raleway',
                                          color: Colors.white,
                                          letterSpacing: 2.0,
                                          shadows: [],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: AvatarGlow(
                                        startDelay:
                                            Duration(milliseconds: 1000),
                                        glowColor: Colors.white,
                                        endRadius: 120.0,
                                        duration: Duration(milliseconds: 2000),
                                        repeat: true,
                                        showTwoGlows: true,
                                        repeatPauseDuration:
                                            Duration(milliseconds: 100),
                                        child: Material(
                                            elevation: 8.0,
                                            shape: CircleBorder(),
                                            color: Colors.white70,
                                            child: FlatButton(
                                              onPressed: () =>
                                                  Navigator.pushNamed(
                                                      context, "/avatar"),
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    (character != null
                                                        ? character.color
                                                        : Colors.blueGrey),
                                                backgroundImage: AssetImage(
                                                    'assets/images/avatar/' +
                                                        (character == null
                                                            ? 'noavatar'
                                                            : character.id) +
                                                        '.png'),
                                                radius: 100.0,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[],
                                                ),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 60,
                                    width: 150,
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
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                  onTap:()=> Navigator.pushNamed(context, "/trivia"),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    bottomNavigationBar: BottomNavWidget(selectedIndex: 0));
              });
        });
  }
}

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);

    int elapsed = appState.getStopwatch();

    //String elapsed=" seconds";
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: const Text(
                'Animal Farm',
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 4.0,
                  shadows: [
                    Shadow(
                      blurRadius: 8.0,
                      color: Colors.lightGreenAccent,
                      offset: Offset(3.0, 4.5),
                    ),
                  ],
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
          AboutListTile(
            child: Text(elapsed.toString() + " minutes"),
          ),
        ],
      ),
    );
  }
}
