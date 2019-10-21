import 'dart:async';

import 'dart:convert' as convert;

import 'package:frideos_core/frideos_core.dart';

import '../models/category.dart';
import '../models/question.dart';

import 'api_interface.dart';

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
    const json =
        "{\"response_code\":0,\"results\":[{\"type\":\"multiple\",\"difficulty\":\"easy\",\"question\":\"Who was the highest ranking animal before the return of the humans?\",\"correct_answer\":\"Napolean\",\"incorrect_answers\":[\"Snowball\",\"Squealer\",\"Trotsky\"]}]}";

    final jsonResponse = convert.jsonDecode(json);

    final result = (jsonResponse['results'] as List)
        .map((question) => QuestionModel.fromJson(question));

    questions.value =
        result.map((question) => Question.fromQuestionModel(question)).toList();

    return true;
  }
}
