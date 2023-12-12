import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_e_learning/quiz/model/quiz_model.dart';
import 'package:admin_e_learning/quiz/provider/quiz_provider.dart';

class QuestionAnswerWidget extends StatefulWidget {
  final String chapterId;
  final Quiz quiz;

  const QuestionAnswerWidget({
    Key? key,
    required this.chapterId,
    required this.quiz,
  }) : super(key: key);

  @override
  State<QuestionAnswerWidget> createState() => _QuestionAnswerWidgetState();
}

class _QuestionAnswerWidgetState extends State<QuestionAnswerWidget> {
  late QuizProvider quizProvider;
  String selectOption = '';
  bool isOptionSelected = false;
  bool isAnswerCorrect = false;
  IconData feedbackIcon = Icons.check;
  Color feedbackIconColor = Colors.green;

  @override
  void initState() {
    quizProvider = Provider.of<QuizProvider>(context, listen: false);
    super.initState();
  }

  // @override
  // void didUpdateWidget(covariant QuestionAnswerWidget oldWidget) {
  //   // Reset the selected option when the widget updates (new question)
  //   selectOption = '';
  //   isOptionSelected = false;
  //   isAnswerCorrect = false;
  //   feedbackIcon = Icons.check;
  //   feedbackIconColor = Colors.green;
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Que.  ${widget.quiz.question}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          maxLines: 2,
        ),
        RadioListTile<String>(
          title: Text(widget.quiz.optionA),
          value: 'A',
          groupValue: selectOption,
          onChanged: onOptionSelect,
        ),
        RadioListTile<String>(
          title: Text(widget.quiz.optionB),
          value: 'B',
          groupValue: selectOption,
          onChanged: onOptionSelect,
        ),
        RadioListTile<String>(
          title: Text(widget.quiz.optionC),
          value: 'C',
          groupValue: selectOption,
          onChanged: onOptionSelect,
        ),
        RadioListTile<String>(
          title: Text(widget.quiz.optionD),
          value: 'D',
          groupValue: selectOption,
          onChanged: onOptionSelect,
        ),
        if (isOptionSelected)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                isAnswerCorrect
                    ? 'Your answer is correct'
                    : 'Your answer is incorrect\n Correct Answer: ${widget.quiz.correctOption}',
                style: const TextStyle(
                  fontSize: 16,
                  // color: isAnswerCorrect ? Colors.green : Colors.red,
                ),
              ),
              const Spacer(),
              _buildFeedbackIcon(),
            ],
          ),
      ],
    );
  }

  void onOptionSelect(value) {
    if (!isOptionSelected) {
      setState(
        () {
          selectOption = value;
          isOptionSelected = true;
          checkAnswer(
            value,
            widget.quiz.correctOption,
          );
        },
      );
    }
  }

  Widget _buildFeedbackIcon() {
    return Icon(
      feedbackIcon,
      color: feedbackIconColor,
    );
  }

  void checkAnswer(String selected, String correct) {
    setState(() {
      isAnswerCorrect = selected == correct;

      feedbackIcon = isAnswerCorrect ? Icons.check : Icons.clear;
      feedbackIconColor = isAnswerCorrect ? Colors.green : Colors.red;
    });
  }
}
