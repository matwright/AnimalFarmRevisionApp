import 'dart:ui' as prefix0;

import 'package:animal_farm/src/models/character.dart';
import 'package:animal_farm/src/models/theme.dart';
import 'package:animal_farm/src/screens/instructions_page.dart';
import 'package:animal_farm/src/widgets/bottomnav_widget.dart';
import 'package:animal_farm/src/widgets/rounded_button_widget.dart';
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
            padding: const EdgeInsets.only(bottom: 10.0),
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
                return Column(
                  children: <Widget>[
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
                                    fontSize: 36.0,
                                    fontFamily: 'PermanentMarker',
                                    letterSpacing: 2.0,
                                    shadows: [],
                                  ),
                                ),
                              ),
                              Center(
                                child: TypewriterAnimatedTextKit(
                                    text: greetings,
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
                    Expanded(
                        child: Container(
                            child: Center(
                      child: AvatarGlow(
                        startDelay: Duration(milliseconds: 1000),
                        glowColor: (character != null
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
                            color: (character != null
                                ? character.color.withOpacity(0.4)
                                : Colors.blueGrey.withOpacity(0.4)),
                            child: FlatButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, "/avatar"),
                              child: CircleAvatar(
                                backgroundColor: (character != null
                                    ? character.color.withOpacity(0.2)
                                    : Colors.blueGrey),
                                backgroundImage: AssetImage(
                                    'assets/images/avatar/' +
                                        (character == null
                                            ? 'noavatar'
                                            : character.id) +
                                        '.png'),
                                maxRadius: 150.00,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[],
                                ),
                              ),
                            )),
                      ),
                    ))),
                    RoundedButtonWidget(
                        route: "trivia", buttonText: "Let's Revise!"),
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
                  child: Center(
                    child: const Text(
                      'Animal Farm',
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 4.0,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.info,
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    size: 32,
                  ),
                  title: const Text('Instructions'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),
                ListTile(
                    title: const Text('Colour Theme'),
                    leading: Icon(
                      Icons.color_lens,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
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
                  applicationIcon: Image(
                      image: AssetImage('assets/images/trotter.png'),
                      width: 64),
                  applicationName: "Animal Farm",
                  applicationVersion: "1.0.0.beta",
                  icon: Image(
                      image: AssetImage('assets/images/trotter.png'),
                      width: 32),
                  applicationLegalese: "More equal than the others",
                )
              ],
            ),
          );
        });
  }
}
