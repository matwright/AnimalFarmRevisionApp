import 'dart:ui' as prefix0;

import 'package:animal_farm/src/models/character.dart';
import 'package:animal_farm/src/models/award.dart';
import 'package:animal_farm/src/widgets/bottomnav_widget.dart';
import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../models/appstate.dart';
import '../models/category.dart';
import  'package:avatar_glow/avatar_glow.dart';
class AwardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);

    appState.loadAwards();

      return Scaffold(
          bottomNavigationBar:BottomNavWidget(selectedIndex: 2),
          appBar: AppBar(

          leading: IconButton(icon: Icon(Icons.arrow_back),
    onPressed: () => Navigator.pop(context, false),
    ),
    title: Text('Awards'),
    ),


    // drawer: DrawerWidget(),
    body: FadeInWidget(

      duration: 20,
      child: Container(

          margin: const EdgeInsets.symmetric(vertical: 20.0),
        padding: const EdgeInsets.symmetric(horizontal: 36.0),
        child: ValueBuilder<List<Award>>(
          streamed: appState.awardsStream,
          noDataChild: const CircularProgressIndicator(),

          builder: (context, snapshot) {

return  GridView.count(
  // Create a grid with 2 columns. If you change the scrollDirection to
  // horizontal, this produces 2 rows.
  crossAxisCount: 3,
  // Generate 100 widgets that display their index in the List.
  children:  List.generate(15, (index)
  {
    Award award;
    if(index<snapshot.data.length){
       award=snapshot.data[index];

    }

    return Container(
        margin: const EdgeInsets.all(10.0),

        child:
            GestureDetector(
              onTap:  () {if(award!=null){appState.awardInfo(award,context);}},
              child:
        AvatarGlow(
          startDelay: Duration(milliseconds: 1000),
          glowColor: Colors.white,
          endRadius: 100.0,
          duration: Duration(milliseconds: 2000),
          repeat: true,
          showTwoGlows: true,
          repeatPauseDuration: Duration(milliseconds: 100),
          child: Material(

            elevation: 8.0,
            shape: CircleBorder(),
            color: Colors.black26,
            child: CircleAvatar(

              backgroundColor: Colors.black26,
              backgroundImage: (award!=null?AssetImage('assets/images/badge/'+award.image):null),
              radius: 80.0,

            ),
          ),
        )));
  }),

);

    })

    )
    )
      );
    }

}
