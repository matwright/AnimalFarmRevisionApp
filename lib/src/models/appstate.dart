import 'dart:async';
import 'dart:math';

import 'package:animal_farm/src/blocs/nav_bloc.dart';
import 'package:animal_farm/src/models/character.dart';
import 'package:animal_farm/src/models/message.dart';
import 'package:animal_farm/src/models/reward.dart';
import 'package:animal_farm/util/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import 'package:frideos_core/frideos_core.dart';

import 'package:frideos/frideos.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
 var unseenRewardsTimer;
  var unseenMessagesTimer;
  int unseenMessages=0;
int totalMessages;
  AppState._internal() {
    print('-------APP STATE INIT--------');

    _createThemes(themes);


    loadUnseenRewards();
    loadUnseenMessages();

    navBloc =
        NavBloc(stopwatchStream: stopwatchStream, tabController: tabController);

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

  final stopwatchStream =
      StreamedTransformed<String, String>(initialData: "ok");

  //Avatar

  final currentCharacter = StreamedValue<Character>();
  final bioCharacter = StreamedValue<Character>();

  // THEMES
  final themes = List<MyTheme>();
  final currentTheme = StreamedValue<MyTheme>();

  // API
  AppAPI api = MockAPI();
  final apiType = StreamedValue<ApiType>(initialData: ApiType.mock);

  //SOCIAL
  final messagesStream = StreamedList<Message>();
  final characterStream = StreamedList<Character>();
  final  messagesUnseenStream = StreamedValue<int>(initialData: 0);

  //Rewards
  final rewardsStream = StreamedList<Reward>();
  final rewardsUnseenStream = StreamedValue<int>(initialData: 0);
  final rewardInfoStream = StreamedValue<Reward>();
  // TABS
  final tabController = StreamedValue<AppTab>(initialData: AppTab.main);
  final numMessages = StreamedValue(initialData: 0);

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
  NavBloc navBloc;

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

  int getStopwatch() => stopwatch.elapsed.inSeconds;

  Future _loadCharacters() async {
    await api.getCharacters(characterStream);
  }
  loadRewards() {
    return _loadRewards();
  }
  Future _loadRewards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //set default awards if none set
    if(!prefs.containsKey("playerRewards")){
      List<String> defaultRewards=["startApp"];
      prefs.setStringList('playerRewards',defaultRewards);
    }

    final List<String> playerRewards = prefs.getStringList('playerRewards');
    rewardsStream.value=new List();
    if (playerRewards != null) {
      rewardsStream.value =
          rewards.where((i)=> playerRewards.contains(i["id"]))
              .map((reward) => Reward.fromObject(reward))
              .toList();
    }


    prefs.setInt('seenRewards',playerRewards.length);
    rewardsUnseenStream.value=0;
  }

  loadUnseenMessages(){

    if(unseenMessagesTimer==null){

      Timer(Duration(seconds: 5), ()
      {
        _loadUnseenMessages();
        unseenMessagesTimer = Timer.periodic(
       
            Duration(seconds:300), (Timer t) => _loadUnseenMessages());
      });
    }
  }

  Future _loadUnseenMessages() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();

    int numMessages=prefs?.getInt('playerMessages')??1;

    if(numMessages>100){
      prefs.setInt('seenMessages', numMessages);

    }else {
      var randomizer = new Random();
      //choose between 0 and 4 messages to add to list
      int extraMessages = randomizer.nextInt(4);

      numMessages += extraMessages;

      prefs.setInt('playerMessages', numMessages);
      int numSeenMessages = prefs.getInt('seenMessages')??0;

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


  loadUnseenRewards(){

    if(unseenRewardsTimer==null){
      Timer(Duration(seconds: 5), ()
      {
        unseenRewardsTimer = Timer.periodic(
            Duration(seconds: 5), (Timer t) => _loadUnseenRewards());
      });
    }
}

  Future _loadUnseenRewards() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int numRewards=prefs?.getStringList('playerRewards')?.length;
    int numSeenRewards=prefs.getInt('seenRewards')??0;
    if(numRewards!=null && numSeenRewards!=null){
      rewardsUnseenStream.value=numRewards-numSeenRewards;
    }else
      {
        rewardsUnseenStream.value=0;
      }

  }

  loadQuestions() {
    print("loadQuestions appstate 158");
    _loadQuestions();
  }



  loadMessages() {
    _loadMessages();
  }

  Future _loadMessages() async {
    await api.getMessages(messagesStream, numMessages, totalMessages);


    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('seenMessages',numMessages.value);
    messagesUnseenStream.value=0;
  }

  Future _loadQuestions() async {
    print("_loadQuestions 176 appstate");
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
        bottomAppBarColor: Colors.blueGrey[900],
        dividerColor: const Color(0xfffaf333),
        buttonColor: const Color(0xffd63737),
        secondaryHeaderColor: const Color(0xffd63737),
        cardColor: const Color(0xff283593),
      ),
      MyTheme(
        name: 'Dark',
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.blueGrey[900],
        primaryColorBrightness: Brightness.dark,
        accentColor: Colors.greenAccent[400],
        bottomAppBarColor: Colors.blueGrey[900],
        dividerColor: const Color(0xfffaf333),
        buttonColor: const Color(0xffd63737),
        secondaryHeaderColor: const Color(0xffd63737),
        cardColor: const Color(0xff111740),
      ),
    ]);
  }

  void setTheme(MyTheme theme) {
    currentTheme.value = theme;
    Prefs.savePref<String>('apptheme', theme.name);
  }

  set _changeTab(AppTab appTab) => tabController.value = appTab;

  void characterChoices() {
    _loadCharacters();
    _changeTab = AppTab.avatar;
  }

  void navigate(BuildContext context, route) {
    Navigator.pushNamed(context, route);
  }

  void rewardInfo(Reward reward, BuildContext context) {
    rewardInfoStream.value = reward;
    Navigator.pushNamed(context, '/reward');
  }

  void characterBio(Character character, BuildContext context) {
    bioCharacter.value = character;
    Navigator.pushNamed(context, '/bio');
  }

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

  void chooseCharacter(String id) {
    Prefs.savePref<String>('appCharacter', id);
    currentCharacter.value = getCharacterById(id);
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
    navBloc.dispose();
    unseenMessagesTimer?.cancel();
    unseenRewardsTimer?.cancel();
  }
}
