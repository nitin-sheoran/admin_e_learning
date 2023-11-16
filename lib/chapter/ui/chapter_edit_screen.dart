import 'package:admin_e_learning/chapter/model/chapter_model.dart';
import 'package:admin_e_learning/chapter/service/chapter_service.dart';
import 'package:admin_e_learning/chapter/shared/string_const.dart';
import 'package:flutter/material.dart';
import 'package:admin_e_learning/course/shared/app_const.dart';
import 'package:admin_e_learning/course/shared/color_const.dart';
import 'package:admin_e_learning/chapter/shared/colors_const.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChapterEditScreen extends StatefulWidget {
  final String courseId;
  final ChapterService chapterService;
  final Chapter chapter;

  const ChapterEditScreen({
    required this.chapter,
    required this.courseId,
    required this.chapterService,
    Key? key,
  }) : super(key: key);

  @override
  State<ChapterEditScreen> createState() => _ChapterEditScreenState();
}

class _ChapterEditScreenState extends State<ChapterEditScreen> {
  late TextEditingController chapterNameController;
  late TextEditingController contentController;

  @override
  void initState() {
    Chapter chapter = widget.chapter;
    chapterNameController =
        TextEditingController(text: chapter.chapterName.toString());
    contentController = TextEditingController(text: chapter.content.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            AppConst.updateText,
            style: TextStyle(
              color: ColorConst.whiteColor,
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
                labelText: StringConst.labelText2,
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
                    id: widget.chapter.id,
                    courseId: widget.courseId,
                    content: contentController.text,
                    chapterName: chapterNameController.text,
                  );
                   widget.chapterService.chapterUpdate(chapter);
                  Fluttertoast.showToast(msg: StringConst.toastText2);
                  Navigator.pop(context);
                  chapterNameController.clear();
                  contentController.clear();
                },
                child: const Text(
                  AppConst.updateText,
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
