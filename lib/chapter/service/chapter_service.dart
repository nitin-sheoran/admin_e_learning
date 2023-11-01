import 'package:admin_e_learning/chapter/model/chapter_model.dart';
import 'package:firebase_database/firebase_database.dart';

class ChapterService {
  Future addChapter(Chapter chapter) async {
    final ref = FirebaseDatabase.instance.ref();
    final databaseRef = ref.child('chapter').child(chapter.courseId).push();
    chapter.id = databaseRef.key;
    await databaseRef.set(chapter.toMap());
  }

  Stream<DatabaseEvent> getChapterStream(String courseId) {
    return FirebaseDatabase.instance.ref('chapter').child(courseId).onValue;
  }

  Future<void> chapterUpdate(Chapter chapter) async {
    final dbRef = FirebaseDatabase.instance.ref();
    await dbRef
        .child('chapter')
        .child(chapter.courseId)
        .child(chapter.id!)
        .update(chapter.toMap());
  }

  Future<void> chapterDelete(Chapter chapter) async {
    final dbRef = FirebaseDatabase.instance.ref();
    await dbRef
        .child('chapter')
        .child(chapter.courseId)
        .child(chapter.id!)
        .remove();
  }
}
