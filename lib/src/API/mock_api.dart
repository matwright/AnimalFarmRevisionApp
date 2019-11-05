import 'dart:async';

import 'dart:convert' as convert;

import 'package:animal_farm/src/models/character.dart';
import 'package:animal_farm/src/models/message.dart';
import 'package:animal_farm/util/data.dart' as prefix0;
import 'package:frideos_core/frideos_core.dart';

import '../models/category.dart';
import '../models/question.dart';

import 'api_interface.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;


class MockAPI implements AppAPI {
  @override
  Future<bool> getCategories(StreamedList<Category> categories) async {
    categories.value = [];

    categories.addElement(
      Category(id: 1, name: 'Category demo'),
    );
    return true;
  }

  @override
  Future<bool> getQuestions(
      {StreamedList<Question> questions,
      int number,
      Category category,
      QuestionDifficulty difficulty,
      QuestionType type}) async {

    print("getQuestions");
     var json=await rootBundle.loadString('assets/questions.json');

    final jsonResponse = convert.jsonDecode(json);

    final result = (jsonResponse as List);

     result.shuffle();
     List newData=result.sublist(0,3);
     Iterable questionData=newData.map((question) => QuestionModel.fromJson(question));

    questions.value =
        questionData.map((question) => Question.fromQuestionModel(question)).toList();

    return true;
  }

  @override
  Future<bool> getCharacters(StreamedList<Character> characters) async {

    characters.value =(prefix0.characters)
        .map((character) => Character.fromObject(character)).toList();


    return true;
  }

  @override
  Future<bool> getMessages(StreamedList<Message> messages,StreamedValue numMessages) async {

    var json=await rootBundle.loadString('assets/messages.json');

    final jsonResponse = convert.jsonDecode(json);

    messages.value = (jsonResponse as List)
        .map((message) => Message.fromJson(message)).toList();

    numMessages.value=messages.value.length;
    return true;
  }
}
