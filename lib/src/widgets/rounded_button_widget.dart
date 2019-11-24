import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  const RoundedButtonWidget({this.buttonText, this.route});

  final String route;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints.tightForFinite(),
        height: 60,
        width: 150,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).buttonColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(35),
            ),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).primaryColor,
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
