import 'package:admin_e_learning/quiz/shared/string_const_class.dart';

class Quiz {
  String chapterId;
  String? questionId;
  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  String correctOption;

  Quiz({
    required this.chapterId,
    this.questionId,
    required this.question,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.correctOption,
  });

  static Quiz fromMap(Map<String, dynamic> map) {
    return Quiz(
      chapterId: map[StringConstClass.chapterId],
      questionId: map[StringConstClass.questionId],
      question: map[StringConstClass.question],
      option1: map[StringConstClass.option1],
      option2: map[StringConstClass.option2],
      option3: map[StringConstClass.option3],
      option4: map[StringConstClass.option4],
      correctOption: map[StringConstClass.correctOption],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      StringConstClass.chapterId : chapterId,
      StringConstClass.questionId: questionId,
      StringConstClass.question: question,
      StringConstClass.option1: option1,
      StringConstClass.option2: option2,
      StringConstClass.option3: option3,
      StringConstClass.option4: option4,
      StringConstClass.correctOption: correctOption,
    };
  }
}
