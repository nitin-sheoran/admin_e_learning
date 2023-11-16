import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:admin_e_learning/chapter/shared/string_const.dart';
import 'package:admin_e_learning/course/shared/app_const.dart';
import 'package:admin_e_learning/course/model/course_model.dart';
import 'package:admin_e_learning/course/shared/color_const.dart';
import 'package:admin_e_learning/chapter/shared/colors_const.dart';
import 'package:admin_e_learning/course/ui/add_course_screen.dart';
import 'package:admin_e_learning/chapter/ui/show_chapter_screen.dart';
import 'package:admin_e_learning/course/service/course_service.dart';
import 'package:admin_e_learning/course/ui/course_update_screen.dart';
import 'package:admin_e_learning/course/provider/course_provider.dart';

class ShowCourseScreen extends StatefulWidget {
  const ShowCourseScreen({super.key});

  @override
  _ShowCourseScreenState createState() => _ShowCourseScreenState();
}

class _ShowCourseScreenState extends State<ShowCourseScreen> {
  final TextEditingController itemController = TextEditingController();
  late CourseProvider courseProvider;

  @override
  void initState() {
    courseProvider = Provider.of<CourseProvider>(context, listen: false);
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
              builder: (context) => AddCourseScreen(
                courseService: courseProvider.courseService,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
                AppConst.titleText2,
                style: TextStyle(
                  color: ColorConst.whiteColor,
                  fontSize: 26,
                ),
              ),
        backgroundColor: ColorConst.greenColor,
      ),
      body: Consumer<CourseProvider>(builder: (create, provider, widget) {
        return StreamBuilder(
          stream: provider.getCourseStream(),
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
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CourseUpdateScreen(
                                          course: courseList[index],
                                          courseService: CourseService(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                                const Spacer(),
                                TextButton(
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
                                                  await provider.courseService
                                                      .courseDelete(
                                                          courseList[index]);
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
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: ColorsConst.redColor,
                                      ),
                                    )),
                              ],
                            ),
                            if (courseList[index].imgUrl.isNotEmpty)
                              Image.network(
                                courseList[index].imgUrl,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
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
        );
      }),
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
