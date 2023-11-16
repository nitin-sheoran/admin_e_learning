import 'package:admin_e_learning/shared/string_const.dart';

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
      chapterId: map[StringConst.chapterId],
      questionId: map[StringConst.questionId],
      question: map[StringConst.question],
      optionA: map[StringConst.optionA],
      optionB: map[StringConst.optionB],
      optionC: map[StringConst.optionC],
      optionD: map[StringConst.optionD],
      correctOption: map[StringConst.correctOption],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      StringConst.chapterId : chapterId,
      StringConst.questionId: questionId,
      StringConst.question: question,
      StringConst.optionA: optionA,
      StringConst.optionB: optionB,
      StringConst.optionC: optionC,
      StringConst.optionD: optionD,
      StringConst.correctOption: correctOption,
    };
  }
}
