import 'package:flutter/material.dart';

class MessageWidget extends StatefulWidget {
  final String avatar;
  final String name;
  final String time;
  final String img;
  final String text;



  MessageWidget({
    Key key,
    @required this.avatar,
    @required this.name,
    @required this.time,
    @required this.img,
    this.text
  }) : super(key: key);
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<MessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),

      child: InkWell(

        child: Column(
          children: <Widget>[
            ListTile(
              isThreeLine: true,dense: true,
                trailing: Text(

                  "${widget.time}",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 11,
                  ),
                ),
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                  "${widget.avatar}",
                ),
              ),

              contentPadding: EdgeInsets.all(0),
              title: Text(
                "${widget.name}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),



              subtitle:widget.text!=null ? Text(widget.text):Text('')
            ),


            Image.asset(
              "${widget.img}",
              height: 170,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),

          ],
        ),
        onTap: (){},
      ),
    );
  }
}