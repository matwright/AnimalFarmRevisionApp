class Message {
  Message(
      {this.id,
      this.text,
      this.image,
      this.createdBy,
      this.location,
      this.rune});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      text: json['text'],
      rune: json['rune'],
      location: json['location'],
      image: json['image'],
      createdBy: json['created_by'],
    );
  }

  int id;
  String text;
  String image;
  String createdBy;
  String location;
  String rune;
}
