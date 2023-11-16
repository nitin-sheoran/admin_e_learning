import 'package:admin_e_learning/quiz/model/quiz_model.dart';
import 'package:admin_e_learning/quiz/provider/quiz_provider.dart';
import 'package:admin_e_learning/quiz/shared/string_const_class.dart';
import 'package:admin_e_learning/quiz/ui/validators.dart';
import 'package:admin_e_learning/shared/colors_const.dart';
import 'package:admin_e_learning/shared/string_const.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddQuizScreen extends StatefulWidget {
  final String chapterId;

  const AddQuizScreen({
    required this.chapterId,
    super.key,
  });

  @override
  State<AddQuizScreen> createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  late QuizProvider quizProvider;
  TextEditingController questionController = TextEditingController();
  TextEditingController option1Controller = TextEditingController();
  TextEditingController option2Controller = TextEditingController();
  TextEditingController option3Controller = TextEditingController();
  TextEditingController option4Controller = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String selectedOption = '';
  bool answerCorrect = false;

  @override
  void initState() {
    quizProvider = Provider.of<QuizProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringConst.addQuiz,
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
      body: Consumer<QuizProvider>(
        builder: (create, provider, widgets) {
          return Form(
            key: formKey,
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
                        labelText: StringConst.question,
                      ),
                    ),
                    TextFormField(
                      controller: option1Controller,
                      validator: (String? value) {
                        return Validators.option1(value);
                      },
                      decoration: const InputDecoration(
                        labelText: StringConst.optionA,
                      ),
                    ),
                    TextFormField(
                      controller: option2Controller,
                      validator: (String? value) {
                        return Validators.option2(value);
                      },
                      decoration: const InputDecoration(
                        labelText: StringConst.optionB,
                      ),
                    ),
                    TextFormField(
                      controller: option3Controller,
                      validator: (String? value) {
                        return Validators.option3(value);
                      },
                      decoration: const InputDecoration(
                        labelText: StringConst.optionC,
                      ),
                    ),
                    TextFormField(
                      controller: option4Controller,
                      validator: (String? value) {
                        return Validators.option4(value);
                      },
                      decoration: const InputDecoration(
                        labelText: StringConst.optionD,
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Radio<String>(
                            value: StringConst.textA,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value!;
                              });
                            },
                          ),
                          const Text(StringConst.optionA),
                          Radio<String>(
                            value: StringConst.textB,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value!;
                              });
                            },
                          ),
                          const Text(StringConst.optionB),
                          Radio<String>(
                            value: StringConst.textC,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value!;
                              });
                            },
                          ),
                          const Text(StringConst.optionC),
                          Radio<String>(
                            value: StringConst.textD,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(
                                () {
                                  selectedOption = value!;
                                },
                              );
                            },
                          ),
                          const Text(StringConst.optionD),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            Quiz quiz = allController();
                            provider.addQuiz(quiz);
                            Fluttertoast.showToast(msg: StringConst.toastText);
                            Navigator.pop(context);
                            allClear();
                          }
                        },
                        child: const Text(
                          StringConst.addQuiz,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Quiz allController() {
    Quiz quiz = Quiz(
      question: questionController.text,
      optionA: option1Controller.text,
      optionB: option2Controller.text,
      optionC: option3Controller.text,
      optionD: option4Controller.text,
      chapterId: widget.chapterId,
      correctOption: selectedOption,
    );
    return quiz;
  }

  void allClear() {
    questionController.clear();
    option1Controller.clear();
    option2Controller.clear();
    option3Controller.clear();
    option4Controller.clear();
  }
}
