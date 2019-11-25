
import 'package:animal_farm/src/screens/avatar_page.dart';
import 'package:animal_farm/src/screens/bio_page.dart';
import 'package:animal_farm/src/screens/instructions_page.dart';
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
              home: MainPage(backgroundColor:Colors.lightBlue),
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/award': (context) => AwardPage(backgroundColor:(snapshot.data.name=='dark'?Colors.indigoAccent:Colors.indigoAccent)),
            '/progress': (context) => ProgressPage(backgroundColor:(snapshot.data.name=='dark'?Colors.white:Colors.white)),
            '/awards': (context) => AwardsPage(backgroundColor:(snapshot.data.name=='dark'?Colors.indigoAccent:Colors.indigoAccent)),
            '/trivia': (context) => TriviaPage(backgroundColor:(snapshot.data.name=='dark'?Colors.deepPurple:Colors.amber)),
            '/summary': (context) => SummaryPage(backgroundColor:(snapshot.data.name=='dark'?Colors.deepOrange:Colors.amber)),
            '/avatar': (context) => AvatarPage(backgroundColor:(snapshot.data.name=='dark'?Colors.indigo.shade900:Colors.indigo)),
            '/bio': (context) => BioPage(backgroundColor:(snapshot.data.name=='dark'?Colors.indigo.shade900:Colors.indigo)),
            '/messages': (context) => MessagesPage(backgroundColor:(snapshot.data.name=='dark'?Colors.blueGrey.shade900:Colors.blueGrey)),
            '/instructions': (context) => InstructionsPage(),


              //  main,awards,messages, trivia, summary, stats, avatar,bio
        });
        });
  }

  ThemeData _buildThemeData(MyTheme appTheme) {

    switch(appTheme.name){
      case('light'):
        return ThemeData.light();
      case('dark'):
        return ThemeData.dark();

    }
    return ThemeData.light();

  }
}
