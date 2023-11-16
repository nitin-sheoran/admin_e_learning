import 'package:admin_e_learning/shared/string_const.dart';

class Course {
  final String? courseId;
  final String courseName;
  final String imgUrl;

  Course({
    this.courseId,
    required this.courseName,
    this.imgUrl = StringConst.invertedComa,
  });

  static Course fromMap(Map<String, dynamic> map) {
    return Course(
      courseId: map[StringConst.courseId1],
      courseName: map[StringConst.courseName],
      imgUrl: map[StringConst.imgUrl],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      StringConst.courseId1: courseId,
      StringConst.courseName: courseName,
      StringConst.imgUrl: imgUrl,
    };
  }
}
