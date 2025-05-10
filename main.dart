
import 'package:flutter/material.dart';

void main() => runApp(FootballQuizApp());

class FootballQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizPage(),
    );
  }
}

class Question {
  final String questionText;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
  });
}

List<Question> questions = [
  Question(
    questionText: "Ποια ομάδα κατέκτησε το Champions League το 2012?",
    options: ["Chelsea", "Bayern Munich", "Real Madrid", "Barcelona"],
    correctAnswer: "Chelsea",
  ),
  Question(
    questionText: "Ποιος παίκτης έχει τις περισσότερες Χρυσές Μπάλες;",
    options: ["Messi", "Ronaldo", "Modric", "Zidane"],
    correctAnswer: "Messi",
  ),
];

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;

  void _nextQuestion(String selectedAnswer) {
    if (selectedAnswer == questions[currentQuestionIndex].correctAnswer) {
      score++;
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultsPage(score: score)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(title: Text('Football Quiz')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(currentQuestion.questionText, style: TextStyle(fontSize: 20)),
          ),
          ...currentQuestion.options.map((option) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: ElevatedButton(
                onPressed: () => _nextQuestion(option),
                child: Text(option),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class ResultsPage extends StatelessWidget {
  final int score;

  ResultsPage({required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Results')),
      body: Center(
        child: Text("Your Score: $score/${questions.length}", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
