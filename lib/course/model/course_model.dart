import 'package:admin_e_learning/course/shared/app_const.dart';

class Course {
  final String? courseId;
  final String courseName;
  final String imgUrl;

  Course({
     this.courseId,
    required this.courseName,
     this.imgUrl = AppConst.invertedComa,
  });

  static Course fromMap(Map<String, dynamic> map) {
    return Course(
      courseId: map[AppConst.courseId],
      courseName: map[AppConst.courseName],
      imgUrl: map[AppConst.imgUrl],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      AppConst.courseId: courseId,
      AppConst.courseName: courseName,
      AppConst.imgUrl: imgUrl,
    };
  }
}
