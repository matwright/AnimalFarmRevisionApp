import 'package:animal_farm/src/screens/messages_page.dart';
import 'package:animal_farm/src/screens/rewards_page.dart';
import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import 'models/appstate.dart';
import 'models/models.dart';
import 'screens/main_page.dart';
import 'screens/settings_page.dart';
import 'screens/summary_page.dart';
import 'screens/trivia_page.dart';


/// Styles
const textStyle = TextStyle(color: Colors.blueGrey);
const iconColor = Colors.green;

class HomePage extends StatelessWidget {


  Text _switchTitle(AppTab tab, AppState appState) {
    switch (tab) {
      case AppTab.main:
        return Text('Home');
        break;
      case AppTab.rewards:
        return Text('Your Awards');
        break;
      case AppTab.trivia:
        return Text('Revision');
        break;

      case AppTab.messages:
        return Text('Trotter');
        break;
      default:
        return Text('Home');
    }
  }


  Widget _switchTab(AppTab tab, AppState appState) {
    switch (tab) {
      case AppTab.main:
        return MainPage();
        break;
      case AppTab.rewards:
        return RewardsPage();
        break;
      case AppTab.messages:
        return MessagesPage();
        break;
      case AppTab.trivia:
        return TriviaPage();
        break;
      case AppTab.summary:
        return SummaryPage(stats: appState.triviaBloc.stats);
        break;
      default:
        return MainPage();
    }
  }


  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);




    return ValueBuilder(
      streamed: appState.tabController,
        builder: (context, snapshotTabs) {
      return ValueBuilder(
          streamed: appState.numMessages,
          builder: (context, snapshotNumMessages) {

        return Scaffold(
          appBar: AppBar(

            title: _switchTitle(snapshotTabs.data, appState),
          ),

            drawer: DrawerWidget(),
            body: _switchTab(snapshotTabs.data, appState),
        bottomNavigationBar:BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (int index) {

            appState.startScreen(index);
            //set tapped item to active
            selectedIndex = index;
          },

          items:  <BottomNavigationBarItem>[

          BottomNavigationBarItem(

            icon: Icon(Icons.school),
            title: Text('Quizz')
          ),
          BottomNavigationBarItem(
              title: Text('Awards'),
              icon: new Stack(
                  children: <Widget>[
                    new Icon(Icons.card_giftcard),
                    new Positioned(  // draw a red marble
                      top: 0.0,
                      right: -0.0,

                      child: new Container(
                        padding: EdgeInsets.all(1),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 10,
                          minHeight: 10,
                        ),
                        child: new Text(
                          "1",
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        )
                    )

                  ]
              )

          ),

          BottomNavigationBarItem(
              title: Text('Social')
              ,

              icon: new Stack(
                  children: <Widget>[
                    new Icon(Icons.message),
                    new Positioned(  // draw a red marble
                      top: 0.0,
                      right: -0.0,
                      child: new Container(
                        padding: EdgeInsets.all(1),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 10,
                          minHeight: 10,
                        ),
                        child: new Text(
                          snapshotNumMessages.data.toString(),
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )

                  ]
              )

          ),

        ])
          );});});

  }
}

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);

    int elapsed=appState.getStopwatch();

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
            child:  Text(elapsed.toString()+" minutes"),
          ),
        ],
      ),
    );
  }
}
