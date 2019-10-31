import 'dart:ui' as prefix0;

import 'package:animal_farm/src/models/message.dart';
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

    return FadeInWidget(

      duration: 750,
      child: Container(

          margin: const EdgeInsets.symmetric(vertical: 20.0),
        padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: ValueBuilder<List<Message>>(
              streamed: appState.messagesStream,
          noDataChild: const CircularProgressIndicator(),

          builder: (context, snapshot) {
            return Scaffold(


              body: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Message message = snapshot.data[index];
                  Map character=characters.singleWhere((character) => character["id"] == message.createdBy, orElse: () => null);
                  return MessageWidget(
                    img: 'assets/images/post/'+message.image,
                    name:character['name'],
                    text:message.text,
                    avatar: 'assets/images/avatar/'+character['avatar'],
                    time: message.delay+' mins agos',
                  );
                },
              )
            );

    })

    )
    );
    }

}
