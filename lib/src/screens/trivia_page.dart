import 'package:animal_farm/src/widgets/bottomnav_widget.dart';
import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';

import '../models/appstate.dart';
import '../models/models.dart';
import '../models/question.dart';
import '../widgets/answers_widget.dart';
import '../widgets/countdown_widget.dart';
import '../widgets/question_widget.dart';

class TriviaPage extends StatelessWidget {
  TriviaPage({this.backgroundColor});

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);
    final bloc = AppStateProvider.of<AppState>(context).triviaBloc;
    var ended = false;

    bloc.triviaState.onChange((onDataChanged) {
      if (ended == false &&
          ModalRoute.of(context).settings.name == "/trivia" &&
          onDataChanged.isTriviaEnd == true) {
        print("send to summary  page");
        ended = true;
        Navigator.pushNamed(context, '/summary');
      }
    });

    if (ModalRoute.of(context).isCurrent) {
      print("loadQuestions trivia_page 19");

      appState.loadQuestions();
    }

    return ValueBuilder<TriviaState>(
        streamed: bloc.triviaState,
        builder: (context, snapshotTrivia) {
          return ValueBuilder<Question>(
              streamed: bloc.currentQuestion,
              builder: (context, snapshotQuestion) {
                return Scaffold(
                    bottomNavigationBar: BottomNavWidget(selectedIndex: 1),
                    appBar: AppBar(
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context, false),
                      ),
                      title: Text('Revision'),
                    ),
                    backgroundColor: backgroundColor,
                    // drawer: DrawerWidget(),
                    body: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        padding: const EdgeInsets.only(top: 22),
                        child: Column(
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
                                question: snapshotQuestion.data,
                              ),
                            ),
                            Container(
                              height: 32,
                            ),
                            Expanded(
                              child: ValueBuilder<TriviaState>(
                                  streamed: bloc.triviaState,
                                  builder: (context, snapshotTrivia) {
                                    return ValueBuilder<AnswerAnimation>(
                                        streamed: bloc.answersAnimation,
                                        builder: (context, snapshot) {
                                          return Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 22),
                                              child: AnswersWidget(
                                                bloc: bloc,
                                                question: snapshotQuestion.data,
                                                answerAnimation: snapshot.data,
                                                isTriviaEnd: snapshotTrivia
                                                    .data.isTriviaEnd,
                                              ));
                                        });
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
                              triviaState: snapshotTrivia.data,
                            ),
                          ],
                        )));
              });
        });
  }
}
