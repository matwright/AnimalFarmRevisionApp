import 'dart:async';

import 'package:animal_farm/src/models/trivia_stats.dart';
import 'package:frideos_core/frideos_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';
import '../models/question.dart';

const refreshTime = 100;

class TriviaBloc {
  TriviaBloc({this.countdownStream, this.questions, this.tabController}) {
    stats.value = TriviaStats();

    // Getting the questions from the API
    questions.onChange((data) {
      if (data.isNotEmpty) {
        index = 0;
        data.shuffle();
        final questions = data;
        print("_startTrivia 22 trivia bloc");
        _startTrivia(questions);
      }
    });

    countdownStream.outTransformed.listen((data) {
      countdown = int.parse(data) * 1000;
    });
  }

  // STREAMS
  final StreamedValue<AppTab> tabController;
  final triviaState = StreamedValue<TriviaState>(initialData: TriviaState());
  final StreamedList<Question> questions;
  final currentQuestion = StreamedValue<Question>();
  final currentTime = StreamedValue<int>(initialData: 0);
  final countdownBar = StreamedValue<double>();
  final answersAnimation = StreamedValue<AnswerAnimation>(
      initialData: AnswerAnimation(chosenAnswerIndex: 0, startPlaying: false));

  // QUESTIONS, ANSWERS, stats.value
  int index = 0;
  String chosenAnswer;

  final stats = StreamedValue<TriviaStats>();

  // TIMER, COUNTDOWN
  final StreamedTransformed<String, String> countdownStream;
  int countdown; // Milliseconds
  Timer timer;

  void _startTrivia(List<Question> data) {
    index = 0;
    triviaState.value.questionIndex = 1;

    // To show the main page and summary buttons
    triviaState.value.isTriviaEnd = false;

    // Reset the stats.value
    stats.value.reset();

    // To set the initial question (in this case the countdown
    // bar animation won't start).
    currentQuestion.value = data.first;

    Timer(Duration(milliseconds: 1000), () {
      // Setting this flag to true on changing the question
      // the countdown bar animation starts.
      triviaState.value.isTriviaPlaying = true;

      // Stream the first question again with the countdown bar
      // animation.
      currentQuestion.value = data[index];

      playTrivia();
    });
  }

  void playTrivia() {
    timer = Timer.periodic(Duration(milliseconds: refreshTime), (Timer t) {
      currentTime.value = refreshTime * t.tick;

      if (currentTime.value > countdown) {
        currentTime.value = 0;
        timer.cancel();
        notAnswered(currentQuestion.value);
        _nextQuestion();
      }
    });
  }

  void _endTrivia() async {
    print("endTrivia");

    // RESET
    timer.cancel();
    currentTime.value = 0;
    triviaState.value.isTriviaEnd = true;
    triviaState.refresh();
    stopTimer();
    // this is reset here to not trigger the start of the
    // countdown animation while waiting for the summary page.
    triviaState.value.isAnswerChosen = false;
    // Show the summary page after 1.5s

    // Clear the last question so that it doesn't appear
    // in the next game
    currentQuestion.value = null;
    triviaState.value.isTriviaEnd = true;
    //set total correct answers in the prefs
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentCorrectAnswers = prefs.getInt('correctAnwers') ?? 0;
    prefs.setInt('currentCorrectAnswers',
        currentCorrectAnswers + stats.value.corrects.length);
    Timer(Duration(milliseconds: 1), () {});
  }

  void notAnswered(Question question) {
    stats.value.addNoAnswer(question);
  }

  void checkAnswer(Question question, String answer) {
    if (!triviaState.value.isTriviaEnd) {
      question.chosenAnswerIndex = question.answers.indexOf(answer);
      if (question.isCorrect(answer)) {
        stats.value.addCorrect(question);
      } else {
        stats.value.addWrong(question);
      }

      timer.cancel();
      currentTime.value = 0;

      _nextQuestion();
    }
  }

  void _nextQuestion() {
    index++;

    if (index < questions.length) {
      triviaState.value.questionIndex++;
      currentQuestion.value = questions.value[index];
      playTrivia();
    } else {
      _endTrivia();
    }
  }

  void stopTimer() {
    // Stop the timer
    timer.cancel();
    // By setting this flag to true the countdown animation will stop
    triviaState.value.isAnswerChosen = true;
    triviaState.refresh();
  }

  void onChosenAnswer(String answer) {
    chosenAnswer = answer;

    stopTimer();

    // Set the chosenAnswer so that the answer widget can put it last on the
    // stack.
    answersAnimation.value.chosenAnswerIndex =
        currentQuestion.value.answers.indexOf(answer);
    answersAnimation.refresh();
  }

  void onChosenAnwserAnimationEnd() {
    // Reset the flag so that the countdown animation can start
    triviaState.value.isAnswerChosen = false;
    triviaState.refresh();

    checkAnswer(currentQuestion.value, chosenAnswer);
  }

  void dispose() {
    answersAnimation.dispose();
    countdownBar.dispose();
    countdownStream.dispose();
    currentQuestion.dispose();
    currentTime.dispose();
    questions.dispose();
    stats.dispose();
    tabController.dispose();
    triviaState.dispose();
  }
}
