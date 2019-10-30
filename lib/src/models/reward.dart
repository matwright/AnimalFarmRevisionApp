class Reward {
  Reward({this.id, this.name,this.image,this.strapLine});

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(id: json['id'], name: json['name'],image:json['image'],strapLine:json['strap_line']);
  }

  String id;
  String name;
  String image;
  String strapLine;
}
