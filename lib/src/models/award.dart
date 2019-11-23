import 'package:animal_farm/util/data.dart';

class Award {
  Award({this.id, this.name, this.image, this.achievement, this.description});

  factory Award.fromObject(Map<String, dynamic> object) {
    return Award(
        id: object['id'],
        name: object['name'],
        image: object['image'],
        achievement: object['achievement'],
        description: object['description']);
  }

  awardTrigger id;
  String name;
  String description;
  String achievement;
  String image;
}
