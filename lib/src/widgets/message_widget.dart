import 'dart:ui' as prefix0;

import 'package:animal_farm/src/models/appstate.dart';
import 'package:animal_farm/src/models/character.dart';
import 'package:animal_farm/src/widgets/empty_widget.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';

class MessageWidget extends StatefulWidget {
  final String avatar;
  final String name;
  final String time;
  final String img;
  final String text;
  final String rune;
 final Character character;
final AppState appState;

  MessageWidget({
    Key key,
    @required this.avatar,
    @required this.name,
    @required this.time,
    @required this.img,
    this.appState,
    this.character,
    this.text,
    this.rune
  }) : super(key: key);


  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<MessageWidget> {


  bool _isImageShown = false;
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    Size size = MediaQuery.of(context).size;
    Runes rune;
if(widget.rune!=null) {

  Map runes={
    'raised_fist':'\u{270A}',
    'cool':'\u{1f60e}',
    'pig_face':'\u{1f437}',
    'pig_nose':'\u{1f43d}',
    'paw_prints':'\u{1f43e}',
  }

  ;

  String runeValue=runes[widget.rune];

  rune= new Runes(runeValue);
}

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),


        child: Column(
          children: <Widget>[

            ListTile(
              isThreeLine: true,dense: false,


              trailing: InkWell(
onTap: ()=>widget.appState.characterBio(widget.character,context),
                child: CircleAvatar(

                  backgroundColor: widget.character.color,
                  backgroundImage: AssetImage(

                    "${widget.avatar}",
                  ),
                )
              ),

              contentPadding: EdgeInsets.only(bottom: 0),



              subtitle:widget.text!=null ?
              new Bubble(
                  margin: BubbleEdges.only(top: 10),
                  stick: false,
                  nip: BubbleNip.rightTop,
                  color: widget.character.color,
                  padding: BubbleEdges.all(10),

                  child:

                  Text(widget.text+' '+(rune!=null?(new String.fromCharCodes(rune)):""),style: TextStyle(color:widget.character.textColor)))
                  :Text('')
            ),


            (widget.img==null?Visibility(child: Divider(), visible: false,):
            new Flex(

              direction: Axis.vertical,
  children: <Widget>[

    !_isImageShown
        ? Center(

      child: GestureDetector(

        onTap: () => setState(() => _isImageShown = !_isImageShown),
        child:
        Stack(
            children: <Widget>[
        Opacity(
            opacity: 0.4,
          child:
          Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child:
              new Image.asset(

          widget.img,

          height: 170,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitWidth,
        ))
        ),
              Padding(padding: EdgeInsets.fromLTRB(0, 25, 10, 0),
              child:   Align(

    alignment: Alignment.topRight,
    child: Icon( Icons.photo_size_select_actual)))
           ]),
      ),
    )
        : SizedBox()

    ,
    _isImageShown
        ? Center(
        child: GestureDetector(
          onTap: () => setState(() => _isImageShown = !_isImageShown),
    child:
    Stack(
    children: <Widget>[

      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child:
      new Image.asset(
        widget.img,

        fit: BoxFit.cover,
      )
    ),
      Padding(padding: EdgeInsets.fromLTRB(0, 25, 10, 0),
          child:   Align(

              alignment: Alignment.topRight,
              child: Icon( Icons.photo_size_select_large)))
    ]
    )),
    )
        : SizedBox(),
  ],
))

    ,
      new Center(
        child:

        Chip(
          backgroundColor: Theme.of(context).primaryColor,

      label: Text('${widget.time}'),
    )

      )

          ],

        ),

    );
  }
}