import 'package:animal_farm/src/models/character.dart';

class Message {

  Message({this.id, this.text,this.image,this.createdBy,this.delay,this.rune});

  factory Message.fromJson(Map<String, dynamic> json) {

    return Message(
        id: json['id'],
        text: json['text'],
        rune: json['rune'],
        image: json['image'],
        createdBy: json['created_by'],
        delay: json['delay']);
  }

  int id;
  String text;
  String image;
  String createdBy;
  String delay;

  String rune;
}

