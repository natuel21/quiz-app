import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questions = [
    Question('What is the capital of France?', ['Berlin', 'Paris', 'Rome'], 1),
    Question('What is the highest mountain in the world?',
        ['K2', 'Kangchenjunga', 'Mount Everest'], 2),
    // Add more questions here
  ];

  int currentQuestionIndex = 0;
  int score = 0;

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              currentQuestion.questionText,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ...currentQuestion.options.asMap().entries.map((entry) {
              int index = entry.key;
              String option = entry.value;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    checkAnswer(index);
                  },
                  child: Text(option),
                ),
              );
            }).toList(),
            SizedBox(height: 20),
            Text('Score: $score'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                nextQuestion();
              },
              child: Text('Next Question'),
            ),
          ],
        ),
      ),
    );
  }

  void checkAnswer(int selectedIndex) {
    if (selectedIndex == questions[currentQuestionIndex].correctAnswerIndex) {
      score++;
    }
    setState(() {});
  }

  void nextQuestion() {
    currentQuestionIndex = (currentQuestionIndex + 1) % questions.length;
    setState(() {});
  }
}

class Question {
  String questionText;
  List<String> options;
  int correctAnswerIndex;

  Question(this.questionText, this.options, this.correctAnswerIndex);
}
