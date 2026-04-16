import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/models/question_modal.dart';
import 'package:quiz_app/screens/result_screen.dart';
import 'package:quiz_app/widgets/custom_button.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.onSelectAnswer});

  final void Function(String) onSelectAnswer;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentQuestionIndex = 0;
  Question get currentQuestion => questions[currentQuestionIndex];

  void onAnswerTap(String answer) {
    // if (currentQuestionIndex == questions.length - 1) {
    widget.onSelectAnswer(answer);
    setState(() {
      currentQuestionIndex++;
    });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            currentQuestion.questionText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          ...currentQuestion.getShuffledAnswers().map((answer) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: CustomButton(
                text: answer,
                onPressed: () => onAnswerTap(answer),
              ),
            );
          }),
        ],
      ),
    );
  }
}
