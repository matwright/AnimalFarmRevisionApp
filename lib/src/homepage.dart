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
      case AppTab.summary:
        return Text('Summary');
        break;
      case AppTab.summary:
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



  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);

    return ValueBuilder(
      streamed: appState.tabController,
      builder: (context, snapshot) => Scaffold(
          appBar: AppBar(

            title: _switchTitle(snapshot.data, appState),
          ),

            drawer: DrawerWidget(),
            body: _switchTab(snapshot.data, appState),
        bottomNavigationBar:BottomNavigationBar(

          onTap: (int index) { appState.startScreen(index); },

          items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Quizz')

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            title: Text('Rewards'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text('Social'),
          ),

        ],)
          ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          const AboutListTile(
            child: Text('Made with Flutter'),
          ),
        ],
      ),
    );
  }
}
