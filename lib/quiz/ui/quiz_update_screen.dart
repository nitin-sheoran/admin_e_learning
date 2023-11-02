import 'package:admin_e_learning/quiz/model/quiz_model.dart';
import 'package:admin_e_learning/quiz/service/quiz_service.dart';
import 'package:admin_e_learning/quiz/ui/validators.dart';
import 'package:flutter/material.dart';
import 'package:admin_e_learning/course/shared/app_const.dart';
import 'package:admin_e_learning/course/shared/color_const.dart';
import 'package:admin_e_learning/chapter/shared/colors_const.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuizUpdateScreen extends StatefulWidget {
  final String chapterId;
  final QuizService quizService;
  final Quiz quiz;

  const QuizUpdateScreen({
    required this.quiz,
    required this.chapterId,
    required this.quizService,
    Key? key,
  }) : super(key: key);

  @override
  State<QuizUpdateScreen> createState() => _QuizUpdateScreenState();
}

class _QuizUpdateScreenState extends State<QuizUpdateScreen> {
  late TextEditingController questionController;
  late TextEditingController option1Controller;
  late TextEditingController option2Controller;
  late TextEditingController option3Controller;
  late TextEditingController option4Controller;

  @override
  void initState() {
    Quiz quiz = widget.quiz;
    questionController = TextEditingController(text: quiz.question);
    option1Controller = TextEditingController(text: quiz.option1);
    option2Controller = TextEditingController(text: quiz.option2);
    option3Controller = TextEditingController(text: quiz.option3);
    option4Controller = TextEditingController(text: quiz.option4);
    super.initState();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String selectedOption = '';
  bool answerCorrect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            AppConst.updateText1,
            style: TextStyle(
              color: ColorConst.whiteColor,
            ),
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
      body: Form(
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 14),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: questionController,
                    validator: (String? value) {
                      return Validators.question(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Question',
                    ),
                  ),
                  TextFormField(
                    controller: option1Controller,
                    validator: (String? value) {
                      return Validators.option1(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Option 1',
                    ),
                  ),
                  TextFormField(
                    controller: option2Controller,
                    validator: (String? value) {
                      return Validators.option2(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Option 2',
                    ),
                  ),
                  TextFormField(
                    controller: option3Controller,
                    validator: (String? value) {
                      return Validators.option3(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Option 3',
                    ),
                  ),
                  TextFormField(
                    controller: option4Controller,
                    validator: (String? value) {
                      return Validators.option4(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Option 4',
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'A',
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                      const Text('Option A'),
                      Radio<String>(
                        value: 'B',
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                      const Text('Option B'),
                      Radio<String>(
                        value: 'C',
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                      const Text('Option C'),
                      Radio<String>(
                        value: 'D',
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                      const Text('Option D'),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        Quiz quiz = Quiz(
                          question: questionController.text,
                          option1: option1Controller.text,
                          option2: option2Controller.text,
                          option3: option3Controller.text,
                          option4: option4Controller.text,
                          chapterId: widget.chapterId,
                          correctOption: selectedOption,
                          questionId: widget.quiz.questionId,
                        );
                        widget.quizService.quizUpdate(quiz);
                        Fluttertoast.showToast(msg: 'Saved');
                      }
                    },
                    child: const Text('Update Quiz'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
