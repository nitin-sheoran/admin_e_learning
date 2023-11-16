import 'package:admin_e_learning/quiz/provider/quiz_provider.dart';
import 'package:admin_e_learning/shared/colors_const.dart';
import 'package:admin_e_learning/shared/string_const.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:admin_e_learning/quiz/model/quiz_model.dart';
import 'package:admin_e_learning/quiz/ui/add_quiz_screen.dart';
import 'package:admin_e_learning/quiz/ui/quiz_update_screen.dart';
import 'package:provider/provider.dart';

class ShowQuizScreen extends StatefulWidget {
  final String chapterId;

  const ShowQuizScreen({
    required this.chapterId,
    super.key,
  });

  @override
  State<ShowQuizScreen> createState() => _ShowQuizScreenState();
}

class _ShowQuizScreenState extends State<ShowQuizScreen> {
  List<String> selectedOption = [];
  late QuizProvider quizProvider;

  @override
  void initState() {
    quizProvider = Provider.of<QuizProvider>(context, listen: false);
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
              builder: (context) => AddQuizScreen(
                chapterId: widget.chapterId,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          'Show Quiz',
          style: TextStyle(
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
      body: Consumer<QuizProvider>(builder: (create, provider, widgtes) {
        return StreamBuilder(
          stream: provider.getQuestionStream(widget.chapterId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Quiz> quizList = [];
              DataSnapshot dataSnapshot = snapshot.data!.snapshot;
              if (dataSnapshot.exists) {
                final map = dataSnapshot.value as Map<dynamic, dynamic>;

                map.forEach((key, value) {
                  Quiz quiz = fromMap(value);
                  quizList.add(quiz);
                });
              }
              return ListView.builder(
                itemCount: quizList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Que.  ${quizList[index].question}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QuizUpdateScreen(
                                      quiz: quizList[index],
                                      chapterId: widget.chapterId,
                                      quizService: provider.quizService,
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
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await provider.quizService
                                                .quizDelete(quizList[index]);
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
                        RadioListTile<String>(
                          title: Text(quizList[index].optionA),
                          value: 'A',
                          groupValue: quizList[index].correctOption,
                          onChanged: (value) {},
                        ),
                        RadioListTile<String>(
                          title: Text(quizList[index].optionB),
                          value: 'B',
                          groupValue: quizList[index].correctOption,
                          onChanged: (value) {},
                        ),
                        RadioListTile<String>(
                          title: Text(quizList[index].optionC),
                          value: 'C',
                          groupValue: quizList[index].correctOption,
                          onChanged: (value) {},
                        ),
                        RadioListTile<String>(
                          title: Text(quizList[index].optionD),
                          value: 'D',
                          groupValue: quizList[index].correctOption,
                          onChanged: (value) {},
                        ),
                        Text(
                          'Correct Option:  ${quizList[index].correctOption}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
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

  Quiz fromMap(value) {
    var quiz = Quiz(
      chapterId: value[StringConst.chapterId] ?? '',
      questionId: value[StringConst.questionId] ?? '',
      optionA: value[StringConst.optionA] ?? '',
      optionB: value[StringConst.optionB] ?? '',
      optionC: value[StringConst.optionC] ?? '',
      optionD: value[StringConst.optionD] ?? '',
      question: value[StringConst.question] ?? '',
      correctOption: value[StringConst.correctOption] ?? '',
    );
    return quiz;
  }
}
