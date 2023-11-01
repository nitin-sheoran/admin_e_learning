import 'package:admin_e_learning/quiz/model/quiz_model.dart';
import 'package:firebase_database/firebase_database.dart';

class QuizService {
  Future addQuiz(Quiz quiz) async {
    final ref = FirebaseDatabase.instance.ref();
    final databaseRef = ref.child('quiz').child(quiz.chapterId).push();
    quiz.questionId = databaseRef.key;
    await databaseRef.set(quiz.toMap());
  }

  Future quizUpdate(Quiz quiz) async {
    final dbRef = FirebaseDatabase.instance.ref();
    await dbRef
        .child('quiz')
        .child(quiz.chapterId)
        .child(quiz.questionId!)
        .update(quiz.toMap());
  }

  Future quizDelete(Quiz quiz) async {
    final dbRef = FirebaseDatabase.instance.ref();
    await dbRef.child('quiz').child(quiz.chapterId).child(quiz.questionId!).remove();
  }

  Stream<DatabaseEvent> getQuestionStream(String courseId) {
    return FirebaseDatabase.instance.ref('quiz').child(courseId).onValue;
  }
}
