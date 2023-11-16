import 'package:admin_e_learning/quiz/shared/string_const_class.dart';

class Quiz {
  String chapterId;
  String? questionId;
  String question;
  String optionA;
  String optionB;
  String optionC;
  String optionD;
  String correctOption;

  Quiz({
    required this.chapterId,
    this.questionId,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.correctOption,
  });

  static Quiz fromMap(Map<String, dynamic> map) {
    return Quiz(
      chapterId: map[StringConstClass.chapterId],
      questionId: map[StringConstClass.questionId],
      question: map[StringConstClass.question],
      optionA: map[StringConstClass.optionA],
      optionB: map[StringConstClass.optionB],
      optionC: map[StringConstClass.optionC],
      optionD: map[StringConstClass.optionD],
      correctOption: map[StringConstClass.correctOption],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      StringConstClass.chapterId : chapterId,
      StringConstClass.questionId: questionId,
      StringConstClass.question: question,
      StringConstClass.optionA: optionA,
      StringConstClass.optionB: optionB,
      StringConstClass.optionC: optionC,
      StringConstClass.optionD: optionD,
      StringConstClass.correctOption: correctOption,
    };
  }
}
