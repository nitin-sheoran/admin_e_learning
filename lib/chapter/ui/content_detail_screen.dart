import 'package:admin_e_learning/chapter/model/chapter_model.dart';
import 'package:admin_e_learning/quiz/ui/show_quiz_screen.dart';
import 'package:admin_e_learning/shared/colors_const.dart';
import 'package:flutter/material.dart';

class ContentDetailScreen extends StatefulWidget {
  const ContentDetailScreen({required this.chapter, super.key});

  final Chapter chapter;

  @override
  State<ContentDetailScreen> createState() => _ContentDetailScreenState();
}

class _ContentDetailScreenState extends State<ContentDetailScreen> {
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
                    builder: (context) =>  ShowQuizScreen(
                      chapterId: widget.chapter.id!,
                    ),
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
        child: SingleChildScrollView(
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
      ),
    );
  }
}
