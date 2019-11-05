import 'dart:ui' as prefix0;

import 'package:animal_farm/src/models/character.dart';
import 'package:animal_farm/src/models/reward.dart';
import 'package:animal_farm/src/widgets/bottomnav_widget.dart';
import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../models/appstate.dart';
import '../models/category.dart';
import  'package:avatar_glow/avatar_glow.dart';
class AvatarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);



    Character characterSelected;


    return ValueBuilder(
        streamed: appState.numMessages,
        builder: (context, snapshotNumMessages) {
      return Scaffold(
          bottomNavigationBar:BottomNavWidget(selectedIndex: 0),
          appBar: AppBar(

            leading: IconButton(icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
            title: Text('Choose Your Character'),
          ),


          // drawer: DrawerWidget(),
          body:
     FadeInWidget(

      duration: 750,

      child: Container(


        child: ValueBuilder<List<Character>>(
          streamed: appState.characterStream,
          noDataChild: const CircularProgressIndicator(),

          builder: (context, snapshot) {

            var characters=snapshot.data;
            return Column(

              children: <Widget>[
             Container(
                 margin: const EdgeInsets.symmetric(vertical: 20.0),

child:
                new Text("Choose your Character",
              style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'Raleway' ,
              color: Colors.white,
              letterSpacing: 4.0,
              height: 1,
              shadows: [

              ],
            ),
                )),

            new Expanded (
            child:


            ListView(
addRepaintBoundaries: true,

  children:  List.generate(characters.length, (index)
  {

return Card(
margin: EdgeInsets.only(bottom:20),
//   appState.chooseCharacter(characters[index].id);
         shape: StadiumBorder(),

         child:
         ListTile(
           leading:
           CircleAvatar(

             backgroundColor: (characters[index].color??Colors.blueGrey),
             backgroundImage: AssetImage('assets/images/avatar/'+characters[index].id+'.png'),


           ),

           title: Text(characters[index].name),

           subtitle:

               Text(
                   characters[index].strapLine
               )

            ,

           isThreeLine: false,
           trailing:

         IconButton(
                 onPressed:  () =>appState.characterBio(characters[index],context),
                 icon:Icon(Icons.more_vert)
             )

         )


     );

  }
  ),

  )
)]);
    })

    )
    )
      );});
    }

}
