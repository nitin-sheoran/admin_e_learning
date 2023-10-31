import 'package:admin_e_learning/chapter/shared/string_const.dart';

class Chapter {
  String? id;
  final String courseId;
  final String chapterName;
  final String content;

  Chapter({
    this.id,
    required this.courseId,
    required this.chapterName,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      StringConst.id: id,
      StringConst.courseId: courseId,
      StringConst.chapterName: chapterName,
      StringConst.content: content,
    };
  }

  factory Chapter.fromMap(Map<dynamic, dynamic> map) {
    return Chapter(
      id: map[StringConst.id],
      courseId: map[StringConst.courseId],
      chapterName: map[StringConst.chapterName],
      content: map[StringConst.content],
    );
  }
}
