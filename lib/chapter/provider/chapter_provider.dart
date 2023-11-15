import 'package:admin_e_learning/chapter/service/chapter_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class ChapterProvider extends ChangeNotifier {
  ChapterService chapterService;

  ChapterProvider(this.chapterService);

  Stream<DatabaseEvent> getChapterStream(String courseId) {
    return chapterService.getChapterStream(courseId);
  }
}
