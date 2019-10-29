class Character {
  Character({this.id, this.name,this.avatar});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(id: json['id'], name: json['name']);
  }

  int id;
  String name;
  String avatar;
}
