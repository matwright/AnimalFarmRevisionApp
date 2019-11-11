import 'package:animal_farm/src/models/appstate.dart';
import 'package:animal_farm/src/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';

class BottomNavWidget extends StatefulWidget {



  const  BottomNavWidget(
      {Key key,this.selectedIndex})
      : super(key: key);
  final int selectedIndex;
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNavWidget> {

  int _selectedIndex = 0;

  @override
  void initState() {

    print( widget.selectedIndex.toString());
    super.initState();
    if(widget.selectedIndex!=null){
      _selectedIndex = widget.selectedIndex;
    }

  }

  void _onItemTapped(int index) {
    setState(() {

      switch(index){
        case(0):
        Navigator.pushNamed(context, "/");
        break;
        case(1):
          Navigator.pushNamed(context, "/trivia");
          break;
        case(2):
          Navigator.pushNamed(context, "/rewards");
          break;

        case(3):

          Navigator.pushNamed(context, "/messages");
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {


AppState appState=AppStateProvider.of(context);
return ValueBuilder(
    streamed: appState.messagesUnseenStream,
    builder: (context, snapshotUnseenMessages) {
return ValueBuilder(
    streamed: appState.rewardsUnseenStream,
    builder: (context, snapshotUnseenRewards) {
    return BottomNavigationBar(

        backgroundColor: Theme.of(context).bottomAppBarColor,
        currentIndex: widget.selectedIndex,
selectedItemColor:Colors.blue[200],

        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('Home')),

          BottomNavigationBarItem(
              icon: Icon(Icons.school), title: Text('Quizz')),
          BottomNavigationBarItem(
              title: Text('Awards'),
              icon: new Stack(children: <Widget>[
                new Icon(Icons.card_giftcard),

                new Positioned(
                    // draw a red marble
                    top: 0.0,
                    right: -0.0,
                    child:  (snapshotUnseenRewards.data>0? new Container(
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
                        snapshotUnseenRewards.data.toString(),
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ):new Container()))
              ])),
          BottomNavigationBarItem(
              title: Text('Social'),
              icon: new Stack(children: <Widget>[
                new Icon(Icons.message),
                new Positioned(
                  // draw a red marble
                  top: 0.0,
                  right: -0.0,
                  child: (snapshotUnseenMessages.data>0?new Container(
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
                      snapshotUnseenMessages.data.toString(),
                      //snapshotNumMessages.data.toString(),
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ):new Container()),
                )
              ])),
        ]);});});
  }
}