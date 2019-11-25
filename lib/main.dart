
import 'package:animal_farm/src/screens/avatar_page.dart';
import 'package:animal_farm/src/screens/bio_page.dart';
import 'package:animal_farm/src/screens/main_page.dart';
import 'package:animal_farm/src/screens/messages_page.dart';
import 'package:animal_farm/src/screens/award_page.dart';
import 'package:animal_farm/src/screens/awards_page.dart';
import 'package:animal_farm/src/screens/progress_page.dart';
import 'package:animal_farm/src/screens/summary_page.dart';
import 'package:animal_farm/src/screens/trivia_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:frideos/frideos.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/models/appstate.dart';
import 'src/models/theme.dart';

void main()async {

  runApp(App());
}

class App extends StatelessWidget  {
  final appState = AppState();
  @override
  Widget build(BuildContext context) {

    //listen to OS level life cycle changes
    SystemChannels.lifecycle.setMessageHandler(( msg){
      debugPrint('SystemChannels> $msg');
      if(msg==AppLifecycleState.resumed.toString()){
        appState.saveTime();
      }
      return;
    });


    return AppStateProvider<AppState>(
      appState: appState,
      child: MaterialPage(),
    );
  }
}

void  checkIsFirstTime()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(null==prefs.getInt('firstTime')){
    prefs.setInt('firstTime', DateTime.now().millisecondsSinceEpoch);
  }
}

class MaterialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = AppStateProvider.of<AppState>(context).currentTheme;

    checkIsFirstTime();
    return ValueBuilder<MyTheme>(
        streamed: theme,
        builder: (context, snapshot) {

          return MaterialApp(

              title: 'Animal Farm GCSE Revision App',
              theme: _buildThemeData(snapshot.data),
              home: MainPage(backgroundColor:Colors.deepOrange),
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/award': (context) => AwardPage(backgroundColor:Colors.indigoAccent),
            '/progress': (context) => ProgressPage(backgroundColor:Colors.white),
            '/awards': (context) => AwardsPage(backgroundColor:Colors.indigoAccent),
            '/trivia': (context) => TriviaPage(backgroundColor:Colors.amber),
            '/summary': (context) => SummaryPage(backgroundColor:Colors.amber),
            '/avatar': (context) => AvatarPage(backgroundColor:Colors.indigo),
            '/bio': (context) => BioPage(backgroundColor:Colors.indigo),
            '/messages': (context) => MessagesPage(backgroundColor:Colors.deepPurple),
          //  main,awards,messages, trivia, summary, stats, avatar,bio
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
      canvasColor: appTheme.canvasColor,

    );
  }
}
