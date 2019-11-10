class Reward {
  Reward({this.id, this.name,this.image,this.strapLine});


  factory Reward.fromObject(Map<String, dynamic> object) {
    return Reward(id: object['id'], name: object['name'],image:object['image'],strapLine:object['strap_line']); }

  String id;
  String name;
  String image;
  String strapLine;
}
