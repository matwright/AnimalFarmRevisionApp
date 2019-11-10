import 'dart:ui' as prefix0;

import 'package:animal_farm/src/models/character.dart';
import 'package:animal_farm/src/models/message.dart';
import 'package:animal_farm/src/widgets/bottomnav_widget.dart';
import 'package:animal_farm/src/widgets/message_widget.dart';

import 'package:animal_farm/util/data.dart';
import 'package:clock/clock.dart';
import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../models/appstate.dart';
import '../models/category.dart';
import  'package:avatar_glow/avatar_glow.dart';

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);
    appState.loadMessages();

    return ValueBuilder(
        streamed: appState.numMessages,
        builder: (context, snapshotNumMessages) {
      return Scaffold(
          bottomNavigationBar:BottomNavWidget(selectedIndex:3),
          appBar: AppBar(

          leading:  Icon(Icons.chat)

    ,
    title: Text('Trotter Newsfeed'))
    ,


    // drawer: DrawerWidget(),
    body: FadeInWidget(

      duration: 100,
      child: Container(

          margin: const EdgeInsets.symmetric(vertical: 20.0),
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: ValueBuilder<List<Message>>(
              streamed: appState.messagesStream,
          noDataChild: const CircularProgressIndicator(),

          builder: (context, snapshot) {

            return Scaffold(


              body: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 0),
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Message message = snapshot.data[index];
                  Map character=characters.singleWhere((character) => character["id"] == message.createdBy, orElse: () => null);
                  return MessageWidget(
                    img: message.image!=null?'assets/images/post/'+message.image:null,
                    name:character['name'],
                    character:Character.fromObject(character),
                    text:message.text,
                    rune:message.rune,
                    avatar: 'assets/images/avatar/'+character['avatar'],
                    time: (index+2).toString()+' mins ago',
                    appState:AppState()
                  );
                },
              )
            );

    })

    )
    ));});
    }

}
