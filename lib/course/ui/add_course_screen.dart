import 'package:admin_e_learning/shared/colors_const.dart';
import 'package:admin_e_learning/shared/string_const.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:admin_e_learning/course/model/course_model.dart';
import 'package:admin_e_learning/course/service/course_service.dart';

class AddCourseScreen extends StatelessWidget {
  AddCourseScreen({super.key, required this.courseService});

  final CourseService courseService;

  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController imgUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            StringConst.titleText,
            style: TextStyle(color: ColorsConst.whiteColor),
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
        backgroundColor: ColorsConst.greenColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: courseNameController,
              decoration: const InputDecoration(
                labelText: StringConst.courseNameText,
              ),
            ),
            TextField(
              controller: imgUrlController,
              decoration: const InputDecoration(
                labelText: StringConst.imgUrlText,
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
                    courseName: courseNameController.text,
                    imgUrl: imgUrlController.text,
                  );
                  courseService.addCourse(course);
                  Fluttertoast.showToast(
                    msg: StringConst.toastText1,
                  );
                  allClear();
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

  void allClear() {
    courseNameController.clear();
    imgUrlController.clear();
  }
}
