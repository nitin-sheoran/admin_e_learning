import 'package:admin_e_learning/chapter/model/chapter_model.dart';
import 'package:admin_e_learning/chapter/shared/colors_const.dart';
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
        title: Text(
          widget.chapter.chapterName,
          style: const TextStyle(
            color: ColorsConst.whiteColor,
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
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
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
