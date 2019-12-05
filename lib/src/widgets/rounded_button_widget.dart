import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  const RoundedButtonWidget(
      {this.buttonText, this.route, this.width, this.height});

  final String route;
  final String buttonText;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints.tightForFinite(),
        height: height,
        width: width,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).buttonColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(35),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.brown.shade900,
                  blurRadius: 10.0,
                  spreadRadius: 2),
            ]),
        child: Text(
          buttonText,
          style: TextStyle(
            fontFamily: "Raleway",
            fontWeight: FontWeight.w700,
            fontSize: 20.0,
          ),
        ),
      ),
      onTap: () => Navigator.pushNamed(context, "/" + route),
    );
  }
}
