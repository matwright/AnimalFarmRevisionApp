import 'package:animal_farm/src/models/models.dart';
import 'package:animal_farm/src/screens/avatar_page.dart';
import 'package:animal_farm/src/screens/bio_page.dart';
import 'package:animal_farm/src/screens/main_page.dart';
import 'package:animal_farm/src/screens/messages_page.dart';
import 'package:animal_farm/src/screens/rewards_page.dart';
import 'package:animal_farm/src/screens/summary_page.dart';
import 'package:animal_farm/src/screens/trivia_page.dart';
import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import 'src/models/appstate.dart';
import 'src/models/theme.dart';


void main()async {

  runApp(App());
}

class App extends StatelessWidget  {
  final appState = AppState();

  @override
  Widget build(BuildContext context) {
    return AppStateProvider<AppState>(
      appState: appState,
      child: MaterialPage(),
    );
  }
}

class MaterialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = AppStateProvider.of<AppState>(context).currentTheme;

    return ValueBuilder<MyTheme>(
        streamed: theme,
        builder: (context, snapshot) {
          return MaterialApp(
              title: 'Animal Farm GCSE Revision App',
              theme: _buildThemeData(snapshot.data),
              home: MainPage(),
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/rewards': (context) => RewardsPage(),
            '/trivia': (context) => TriviaPage(),
            '/summary': (context) => SummaryPage(),
            '/avatar': (context) => AvatarPage(),
            '/bio': (context) => BioPage(),
            '/messages': (context) => MessagesPage(),
          //  main,rewards,messages, trivia, summary, stats, avatar,bio
        });
        });
  }

  ThemeData _buildThemeData(MyTheme appTheme) {
    return ThemeData(
      splashColor:appTheme.accentColor,
      focusColor:appTheme.scaffoldBackgroundColor,
      cardColor:appTheme.cardColor,
      brightness: appTheme.brightness,
      backgroundColor: appTheme.backgroundColor,
      scaffoldBackgroundColor: appTheme.scaffoldBackgroundColor,
      primaryColor: appTheme.primaryColor,
      primaryColorBrightness: appTheme.primaryColorBrightness,
      accentColor: appTheme.accentColor,
      accentColorBrightness:  Brightness.light,
      bottomAppBarColor: appTheme.bottomAppBarColor,
      dividerColor: appTheme.dividerColor,
      buttonColor: appTheme.buttonColor,
      secondaryHeaderColor: appTheme.secondaryHeaderColor,

    );
  }
}
