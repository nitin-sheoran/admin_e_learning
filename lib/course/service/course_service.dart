import 'package:admin_e_learning/course/model/course_model.dart';
import 'package:firebase_database/firebase_database.dart';

class CourseService {
  final databaseRef = FirebaseDatabase.instance.ref().child('courses');

  Future<void> addCourse(Course course) async {
    final dbRef = databaseRef.push();
    String? id = dbRef.key;
    await dbRef.set({
      'courseName': course.courseName,
      'imgUrl': course.imgUrl,
      'id': id,
    });
  }

  Stream<DatabaseEvent> getCourseStream() {
    return databaseRef.onValue;
  }

  // Future<void> updateCourse(Course course) async {
  //   final dbRef = FirebaseDatabase.instance.ref();
  //   await dbRef
  //       .child('courses')
  //       .child(course.courseId!)
  //       .update(course.toMap());
  // }

  Future<void> update(Course course) async {
    final dbRef = databaseRef.child(course.courseId!);
    await dbRef.update({
      'courseName': course.courseName,
      'imgUrl': course.imgUrl,
    });
  }

  Future<void> courseDelete(Course course) async {
    final dbRef = FirebaseDatabase.instance.ref();
    await dbRef.child('courses').child(course.courseId.toString()).remove();
  }
}
