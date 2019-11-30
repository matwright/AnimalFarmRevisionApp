import 'package:animal_farm/src/models/character.dart';
import 'package:animal_farm/src/widgets/bottomnav_widget.dart';
import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';

import '../models/appstate.dart';

class AvatarPage extends StatelessWidget {

  AvatarPage({this.backgroundColor});
  final backgroundColor;

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);

    return ValueBuilder(
        streamed: appState.numMessages,
        builder: (context, snapshotNumMessages) {
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
                  child: Container(
                      child: ValueBuilder<List<Character>>(
                          streamed: appState.characterStream,
                          noDataChild: const CircularProgressIndicator(),
                          builder: (context, snapshot) {
                            var characters = snapshot.data;
                            return Column(

                                children: <Widget>[

                                  Padding(
                                    padding: EdgeInsets.only(top:10),
                                  ),
                              new Expanded(

                                  child: ListView(
                                addRepaintBoundaries: true,
                                children:
                                    List.generate(characters.length, (index) {
                            return GestureDetector(
                            onTap:()=> appState.characterBio(
                            characters[index],
                            context),
                            child:
                            Card(

                            color: (characters[index].color ??
                            Colors.blueGrey)
                            ,
                            margin: EdgeInsets.all( 10),
//   appState.chooseCharacter(characters[index].id);
                            shape: StadiumBorder(),
                            child: ListTile(
                            contentPadding: EdgeInsets.all(5),
                            leading: CircleAvatar(

                            backgroundColor:
                            (characters[index].color ??
                            Colors.blueGrey),
                            backgroundImage: AssetImage(
                            'assets/images/avatar/' +
                            characters[index].id +
                            '.png'),
                            ),
                            title: Text(characters[index].name,
                            style: TextStyle(color: (characters[index].textColor ??
                            Colors.white),fontFamily: "Raleway",fontWeight: FontWeight.bold,fontSize: 21),
                            ),
                            subtitle:
                            Text(characters[index].strapLine,style:
                            TextStyle(color: (characters[index].textColor ??
                            Colors.white),fontFamily: "Raleway",fontSize: 16)
                            ),
                            isThreeLine: false,
                            trailing: IconButton(
                            onPressed: () =>
                            appState.characterBio(
                            characters[index],
                            context),
                            icon: Icon(Icons.more_vert)
                            )
                            )
                            )
                            );



                                }
                                ),
                              ))
                            ]);
                          }))));
        });
  }
}
