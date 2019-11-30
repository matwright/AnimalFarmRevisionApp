import 'dart:math';

import 'package:animal_farm/src/models/character.dart';
import 'package:animal_farm/src/models/location.dart';
import 'package:animal_farm/src/models/message.dart';
import 'package:animal_farm/src/widgets/bottomnav_widget.dart';
import 'package:animal_farm/src/widgets/message_widget.dart';
import 'package:animal_farm/src/widgets/wave_widget.dart';
import '../../util/data.dart';
import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';

import '../models/appstate.dart';

class MessagesPage extends StatelessWidget {

  MessagesPage({this.backgroundColor});

  final Color backgroundColor;
  static const DEFAULT_LOCATION = "The Barn";

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);
    appState.loadMessages();




    return Scaffold(
        bottomNavigationBar: BottomNavWidget(selectedIndex: 3),
        appBar:
            AppBar(   leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ), title: Text('Trotter Newsfeed')),
        backgroundColor: backgroundColor,
        body: FadeInWidget(
            duration: 20,
            child: Container(

                child: ValueBuilder<List<Message>>(
                    streamed: appState.messagesStream,
                    noDataChild: const CircularProgressIndicator(),
                    builder: (context, snapshot) {
                      onBottom(Widget child) => Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: child,
                        ),
                      );
                      return Scaffold(
                          backgroundColor: backgroundColor,

                          body:

                          Stack(
                              children: <Widget>[
                                Positioned.fill(child: AnimatedBackground(
                          color1: ColorTween(begin: Colors.black12.withOpacity(0.2), end: Colors.black12),
                          color2:ColorTween(begin: Colors.black26.withOpacity(0.2), end: Colors.black26),
                                )),
                      onBottom(AnimatedWave(
                      height: 200,
                      speed: 0.2,
                      offset: pi / 2,
                      )
                      )
                     ,
                                onBottom(AnimatedWave(
                                  height: 100,
                                  speed: 0.1,
                                  offset: pi / 2,
                                )
                                )
                                ,

                          ListView.separated(
                            padding: EdgeInsets.all(10),
                            separatorBuilder: (context, index) {
                              return Padding(padding: EdgeInsets.all(10));
                            },
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              Message message = snapshot.data[index];
                              Map character = characters.singleWhere(
                                  (character) =>
                                      character["id"] == message.createdBy,
                                  orElse: () => null);
                              Map location = locations.singleWhere(
                                      (location) =>
                                      location["id"] == message.location,
                                  orElse: () => null);
                              return MessageWidget(
                                  img: message.image != null
                                      ? 'assets/images/post/' + message.image
                                      : null,
                                  name: character['name'],
                                  character: Character.fromObject(character),

                                  text: message.text??'',
                                  rune: message.rune,
                                  avatar: 'assets/images/avatar/' +
                                      character['avatar'],
                                  location:Location.fromObject(location),
                                  appState: AppState());
                            },
                          )
                      ])
                      );
                    }))));
  }
}
