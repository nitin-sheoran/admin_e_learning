import 'package:admin_e_learning/chapter/model/chapter_model.dart';
import 'package:admin_e_learning/chapter/service/chapter_service.dart';
import 'package:admin_e_learning/chapter/shared/colors_const.dart';
import 'package:admin_e_learning/chapter/ui/add_chapter_screen.dart';
import 'package:admin_e_learning/chapter/ui/content_screen.dart';
import 'package:admin_e_learning/course/model/course_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ShowChapterScreen extends StatefulWidget {
  final ChapterService chapterService;
  final String courseId;
  final Course course;

  const ShowChapterScreen({
    required this.course,
    required this.chapterService,
    required this.courseId,
    super.key,
  });

  @override
  _ShowChapterScreenState createState() => _ShowChapterScreenState();
}

class _ShowChapterScreenState extends State<ShowChapterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsConst.whiteColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddChapterScreen(
                courseId: widget.courseId,
                chapterService: widget.chapterService,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              widget.course.courseName,
              style: const TextStyle(
                color: ColorsConst.whiteColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Chapters',
              style: TextStyle(
                color: ColorsConst.whiteColor,
              ),
            ),
          ],
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
      body: StreamBuilder(
        stream: widget.chapterService.getChapterStream(widget.courseId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Chapter> chapterList = [];
            DataSnapshot dataSnapshot = snapshot.data!.snapshot;
            if (dataSnapshot.exists) {
              final map = dataSnapshot.value as Map<String, dynamic>;

              map.forEach((key, value) {
                var chapter = Chapter(
                  id: value['id'] ?? '',
                  courseId: value['courseId'] ?? '',
                  chapterName: value['chapterName'] ?? '',
                  content: value['content'] ?? '',
                );
                chapterList.add(chapter);
              });
            }
            return ListView.builder(
              itemCount: chapterList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    right: 20,
                    left: 20,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContentScreen(
                            chapter: chapterList[index],
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chapterList[index].chapterName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(color: ColorsConst.black12Color),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
