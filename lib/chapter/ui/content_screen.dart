import 'package:admin_e_learning/chapter/model/chapter_model.dart';
import 'package:admin_e_learning/chapter/shared/colors_const.dart';
import 'package:admin_e_learning/quiz/ui/add_question_screen.dart';
import 'package:flutter/material.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({required this.chapter, super.key});

  final Chapter chapter;

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: ColorsConst.whiteColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddQuestionScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.quiz,
                color: ColorsConst.whiteColor,
              ),
            ),
          ),
        ],
        backgroundColor: ColorsConst.blueColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            Center(
              child: Text(
                widget.chapter.chapterName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              widget.chapter.content,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
