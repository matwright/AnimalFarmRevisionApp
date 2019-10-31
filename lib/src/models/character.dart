class Character {
  Character({this.id, this.name,this.bio,this.strapLine});

  factory Character.fromObject(Map<String, dynamic> json) {
    return Character(id: json['id'], name: json['name'],bio:json['bio'],strapLine:json['strap_line']);
  }

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(id: json['id'], name: json['name'],bio:json['bio'],strapLine:json['strap_line']);
  }

  String id;
  String name;
  String bio;
  String strapLine;
}
