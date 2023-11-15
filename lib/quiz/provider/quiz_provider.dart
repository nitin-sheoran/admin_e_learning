import 'package:admin_e_learning/quiz/model/quiz_model.dart';
import 'package:admin_e_learning/quiz/service/quiz_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class QuizProvider extends ChangeNotifier {
  QuizService quizService;

  QuizProvider(this.quizService);

  Stream<DatabaseEvent> getQuestionStream(String chapterId) {
    return quizService.getQuestionStream(chapterId);
  }

  Future addQuiz(Quiz quiz) async {
    final ref = FirebaseDatabase.instance.ref();
    final databaseRef = ref.child('quiz').child(quiz.chapterId).push();
    quiz.questionId = databaseRef.key;
    await databaseRef.set(quiz.toMap());
  }
}
