import 'package:animal_farm/src/models/character.dart';
import 'package:animal_farm/src/models/message.dart';
import 'package:animal_farm/src/widgets/bottomnav_widget.dart';
import 'package:animal_farm/src/widgets/message_widget.dart';
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
            AppBar(leading: Icon(Icons.chat), title: Text('Trotter Newsfeed')),
        backgroundColor: backgroundColor,
        body: FadeInWidget(
            duration: 20,
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ValueBuilder<List<Message>>(
                    streamed: appState.messagesStream,
                    noDataChild: const CircularProgressIndicator(),
                    builder: (context, snapshot) {
                      return Scaffold(
                          backgroundColor: backgroundColor,
                          body: ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: 0),
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
                                  location:
                                      message.location ?? DEFAULT_LOCATION,
                                  appState: AppState());
                            },
                          ));
                    }))));
  }
}
