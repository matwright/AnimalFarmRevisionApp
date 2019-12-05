import 'package:animal_farm/src/models/character.dart';
import 'package:animal_farm/src/widgets/bottomnav_widget.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';
import 'package:slimy_card/slimy_card.dart';

import '../models/appstate.dart';

class BioPage extends StatelessWidget {
  BioPage({this.backgroundColor});

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        bottomNavigationBar: BottomNavWidget(selectedIndex: 0),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: Text('Choose Your Character'),
        ),
        backgroundColor: backgroundColor,
        // drawer: DrawerWidget(),
        body: FadeInWidget(
            duration: 100,
            child: Center(
                child: ValueBuilder(
                    streamed: appState.bioCharacter,
                    noDataChild: const CircularProgressIndicator(),
                    builder: (context, snapshot) {
                      Character character = snapshot.data;
                      void selectCharacter(String character) {
                        appState.chooseCharacter(character);
                        Navigator.pushNamed(context, '/');
                      }

                      return Container(
                          height: double.maxFinite,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Stack(
                            children: <Widget>[
                              SlimyCard(
                                color: character.color,
                                width: MediaQuery.of(context).size.width,
                                topCardHeight: (size.width > 600
                                    ? 525
                                    : size.height / 2.75),
                                bottomCardHeight: ((size.width > 600
                                    ? size.height - 815
                                    : size.height / 4)),
                                borderRadius: 15,
                                topCardWidget: TopCard(),
                                bottomCardWidget: BottomCard(),
                                slimeEnabled: true,
                              ),
                              Positioned(
                                  child: Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: FloatingActionButton.extended(
                                        elevation: 2,
                                        label: Text(
                                          "Play As " + character.name,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        icon: Icon(Icons.check_circle_outline),
                                        backgroundColor: character.color,
                                        foregroundColor: character.textColor,
                                        onPressed: () =>
                                            selectCharacter(character.id))),
                              )),
                            ],
                          ));
                    }))));
  }
}

class TopCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);
    final Size size = MediaQuery.of(context).size;
    return ValueBuilder(
        streamed: appState.bioCharacter,
        noDataChild: const CircularProgressIndicator(),
        builder: (context, snapshot) {
          Character character = snapshot.data;

          return Column(
            children: <Widget>[
              AvatarGlow(
                  startDelay: Duration(milliseconds: 1000),
                  glowColor: character.textColor,
                  endRadius: (size.width > 600 ? 200.0 : size.width / 5),
                  duration: Duration(milliseconds: 3000),
                  repeat: true,
                  showTwoGlows: true,
                  repeatPauseDuration: Duration(milliseconds: 500),
                  child: CircleAvatar(
                    backgroundColor:
                        (character != null ? character.color : Colors.white),
                    backgroundImage: AssetImage('assets/images/avatar/' +
                        (character == null ? 'noavatar' : character.id) +
                        '.png'),
                    radius: (size.width > 600 ? 180.0 : size.width / 6),
                    child: Container(),
                  )),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Text(
                  '"' + character.strapLine + '"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 21.0,
                    color: character.textColor,
                    fontFamily: "PermanentMarker",
                    letterSpacing: 1.5,
                    shadows: [],
                  ),
                ),
              ),
            ],
          );
        });
  }
}

class BottomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);
    final Size size = MediaQuery.of(context).size;
    return ValueBuilder(
        streamed: appState.bioCharacter,
        noDataChild: const CircularProgressIndicator(),
        builder: (context, snapshot) {
          Character character = snapshot.data;

          return Center(
              child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                    child: new Scrollbar(
                        child: new SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  reverse: false,
                  primary: true,
                  child: Text(
                    character.bio,
                    textScaleFactor: 1.2,
                    style: TextStyle(
                      fontSize: (size.width > 600 ? 32 : 16.0),
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Raleway",
                      color: character.textColor.withOpacity(0.8),
                      shadows: [],
                    ),
                  ),
                ))),
              )
            ],
          ));
        });
  }
}
