import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:admin_e_learning/course/model/course_model.dart';
import 'package:admin_e_learning/course/shared/color_const.dart';
import 'package:admin_e_learning/chapter/shared/colors_const.dart';
import 'package:admin_e_learning/course/ui/add_course_screen.dart';
import 'package:admin_e_learning/chapter/service/chapter_service.dart';
import 'package:admin_e_learning/chapter/ui/show_chapter_screen.dart';
import 'package:admin_e_learning/course/service/course_service.dart';
import 'package:admin_e_learning/course/ui/course_update_screen.dart';

class ShowCourseScreen extends StatefulWidget {
  final CourseService courseService;

  const ShowCourseScreen({required this.courseService, super.key});

  @override
  _ShowCourseScreenState createState() => _ShowCourseScreenState();
}

class _ShowCourseScreenState extends State<ShowCourseScreen> {
  final TextEditingController itemController = TextEditingController();

  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsConst.whiteColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCourseScreen(
                courseService: widget.courseService,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: isSearch
            ? TextField(
                controller: itemController,
                decoration: const InputDecoration(
                  labelText: 'Search names...',
                  labelStyle: TextStyle(color: ColorsConst.whiteColor),
                ),
                cursorColor: ColorsConst.whiteColor,
              )
            : const Text(
                'Courses',
                style: TextStyle(
                  color: ColorConst.whiteColor,
                  fontSize: 26,
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearch = !isSearch;
              });
            },
            icon: Icon(
              isSearch ? Icons.clear : Icons.search,
              color: ColorsConst.whiteColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Share.share('com.example.admin_e_learning');
              },
              icon: const Icon(
                Icons.share,
                color: ColorsConst.whiteColor,
              ),
            ),
          ),
        ],
        backgroundColor: ColorConst.greenColor,
      ),
      body: StreamBuilder(
        stream: widget.courseService.getCourseStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Course> courseList = [];
            DataSnapshot dataSnapshot = snapshot.data!.snapshot;
            final map = dataSnapshot.value as Map<dynamic, dynamic>;

            forEach(map, courseList);

            return Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  mainAxisExtent: 200,
                ),
                itemCount: courseList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowChapterScreen(
                            course: courseList[index],
                            chapterService: ChapterService(),
                            courseId: courseList[index].courseId!,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      surfaceTintColor: ColorConst.whiteColor,
                      color: ColorsConst.whiteColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CourseUpdateScreen(
                                        course: courseList[index],
                                        courseService: CourseService(),
                                      ),
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
                                          title: const Text("Delete Alert"),
                                          content: const Text(
                                              "Are you sure to delete it ?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "Cancel",
                                                )),
                                            TextButton(
                                              onPressed: () async {
                                                await widget.courseService
                                                    .courseDelete(
                                                        courseList[index]);
                                                if (mounted) {
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: const Text(
                                                "Delete",
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: ColorsConst.redColor,
                                ),
                              ),
                              if (courseList[index].imgUrl.isNotEmpty)
                                Image.network(
                                  courseList[index].imgUrl,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                            ],
                          ),
                          Text(
                            courseList[index].courseName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  void forEach(Map<dynamic, dynamic> map, List<Course> courseList) {
    map.forEach((key, value) {
      var course = Course(
        courseId: key,
        courseName: value['courseName'] ?? '',
        imgUrl: value['imgUrl'] ?? '',
      );
      courseList.add(course);
    });
  }
}
