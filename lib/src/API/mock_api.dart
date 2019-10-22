import 'dart:async';

import 'dart:convert' as convert;

import 'package:frideos_core/frideos_core.dart';

import '../models/category.dart';
import '../models/question.dart';

import 'api_interface.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/questions.json');
}

class MockAPI implements QuestionsAPI {
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


     var json=await rootBundle.loadString('assets/questions.json');

    final jsonResponse = convert.jsonDecode(json);

    final result = (jsonResponse as List)
        .map((question) => QuestionModel.fromJson(question));

    questions.value =
        result.map((question) => Question.fromQuestionModel(question)).toList();

    return true;
  }
}
