
class Location {
  Location(
      {this.id,
      this.name,
      this.strapLine,
      this.image});

  factory Location.fromObject(Map<String, dynamic> json) {
    return Location(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        strapLine: json['strap_line'],
  );
  }



  String id;
  String name;
  String image;
  String strapLine;
}
