import 'dart:ui';

class Character {
  Character({this.id, this.name,this.bio,this.strapLine,this.color});

  factory Character.fromObject(Map<String, dynamic> json) {
    return Character(id: json['id'], name: json['name'],bio:json['bio'],strapLine:json['strap_line'],color:json['color']);
  }

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(id: json['id'], name: json['name'],bio:json['bio'],strapLine:json['strap_line'],color:json['color']);
  }

  String id;
  String name;
  String bio;
  String strapLine;
  Color color;
}
