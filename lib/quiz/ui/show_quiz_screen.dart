import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:admin_e_learning/quiz/model/quiz_model.dart';
import 'package:admin_e_learning/quiz/ui/add_quiz_screen.dart';
import 'package:admin_e_learning/quiz/service/quiz_service.dart';
import 'package:admin_e_learning/quiz/ui/quiz_update_screen.dart';
import 'package:admin_e_learning/chapter/shared/colors_const.dart';

class ShowQuizScreen extends StatefulWidget {
  final QuizService quizService;
  final String chapterId;

  const ShowQuizScreen({
    required this.chapterId,
    required this.quizService,
    super.key,
  });

  @override
  State<ShowQuizScreen> createState() => _ShowQuizScreenState();
}

class _ShowQuizScreenState extends State<ShowQuizScreen> {
  List<String> selectedOptions = List.filled(4, '');

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
                quizService: QuizService(),
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
      body: StreamBuilder(
        stream: widget.quizService.getQuestionStream(widget.chapterId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Quiz> quizList = [];
            DataSnapshot dataSnapshot = snapshot.data!.snapshot;
            if (dataSnapshot.exists) {
              final map = dataSnapshot.value as Map<String, dynamic>;

              map.forEach((key, value) {
                var quiz = Quiz(
                  chapterId: value['chapterId'] ?? '',
                  questionId: value['questionId'] ?? '',
                  option1: value['option1'] ?? '',
                  option2: value['option2'] ?? '',
                  option3: value['option3'] ?? '',
                  option4: value['option4'] ?? '',
                  question: value['question'] ?? '',
                  correctOption: value['correctOption'] ?? '',
                );
                quizList.add(quiz);
              });
            }
            return ListView.builder(
              itemCount: quizList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 40, right: 10),
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
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuizUpdateScreen(
                                    quiz: quizList[index],
                                    chapterId: widget.chapterId,
                                    quizService: widget.quizService,
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
                                          await widget.quizService
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
                        title: Text(quizList[index].option1),
                        value: 'A',
                        groupValue: selectedOptions[index],
                        onChanged: (value) {
                          setState(() {
                            selectedOptions[index] = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: Text(quizList[index].option2),
                        value: 'B',
                        groupValue: selectedOptions[index],
                        onChanged: (value) {
                          setState(() {
                            selectedOptions[index] = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: Text(quizList[index].option3),
                        value: 'C',
                        groupValue: selectedOptions[index],
                        onChanged: (value) {
                          setState(() {
                            selectedOptions[index] = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: Text(quizList[index].option4),
                        value: 'D',
                        groupValue: selectedOptions[index],
                        onChanged: (value) {
                          setState(() {
                            selectedOptions[index] = value!;
                          });
                        },
                      ),
                      Text(
                        'Correct Option: ${selectedOptions[index]}',
                        style: const TextStyle(),
                      ),
                    ],
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
