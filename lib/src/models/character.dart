import 'dart:ui';

class Character {
  Character(
      {this.id,
      this.name,
      this.bio,
      this.strapLine,
      this.color,
      this.textColor});

  factory Character.fromObject(Map<String, dynamic> json) {
    return Character(
        id: json['id'],
        name: json['name'],
        bio: json['bio'],
        strapLine: json['strap_line'],
        color: json['color'],
        textColor: json['text_color']);
  }

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
        id: json['id'],
        name: json['name'],
        bio: json['bio'],
        strapLine: json['strap_line'],
        color: json['color'],
        textColor: json['text_color']);
  }

  String id;
  String name;
  String bio;
  String strapLine;
  Color color;
  Color textColor;
}
