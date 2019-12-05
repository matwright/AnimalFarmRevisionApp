import 'package:animal_farm/src/models/appstate.dart';
import 'package:animal_farm/src/models/character.dart';
import 'package:animal_farm/src/models/location.dart';
import 'package:animal_farm/src/widgets/avatar_dialog_widget.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:frideos/frideos.dart';

class MessageWidget extends StatefulWidget {
  final String avatar;
  final String name;
  final Location location;
  final String img;
  final String text;
  final String rune;
  final Character character;
  final AppState appState;

  MessageWidget(
      {Key key,
      @required this.avatar,
      @required this.name,
      @required this.location,
      @required this.img,
      this.appState,
      this.character,
      this.text,
      this.rune})
      : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<MessageWidget> {
  bool _isImageShown = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Runes rune;
    if (widget.rune != null) {
//http://www.unicode.org/emoji/charts/full-emoji-list.html
      Map runes = {
        'raised_fist': '\u{270A}',
        'cool': '\u{1f60e}',
        'pig_face': '\u{1f437}',
        'pig_nose': '\u{1f43d}',
        'paw_prints': '\u{1f43e}',
        'pile_of_poo': '\u{1F4A9}',
        'zzz': '\u{1F4A4}',
        'eyes': '\u{1F440}',
        'beer_mug': '\u{1F37A}',
        'pink_ribbon': '\u{1F380}'
      };

      String runeValue = runes[widget.rune];

      rune = new Runes(runeValue);
    }

    final appState = AppStateProvider.of<AppState>(context);

    return Container(
        child: Column(children: <Widget>[
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        InkWell(
            onTap: () =>
                widget.appState.characterBio(widget.character, context),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: widget.character.color,
              backgroundImage: AssetImage(
                "${widget.avatar}",
              ),
            )),
        Expanded(
            child: Column(children: <Widget>[
          Bubble(
              margin: BubbleEdges.fromLTRB(5, 30, 0, 0),
              color: widget.character.color,
              stick: false,
              shadowColor: Colors.black,
              nip: BubbleNip.leftTop,
              nipWidth: 10,
              child: Column(children: <Widget>[
                ListTile(
                    isThreeLine: false,
                    dense: true,
                    contentPadding: EdgeInsets.only(bottom: 0),
                    subtitle: widget.text != null
                        ? new Container(
                            child: Text(
                                widget.text +
                                    ' ' +
                                    (rune != null
                                        ? (new String.fromCharCodes(rune))
                                        : ""),
                                style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: (size.width > 600 ? 40 : 20),
                                    color: widget.character.textColor)))
                        : Container()),
                (widget.img == null
                    ? Visibility(
                        child: Divider(),
                        visible: false,
                      )
                    : new Flex(
                        direction: Axis.vertical,
                        children: <Widget>[
                          !_isImageShown
                              ? Center(
                                  child: GestureDetector(
                                    onTap: () => setState(
                                        () => _isImageShown = !_isImageShown),
                                    child: Stack(children: <Widget>[
                                      Opacity(
                                          opacity: 0.4,
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 20, 0, 0),
                                              child: new Image.asset(
                                                widget.img,
                                                height: 100,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                fit: BoxFit.fitWidth,
                                              ))),
                                      Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 25, 10, 0),
                                          child: Align(
                                              alignment: Alignment.topRight,
                                              child: Icon(Icons
                                                  .photo_size_select_actual)))
                                    ]),
                                  ),
                                )
                              : SizedBox(),
                          _isImageShown
                              ? Center(
                                  child: GestureDetector(
                                      onTap: () => setState(
                                          () => _isImageShown = !_isImageShown),
                                      child: Stack(children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 20, 0, 0),
                                            child: new Image.asset(
                                              widget.img,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              fit: BoxFit.cover,
                                            )),
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 25, 10, 0),
                                            child: Align(
                                                alignment: Alignment.topRight,
                                                child: Icon(Icons
                                                    .photo_size_select_large)))
                                      ])),
                                )
                              : SizedBox(),
                        ],
                      ))
              ])),
          Container(
              margin: EdgeInsets.only(top: 20),
              child: Wrap(spacing: 5.0, // gap between adjacent chips,

                  children: <Widget>[
                    Chip(
                      backgroundColor: Colors.indigo,
                      label: Text(widget.text.length.toString(),
                          style: TextStyle(
                            color: Colors.white70,
                            fontFamily: "Raleway",
                            fontSize: 14,
                          )),
                      avatar:
                          Icon(Icons.insert_emoticon, color: Colors.white70),
                    ),
                    GestureDetector(
                        onTap: () =>
                            appState.characterBio(widget.character, context),
                        child: Chip(
                          backgroundColor: Colors.pink,
                          label: Text(widget.character.name,
                              style: TextStyle(
                                color: Colors.white70,
                                fontFamily: "Raleway",
                                fontSize: 14,
                              )),
                          avatar:
                              Icon(Icons.account_circle, color: Colors.white70),
                        )),
                    GestureDetector(
                        onTap: () => showDialog(
                              context: context,
                              builder: (BuildContext context) => CustomDialog(
                                  title: widget.location.name,
                                  description: widget.location.strapLine,
                                  buttonText: "Oink",
                                  image: widget.location.image),
                            ),
                        child: Chip(
                          backgroundColor: Colors.green,
                          label: Text(widget.location.name,
                              style: TextStyle(
                                color: Colors.white70,
                                fontFamily: "Raleway",
                                fontSize: 14,
                              )),
                          avatar:
                              Icon(Icons.location_on, color: Colors.white70),
                        ))
                  ]))
        ])),
      ]),
    ]));
  }
}
