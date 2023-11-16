import 'package:admin_e_learning/chapter/provider/chapter_provider.dart';
import 'package:admin_e_learning/shared/colors_const.dart';
import 'package:admin_e_learning/shared/string_const.dart';
import 'package:flutter/material.dart';
import 'package:admin_e_learning/chapter/model/chapter_model.dart';
import 'package:admin_e_learning/chapter/ui/add_chapter_screen.dart';
import 'package:admin_e_learning/chapter/ui/content_detail_screen.dart';
import 'package:admin_e_learning/chapter/ui/chapter_edit_screen.dart';
import 'package:admin_e_learning/course/model/course_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

class ShowChapterScreen extends StatefulWidget {
  final String courseId;
  final Course course;

  const ShowChapterScreen({
    required this.course,
    required this.courseId,
    super.key,
  });

  @override
  _ShowChapterScreenState createState() => _ShowChapterScreenState();
}

class _ShowChapterScreenState extends State<ShowChapterScreen> {
  late ChapterProvider chapterProvider;

  @override
  void initState() {
    chapterProvider = Provider.of<ChapterProvider>(context, listen: false);
    super.initState();
  }

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
                chapterService: chapterProvider.chapterService,
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
              StringConst.showChapterScreenText,
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
      body: Consumer<ChapterProvider>(builder: (create, provider, widgets) {
        return StreamBuilder(
          stream: provider.getChapterStream(widget.courseId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Chapter> chapterList = [];
              DataSnapshot dataSnapshot = snapshot.data!.snapshot;
              if (dataSnapshot.exists) {
                final map = dataSnapshot.value as Map<dynamic, dynamic>;

                map.forEach((key, value) {
                  var chapter = Chapter(
                    id: value[StringConst.id] ?? '',
                    courseId: value[StringConst.courseId1] ?? '',
                    chapterName: value[StringConst.chapterName] ?? '',
                    content: value[StringConst.content] ?? '',
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
                            builder: (context) => ContentDetailScreen(
                              chapter: chapterList[index],
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                chapterList[index].chapterName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChapterEditScreen(
                                          chapter: chapterList[index],
                                          courseId: widget.courseId,
                                          chapterService:
                                              provider.chapterService),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(
                                            StringConst.deleteAlertText),
                                        content: const Text(
                                            StringConst.deleteContentText),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                StringConst.cancelText,
                                              )),
                                          TextButton(
                                            onPressed: () async {
                                              await provider.chapterService
                                                  .chapterDelete(
                                                      chapterList[index]);
                                              if (mounted) {
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Text(
                                              StringConst.deleteText,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: ColorsConst.redColor,
                                ),
                              ),
                            ],
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
        );
      }),
    );
  }
}
