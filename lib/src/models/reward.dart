class Reward {
  Reward({this.id, this.name,this.image,this.achievement,this.description});


  factory Reward.fromObject(Map<String, dynamic> object) {
    return Reward(id: object['id'], name: object['name'],image:object['image'],achievement:object['achievement'],description:object['description']); }

  String id;
  String name;
  String description;
  String achievement;
  String image;
}
