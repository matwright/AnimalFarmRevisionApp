import 'package:flutter/material.dart';

import '../blocs/trivia_bloc.dart';
import '../models/question.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({this.bloc, this.question});

  final Question question;
  final TriviaBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      alignment: Alignment.center,
      height: 21 * 5.0,
      child: Text(
        '${bloc.triviaState.value.questionIndex} - ${question.question}',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 21.0,
          fontFamily: "Raleway",
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
