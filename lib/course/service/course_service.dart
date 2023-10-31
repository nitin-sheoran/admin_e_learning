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
}
//courses->random_id->set our data
