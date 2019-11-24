import 'package:animal_farm/src/models/character.dart';
import 'package:animal_farm/src/models/message.dart';
import 'package:frideos_core/frideos_core.dart';

import '../models/category.dart';
import '../models/question.dart';

abstract class AppAPI {
  Future<bool> getCharacters(StreamedList<Character> characters);

  Future<bool> getMessages(StreamedList<Message> messages,
      StreamedValue numMessages, int totalMessage);

  Future<bool> getCategories(StreamedList<Category> categories);

  Future<bool> getQuestions(
      {StreamedList<Question> questions,
      int number,
      Category category,
      QuestionDifficulty difficulty,
      QuestionType type});
}
