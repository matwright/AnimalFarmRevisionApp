import 'dart:math';
import 'dart:ui' as prefix0;

import 'package:animal_farm/src/models/character.dart';
import 'package:animal_farm/src/models/theme.dart';
import 'package:animal_farm/src/widgets/bottomnav_widget.dart';
import 'package:animal_farm/src/widgets/rounded_button_widget.dart';
import 'package:animal_farm/src/widgets/wave_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';

import '../models/appstate.dart';

class MainPage extends StatelessWidget {
  MainPage({this.backgroundColor});

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);

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
                child: new Text("OinK, will do!"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    onBottom(Widget child) => Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: child,
          ),
        );

    return Scaffold(
        appBar: AppBar(
          title: Text('Animal Farm GCSE Revision'),
        ),
        drawer: DrawerWidget(),
        backgroundColor: backgroundColor,
        // drawer: DrawerWidget(),
        body: FadeInWidget(
          duration: 20,
          child: Container(
            child: ValueBuilder(
              streamed: appState.currentCharacter,
              noDataChild: const CircularProgressIndicator(),
              builder: (context, snapshot) {
                List greetings = [
                  "Production is constantly rising",
                  "The end of the revolution is nigh",
                  "Happy tomorrows",
                  "Production is constantly rising"
                ].toList();
                Character character = snapshot.data;

                //only show notice if no avatar set and current context is this page
                if (character.id == "noavatar" &&
                    ModalRoute.of(context).isCurrent) {
                  Future.delayed(Duration(seconds: 1), () => _showDialog());

                  Prefs.savePref('messageShown', true);
                }
                return Stack(
                  children: <Widget>[
                    Positioned.fill(child: AnimatedBackground()),
                    onBottom(AnimatedWave(
                      height: 180,
                      speed: 0.1,
                    )),
                    onBottom(AnimatedWave(
                      height: 120,
                      speed: 0.2,
                      offset: pi,
                    )),
                    onBottom(AnimatedWave(
                      height: 220,
                      speed: 0.3,
                      offset: pi / 2,
                    )),
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      child: new Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        decoration: new BoxDecoration(
                            color: Colors.grey.shade200.withOpacity(0.2)),
                        child: new Center(
                          child: new Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: Text(
                                  'Hey, ' + character.name,
                                  style: TextStyle(
                                    color: Colors.brown.shade900,
                                    fontSize: 36.0,
                                    fontFamily: 'PermanentMarker',
                                    letterSpacing: 2.0,
                                    shadows: [],
                                  ),
                                ),
                              ),
                              Center(
                                child: FadeAnimatedTextKit(
                                    text: greetings,
                                    duration: Duration(seconds: 60),
                                    isRepeatingAnimation: true,
                                    textStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: 'SpecialElite',
                                    ),
                                    textAlign: TextAlign.center,
                                    alignment: AlignmentDirectional
                                        .center // or Alignment.topLeft
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: AvatarGlow(
                        startDelay: Duration(milliseconds: 1000),
                        glowColor: (character.color != null
                            ? character.color
                            : Colors.blueGrey),
                        endRadius: 175.00,
                        duration: Duration(milliseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        repeatPauseDuration: Duration(milliseconds: 100),
                        child: Material(
                            elevation: 25.0,
                            shape: CircleBorder(),
                            color: (character.color != null
                                ? character.color.withOpacity(0.9)
                                : Colors.blueGrey.withOpacity(0.9)),
                            child: FlatButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, "/avatar"),
                              child: CircleAvatar(
                                backgroundColor: (character.color != null
                                    ? character.color.withOpacity(0.9)
                                    : Colors.blueGrey),
                                backgroundImage: AssetImage(
                                    'assets/images/avatar/' +
                                        (character == null
                                            ? 'noavatar'
                                            : character.id) +
                                        '.png'),
                                maxRadius: 150.00,
                              ),
                            )),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 25),
                          child: RoundedButtonWidget(
                              height: 60,
                              width: 300,
                              route: "trivia",
                              buttonText: "Let's Revise Animal Farm!")),
                    )
                  ],
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: BottomNavWidget(selectedIndex: 0));
  }
}

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);

    List<Widget> _buildThemesList() {
      return appState.themes.map((MyTheme appTheme) {
        return DropdownMenuItem<MyTheme>(
          value: appTheme,
          child: Text(appTheme.name, style: const TextStyle(fontSize: 14.0)),
        );
      }).toList();
    }

    return ValueBuilder(
        streamed: appState.stopwatchStream,
        builder: (context, snapshot) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Align(
                    alignment: Alignment.center,
                    child: Wrap(
                      children: <Widget>[
                        Center(
                          child: const Text(
                            'Animal Farm',
                            style: TextStyle(
                              fontFamily: "PermanentMarker",
                              fontSize: 28.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 4.0,
                            ),
                          ),
                        ),
                        Center(
                          child: const Text(
                            'GCSE Revision',
                            style: TextStyle(
                              fontFamily: "Raleway",
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 4.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                ListTile(
                    leading: Icon(
                      Icons.info,
                      size: 32,
                    ),
                    title: const Text('Instructions'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        '/instructions',
                      );
                    }),
                ListTile(
                  leading: Icon(
                    Icons.timelapse,
                    size: 32,
                  ),
                  title: const Text('Your Progress'),
                  onTap: () {
                    Navigator.pushNamed(context, '/progress');
                  },
                ),
                ListTile(
                    title: const Text('Colour Theme'),
                    leading: Icon(
                      Icons.color_lens,
                      size: 32,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    ValueBuilder<MyTheme>(
                        streamed: appState.currentTheme,
                        builder: (context, snapshot) {
                          return DropdownButton<MyTheme>(
                            hint: const Text('Theme'),
                            value: snapshot.data,
                            items: _buildThemesList(),
                            onChanged: appState.setTheme,
                          );
                        }),
                  ],
                ),
                AboutListTile(
                  applicationIcon: Icon(Icons.info_outline),
                  applicationName: "This App",
                  applicationVersion: "1.0.0.beta",
                  icon: Icon(
                    Icons.info_outline,
                    size: 32,
                  ),
                  applicationLegalese:
                      "MA Creative App Development\n\nMatthew Wright\nAllegra Gee\nKurt Wunderlich\n\nhttps://www.falmouth.ac.uk\n\n",
                  aboutBoxChildren: <Widget>[
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: CircleAvatar(
                                maxRadius: 50,
                                minRadius: 25,
                                backgroundColor: Colors.white.withOpacity(0),
                                backgroundImage:
                                    AssetImage('assets/icon/falmouth.png'))))
                  ],
                ),
              ],
            ),
          );
        });
  }
}
