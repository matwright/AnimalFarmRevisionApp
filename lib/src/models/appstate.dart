import 'dart:async';
import 'dart:math';

import 'package:animal_farm/src/blocs/nav_bloc.dart';
import 'package:animal_farm/src/models/character.dart';
import 'package:animal_farm/src/models/message.dart';
import 'package:animal_farm/src/models/award.dart';
import 'package:animal_farm/util/data.dart';
import 'package:clock/clock.dart';
import 'package:flutter/foundation.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:frideos/frideos.dart';
import 'package:frideos_core/frideos_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API/api_interface.dart';
import '../API/mock_api.dart';
import '../API/trivia_api.dart';
import '../blocs/trivia_bloc.dart';
import '../models/category.dart';
import '../models/models.dart';
import '../models/question.dart';
import '../models/theme.dart';

class AppState extends AppStateModel with WidgetsBindingObserver {
  static final AppState _singletonAppState = AppState._internal();

  var stopwatch = clock.stopwatch()..start();
  var unseenAwardsTimer;
  var unseenMessagesTimer;
  var setupDate;

  var triggerAwardsTimer;
  int unseenMessages = 0;
  int totalMessages;
  List playerAwards;
  int seenAwards;
  final stopwatchStream = StreamedValue<int>(initialData: 0);

  final currentCharacter = StreamedValue<Character>();

  //TIMER

  final bioCharacter = StreamedValue<Character>();

  //Avatar

  final themes = List<MyTheme>();
  final currentTheme = StreamedValue<MyTheme>();

  // THEMES
  AppAPI api = MockAPI();
  final apiType = StreamedValue<ApiType>(initialData: ApiType.mock);

  // API
  final messagesStream = StreamedList<Message>();
  final characterStream = StreamedList<Character>();

  //SOCIAL
  final messagesUnseenStream = StreamedValue<int>(initialData: 0);
  final awardsStream = StreamedList<Award>();
  final awardsUnseenStream = StreamedValue<int>(initialData: 0);

  //Awards
  final awardInfoStream = StreamedValue<Award>();
  final tabController = StreamedValue<AppTab>(initialData: AppTab.main);
  final numMessages = StreamedValue(initialData: 0);

  // TABS
  final categoryChosen = StreamedValue<Category>();
  final questions = StreamedList<Question>();

  // TRIVIA
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

  TriviaBloc triviaBloc;

  // BLOC
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

  // COUNTDOWN
  factory AppState() => _singletonAppState;

  AppState._internal() {
    print('-------APP STATE INIT--------');

    _createThemes(themes);

    loadUnseenAwards();
    loadUnseenMessages();
    triggerAwards();

    countdown.value = 10.toString();
    countdown.setTransformer(validateCountdown);

    questionsAmount.value = 5.toString();
    questionsAmount.setTransformer(validateAmount);

    triviaBloc = TriviaBloc(
        countdownStream: countdown,
        questions: questions,
        tabController: tabController);
  }

  set _changeTab(AppTab appTab) => tabController.value = appTab;

  addAward(awardTrigger award) {
    playerAwards.add(prefix0.describeEnum(award));
  }

  void characterBio(Character character, BuildContext context) {
    bioCharacter.value = character;
    Navigator.pushNamed(context, '/bio');
  }

  void characterChoices() {
    _loadCharacters();
    _changeTab = AppTab.avatar;
  }

  getTime() async {
    int seconds = await Prefs.getPref('timeSpentSeconds') ?? 0;
    stopwatchStream.value = seconds;
    return seconds;
  }

  saveTime() async {
    int seconds = await getTime();

    Prefs.savePref<int>('timeSpentSeconds', seconds + getStopwatchSeconds());
    stopwatch.reset();
    print(getStopwatchSeconds().toString() + " secs");
  }

  /*
   Get Player Awards

   */
  void chooseCharacter(String id) {
    Prefs.savePref<String>('appCharacter', id);
    currentCharacter.value = getCharacterById(id);
    addAward(awardTrigger.characterSelected);
    _loadUnseenAwards();
  }

  @override
  void dispose() async {
    print('---------APP STATE DISPOSE-----------');
    //save data to drive
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('seenAwards', getSeenAwards());

    apiType.dispose();
    categoryChosen.dispose();
    countdown.dispose();
    currentTheme.dispose();
    questions.dispose();
    questionsAmount.dispose();
    questionsDifficulty.dispose();
    tabController.dispose();
    triviaBloc.dispose();

    unseenMessagesTimer?.cancel();
    unseenAwardsTimer?.cancel();
    triggerAwardsTimer?.cancel();
  }

  void endTrivia() => tabController.value = AppTab.main;

  Character getCharacterById(String id) {
    _loadCharacters();
    var characterObject = characters
        .singleWhere((character) => character["id"] == id, orElse: () => null);
    if (characterObject != null) {
      Character characterModel = new Character.fromObject(characterObject);
      return characterModel;
    }
    return null;
  }

  getSeenAwards() async {
    if (null == seenAwards) {
      //store reference to object rather then repeatedly open prefs from drive
      SharedPreferences prefs = await SharedPreferences.getInstance();

      seenAwards = prefs.getInt('seenAwards') ?? 0;
      //set default awards if none set

    }

    return seenAwards;
  }

  getPlayerAwards() async {
    if (null == playerAwards) {
      //store reference to object rather then repeatedly open prefs from drive
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey("playerAwards")) {
        List<String> defaultAwards = [
          prefix0.describeEnum(awardTrigger.startApp)
        ];
        prefs.setStringList('playerAwards', defaultAwards);
      }
      playerAwards = prefs.getStringList('playerAwards');
      //set default awards if none set

    }

    return playerAwards;
  }

  int getStopwatchDays() => stopwatch.elapsed.inDays;

  int getStopwatchHours() => stopwatch.elapsed.inHours;

  int getStopwatchSeconds() => stopwatch.elapsed.inSeconds;

  int getStopwatchMinutes() => stopwatch.elapsed.inMinutes;

  @override
  Future<void> init() async {
    _loadCharacters();
    final String lastTheme = await Prefs.getPref('apptheme');
    if (lastTheme != null) {
      currentTheme.value = themes.firstWhere((theme) => theme.name == lastTheme,
          orElse: () => themes[0]);
    } else {
      currentTheme.value = themes[0];
    }

    //Prefs.savePref<String>('appCharacter', null);
    final String appCharacter = await Prefs.getPref('appCharacter');
    if (appCharacter != null) {
      currentCharacter.value = getCharacterById(appCharacter);
    } else {
      currentCharacter.value = new Character(id: "noavatar", name: "Comrade");
    }
  }

  loadMessages() {
    _loadMessages();
  }

  loadQuestions() {
    print("loadQuestions appstate 158");
    _loadQuestions();
  }

  loadAwards() {
    return _loadAwards();
  }

  loadUnseenMessages() {
    if (unseenMessagesTimer == null) {
      Timer(Duration(seconds: 5), () {
        _loadUnseenMessages();
        unseenMessagesTimer = Timer.periodic(
            Duration(seconds: 300), (Timer t) => _loadUnseenMessages());
      });
    }
  }

  triggerAwards() {
    if (triggerAwardsTimer == null) {
      Timer(Duration(seconds: 5), () {
        triggerAwardsTimer =
            Timer.periodic(Duration(seconds: 5), (Timer t) => _triggerAwards());
      });
    }
  }

  loadUnseenAwards() {
    if (unseenAwardsTimer == null) {
      Timer(Duration(seconds: 10), () {
        unseenAwardsTimer = Timer.periodic(
            Duration(seconds: 10), (Timer t) => _loadUnseenAwards());
      });
    }
  }

  void navigate(BuildContext context, route) {
    Navigator.pushNamed(context, route);
  }

  void awardInfo(Award award, BuildContext context) {
    awardInfoStream.value = award;
    Navigator.pushNamed(context, '/award');
  }

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

  void setCategory(Category category) => categoryChosen.value = category;

  void setDifficulty(QuestionDifficulty difficulty) =>
      questionsDifficulty.value = difficulty;

  void setTheme(MyTheme theme) {
    currentTheme.value = theme;
    Prefs.savePref<String>('apptheme', theme.name);
  }

  void showSummary() => tabController.value = AppTab.summary;

  void _createThemes(List<MyTheme> themes) {
    themes.addAll([

    MyTheme(
        name: 'light',
      backgroundColor:  Colors.grey
    ),
      MyTheme(
        name: 'blue',
        brightness: Brightness.dark,
        backgroundColor: const Color(0xff111740),
        scaffoldBackgroundColor: const Color(0xff111740),
        primaryColor: const Color(0xff283593),
        primaryColorBrightness: Brightness.dark,
        accentColor: Colors.blue[300],
        bottomAppBarColor:const Color(0xff283593),
        dividerColor: const Color(0xfffaf333),
        buttonColor: const Color(0xffd63737),
        secondaryHeaderColor: const Color(0xffd63737),
        cardColor: const Color(0xff283593),
      ),
      MyTheme(
        name: 'dark',
        brightness:  ThemeData.dark().brightness,
        backgroundColor: ThemeData.dark().backgroundColor,
        scaffoldBackgroundColor: ThemeData.dark().scaffoldBackgroundColor,
        primaryColor: ThemeData.dark().scaffoldBackgroundColor,
        primaryColorBrightness: ThemeData.dark().primaryColorBrightness,
        accentColor: ThemeData.dark().accentColor,
        bottomAppBarColor: ThemeData.dark().bottomAppBarColor,
        dividerColor: ThemeData.dark().dividerColor,
        buttonColor: ThemeData.dark().buttonColor,
        secondaryHeaderColor:ThemeData.dark().secondaryHeaderColor,
        cardColor: ThemeData.dark().cardColor,
      ),
    ]);
  }

  Future _loadCharacters() async {
    await api.getCharacters(characterStream);
  }

  Future _loadMessages() async {
    await api.getMessages(messagesStream, numMessages, totalMessages);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('seenMessages', numMessages.value);
    messagesUnseenStream.value = 0;
  }

  Future _loadQuestions() async {
    await api.getQuestions(
        questions: questions,
        number: int.parse(questionsAmount.value),
        category: categoryChosen.value,
        difficulty: questionsDifficulty.value,
        type: QuestionType.multiple);
  }

  Future _triggerAwards() async {
    print("triggered");
    bool triggered = false;
    List currentAwards = await getPlayerAwards();
    print(getStopwatchHours().toString() + " hours");
    int time = await getTime();
    //once a user has spent an hour in app
    if (time >= (3600) &&
        !currentAwards.contains(prefix0.describeEnum(awardTrigger.firstHour))) {
      addAward(awardTrigger.firstHour);
      triggered = true;
    }

    //assign setDate once to avoid repeat calls to drive
    if (setupDate == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int firstTime = prefs.getInt('firstTime');
      setupDate = DateTime.fromMillisecondsSinceEpoch(firstTime);
    }

    DateTime threeDaysAgo = DateTime.now().subtract(const Duration(days: 3));
    DateTime sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));

    if (!currentAwards.contains(prefix0.describeEnum(awardTrigger.threeDays)) &&
        setupDate.isBefore(threeDaysAgo)) {
      addAward(awardTrigger.threeDays);
      triggered = true;
    }

    if (!currentAwards.contains(prefix0.describeEnum(awardTrigger.sevenDays)) &&
        setupDate.isBefore(sevenDaysAgo)) {
      addAward(awardTrigger.sevenDays);
      triggered = true;
    }

    if (!currentAwards.contains(prefix0.describeEnum(awardTrigger.sundayQuizz)) &&
        DateTime.now().day==0) {
      addAward(awardTrigger.sundayQuizz);
      triggered = true;
    }


    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentCorrectAnswers=prefs.getInt('correctAnwers')??0;

    if (currentCorrectAnswers>=5 && !currentAwards.contains(prefix0.describeEnum(awardTrigger.fiveCorrectAnswers))) {
      addAward(awardTrigger.fiveCorrectAnswers);
      triggered = true;
    }

    if (currentCorrectAnswers>=10 && !currentAwards.contains(prefix0.describeEnum(awardTrigger.tenCorrectAnswers))) {
      addAward(awardTrigger.tenCorrectAnswers);
      triggered = true;
    }

    if (currentCorrectAnswers>=20 && !currentAwards.contains(prefix0.describeEnum(awardTrigger.twentyCorrectAnswers))) {
      addAward(awardTrigger.twentyCorrectAnswers);
      triggered = true;
    }

    if (currentCorrectAnswers>=50 && !currentAwards.contains(prefix0.describeEnum(awardTrigger.fiftyCorrectAnswers))) {
      addAward(awardTrigger.fiftyCorrectAnswers);
      triggered = true;
    }

    if (currentCorrectAnswers>=100 && !currentAwards.contains(prefix0.describeEnum(awardTrigger.hundredCorrectAnswers))) {
      addAward(awardTrigger.hundredCorrectAnswers);
      triggered = true;
    }

    if (currentCorrectAnswers>=200 && !currentAwards.contains(prefix0.describeEnum(awardTrigger.twoHundredCorrectAnswers))) {
      addAward(awardTrigger.twoHundredCorrectAnswers);
      triggered = true;
    }



    if (triggered) {
      _loadUnseenAwards();
    }
  }

  Future _loadAwards() async {
    awardsStream.value = new List();
    List awards = await getPlayerAwards();
    if (awards != null) {
      awardsStream.value = awardsData
          .where((i) {
            String id = prefix0.describeEnum(i["id"]);
            return awards.contains(id);
          })
          .map((award) => Award.fromObject(award))
          .toList();
    }

    seenAwards = awards.length;
    awardsUnseenStream.value = 0;
  }

  Future _loadUnseenMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int numMessages = prefs?.getInt('playerMessages') ?? 1;

    if (numMessages > 100) {
      prefs.setInt('seenMessages', numMessages);
    } else {
      var randomizer = new Random();
      //choose between 0 and 4 messages to add to list
      int extraMessages = randomizer.nextInt(4);

      numMessages += extraMessages;

      prefs.setInt('playerMessages', numMessages);
      int numSeenMessages = prefs.getInt('seenMessages') ?? 0;

      if (numMessages != null && numSeenMessages != null) {
        int newUnseenMessages = numMessages - numSeenMessages;

        if (newUnseenMessages > unseenMessages) {
          unseenMessages = newUnseenMessages;
        }
        messagesUnseenStream.value = unseenMessages;
      } else {
        messagesUnseenStream.value = 0;
      }
    }
  }

  Future _loadUnseenAwards() async {
    List awards = await getPlayerAwards();
    int numAwards = awards.length;
    int numSeenAwards = await getSeenAwards();
    if (numAwards != null && numSeenAwards != null) {
      awardsUnseenStream.value = numAwards - numSeenAwards;
    } else {
      awardsUnseenStream.value = 0;
    }
  }
}
