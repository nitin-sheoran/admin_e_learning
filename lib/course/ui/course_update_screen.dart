import 'package:admin_e_learning/chapter/shared/colors_const.dart';
import 'package:admin_e_learning/course/model/course_model.dart';
import 'package:admin_e_learning/course/service/course_service.dart';
import 'package:admin_e_learning/course/shared/app_const.dart';
import 'package:admin_e_learning/course/shared/color_const.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CourseUpdateScreen extends StatefulWidget {
   const CourseUpdateScreen({
    super.key,
    required this.course,
    required this.courseService,
  });

  final CourseService courseService;
  final Course course;

  @override
  State<CourseUpdateScreen> createState() => _CourseUpdateScreenState();
}

class _CourseUpdateScreenState extends State<CourseUpdateScreen> {
  late TextEditingController courseNameController;
  late TextEditingController imgUrlController;

  @override
  void initState() {
    Course course = widget.course;
    courseNameController = TextEditingController(text: course.courseName);
    imgUrlController = TextEditingController(text: course.imgUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            AppConst.titleText,
            style: TextStyle(color: ColorConst.whiteColor),
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
        backgroundColor: ColorConst.greenColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: courseNameController,
              decoration: const InputDecoration(
                labelText: AppConst.courseNameText,
              ),
            ),
            TextField(
              controller: imgUrlController,
              decoration: const InputDecoration(
                labelText: AppConst.imgUrlText,
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  Course course = Course(
                    courseId: widget.course.courseId,
                    courseName: courseNameController.text,
                    imgUrl: imgUrlController.text,
                  );
                  widget.courseService.update(course);
                  Fluttertoast.showToast(
                    msg: 'Update Successfully',
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  AppConst.buttonText,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void allClear() {
    courseNameController.clear();
    imgUrlController.clear();
  }
}
