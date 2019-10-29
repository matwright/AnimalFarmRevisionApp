import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../styles.dart';
import '../models/appstate.dart';
import '../models/models.dart';
import '../models/question.dart';
import '../widgets/answers_widget.dart';
import '../widgets/countdown_widget.dart';
import '../widgets/question_widget.dart';

class TriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = AppStateProvider.of<AppState>(context).triviaBloc;

    return ValueBuilder<TriviaState>(
        streamed: bloc.triviaState,
        builder: (context, snapshotTrivia) {
          return ValueBuilder<Question>(
              streamed: bloc.currentQuestion,
              builder: (context, snapshotQuestion) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.only(top: 22),
                  child: TriviaMain(
                      triviaState: snapshotTrivia.data,
                      question: snapshotQuestion.data),
                );
              });
        });
  }
}

class TriviaMain extends StatelessWidget {
  const TriviaMain({this.triviaState, this.question});

  final TriviaState triviaState;
  final Question question;

  @override
  Widget build(BuildContext context) {
    final bloc = AppStateProvider.of<AppState>(context).triviaBloc;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        Container(
          height: 12,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: QuestionWidget(
            bloc: bloc,
            question: question,
          ),
        ),
        Container(
          height: 32,
        ),
        Expanded(
          child: ValueBuilder<AnswerAnimation>(
              streamed: bloc.answersAnimation,
              builder: (context, snapshot) {
                return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: AnswersWidget(
                      bloc: bloc,
                      question: question,
                      answerAnimation: snapshot.data,
                      isTriviaEnd: triviaState.isTriviaEnd,
                    ));
              }),
        ),
        ValueBuilder<int>(
            streamed: bloc.currentTime,
            builder: (context, snapshot) {
              return Column(
                children: <Widget>[
                  Container(
                    height: 24,
                    padding: const EdgeInsets.all(22),
                    child: Text(
                      'Time left: ${((bloc.countdown - snapshot.data) / 1000)}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              );
            }),
        Container(
          height: 18,
        ),
        CountdownWidget(
          width: MediaQuery.of(context).size.width,
          duration: bloc.countdown,
          triviaState: triviaState,
        ),
      ],
    );
  }
}
