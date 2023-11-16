import 'package:admin_e_learning/chapter/model/chapter_model.dart';
import 'package:admin_e_learning/chapter/service/chapter_service.dart';
import 'package:admin_e_learning/shared/colors_const.dart';
import 'package:admin_e_learning/shared/string_const.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddChapterScreen extends StatelessWidget {
  final String courseId;
  final TextEditingController chapterNameController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final ChapterService chapterService;

  AddChapterScreen({
    required this.courseId,
    required this.chapterService,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            StringConst.titleText,
            style: TextStyle(
              color: ColorsConst.whiteColor,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: ColorsConst.whiteColor,
          ),
        ),
        backgroundColor: ColorsConst.blueColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: chapterNameController,
              decoration: const InputDecoration(
                labelText: StringConst.labelText1,
              ),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: StringConst.labelText2
              ),
              maxLines: 6,
            ),
            const SizedBox(
              height: 26,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  Chapter chapter = Chapter(
                    courseId: courseId,
                    content: contentController.text,
                    chapterName: chapterNameController.text,
                  );
                  chapterService.addChapter(chapter);
                  Fluttertoast.showToast(msg: StringConst.toastText);
                  Navigator.pop(context);
                  contentController.clear();
                  chapterNameController.clear();
                },
                child: const Text(
                  StringConst.buttonText,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
