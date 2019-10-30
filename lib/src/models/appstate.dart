import 'dart:async';

import 'package:animal_farm/src/models/character.dart';
import 'package:animal_farm/src/models/message.dart';
import 'package:animal_farm/src/models/reward.dart';
import 'package:flutter/material.dart';

import 'package:frideos_core/frideos_core.dart';

import 'package:frideos/frideos.dart';

import '../API/api_interface.dart';
import '../API/mock_api.dart';
import '../API/trivia_api.dart';
import '../blocs/trivia_bloc.dart';
import '../models/category.dart';
import '../models/models.dart';
import '../models/question.dart';
import '../models/theme.dart';
import 'package:clock/clock.dart';
class AppState extends AppStateModel {


  factory AppState() => _singletonAppState;


  var stopwatch = clock.stopwatch()..start();

  AppState._internal() {
    print('-------APP STATE INIT--------');
    _createThemes(themes);

    countdown.value = 10.toString();
    countdown.setTransformer(validateCountdown);

    questionsAmount.value = 5.toString();
    questionsAmount.setTransformer(validateAmount);

    triviaBloc = TriviaBloc(
        countdownStream: countdown,
        questions: questions,
        tabController: tabController);
  }

  static final AppState _singletonAppState = AppState._internal();
  //TIMER




  // THEMES
  final themes = List<MyTheme>();
  final currentTheme = StreamedValue<MyTheme>();

  // API
  AppAPI api = MockAPI();
  final apiType = StreamedValue<ApiType>(initialData: ApiType.mock);
 //SOCIAL
  final messagesStream = StreamedList<Message>();
  final characterStream = StreamedList<Character>();
  //Rewards
  final rewardsStream = StreamedList<Reward>();

  // TABS
  final tabController = StreamedValue<AppTab>(initialData: AppTab.main);

  // TRIVIA
  final categoryChosen = StreamedValue<Category>();
  final questions = StreamedList<Question>();
  final questionsDifficulty =
      StreamedValue<QuestionDifficulty>(initialData: QuestionDifficulty.medium);

  final questionsAmount = StreamedTransformed<String, String>();

  final validateAmount =
      StreamTransformer<String, String>.fromHandlers(handleData: (str, sink) {
    if (str.isNotEmpty) {
      final amount = int.tryParse(str);
      if (amount > 1 && amount <= 15) {
        sink.add(str);
      } else {
        sink.addError('Insert a value from 2 to 15..');
      }
    } else {
      sink.addError('Insert a value.');
    }
  });

  // BLOC
  TriviaBloc triviaBloc;

  // COUNTDOWN
  final countdown = StreamedTransformed<String, String>();

  final validateCountdown =
      StreamTransformer<String, String>.fromHandlers(handleData: (str, sink) {
    if (str.isNotEmpty) {
      final time = int.tryParse(str);
      if (time >= 3 && time <= 90) {
        sink.add(str);
      } else {
        sink.addError('Insert a value from 3 to 90 seconds.');
      }
    } else {
      sink.addError('Insert a value.');
    }
  });




  @override
  Future<void> init() async {
    final String lastTheme = await Prefs.getPref('apptheme');
    if (lastTheme != null) {
      currentTheme.value = themes.firstWhere((theme) => theme.name == lastTheme,
          orElse: () => themes[0]);
    } else {
      currentTheme.value = themes[0];
    }
  }


 int getStopwatch() => stopwatch.elapsed.inMinutes;



  Future _loadCharacters() async {

    await api.getCharacters(characterStream);

  }



  Future _loadMessages() async {

   await api.getMessages(messagesStream);

  }


  Future _loadQuestions() async {
    await api.getQuestions(
        questions: questions,
        number: int.parse(questionsAmount.value),
        category: categoryChosen.value,
        difficulty: questionsDifficulty.value,
        type: QuestionType.multiple);
  }

  void setCategory(Category category) => categoryChosen.value = category;

  void setDifficulty(QuestionDifficulty difficulty) =>
      questionsDifficulty.value = difficulty;

  void setApiType(ApiType type) {
    if (apiType.value != type) {
      apiType.value = type;
      if (type == ApiType.mock) {
        api = MockAPI();
      } else {
        api = TriviaAPI();
      }


    }
  }

  void _createThemes(List<MyTheme> themes) {
    themes.addAll([
      MyTheme(
        name: 'Default',
        brightness: Brightness.dark,
        backgroundColor: const Color(0xff111740),
        scaffoldBackgroundColor: const Color(0xff111740),
        primaryColor: const Color(0xff283593),
        primaryColorBrightness: Brightness.dark,
        accentColor: Colors.blue[300],
      ),
      MyTheme(
        name: 'Dark',
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.blueGrey[900],
        primaryColorBrightness: Brightness.dark,
        accentColor: Colors.blue[900],
      ),
    ]);
  }

  void setTheme(MyTheme theme) {
    currentTheme.value = theme;
    Prefs.savePref<String>('apptheme', theme.name);
  }

  set _changeTab(AppTab appTab) => tabController.value = appTab;

  void startTrivia() {
    _loadQuestions();
    _changeTab = AppTab.trivia;
  }

  void startScreen(int index){
    switch (index) {
      case 0:
        _changeTab = AppTab.main;
        break;
      case 1:
        _changeTab = AppTab.rewards;
        break;
      case 2:
        _loadCharacters();
        _loadMessages();
        _changeTab = AppTab.messages;
        break;

      default:
        startTrivia();
    }


  }



  void endTrivia() => tabController.value = AppTab.main;

  void showSummary() => tabController.value = AppTab.summary;

  @override
  void dispose() {
    print('---------APP STATE DISPOSE-----------');
    apiType.dispose();
    categoryChosen.dispose();
    countdown.dispose();
    currentTheme.dispose();
    questions.dispose();
    questionsAmount.dispose();
    questionsDifficulty.dispose();
    tabController.dispose();
    triviaBloc.dispose();
  }
}
