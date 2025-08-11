import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  // Java quiz questions
  List<Map> allQuestions = [
    {
      'question': "Which of the following is not a Java keyword?",
      'options': ['class', 'goto', 'unsigned', 'extends'],
      'correctAnswer': 2,
    },
    {
      'question': "Which method is the entry point of a Java program?",
      'options': ['main()', 'start()', 'run()', 'init()'],
      'correctAnswer': 0,
    },
    {
      'question': "Which concept does Java use to achieve runtime polymorphism?",
      'options': ['Method overloading', 'Method overriding', 'Encapsulation', 'Abstraction'],
      'correctAnswer': 1,
    },
    {
      'question': "Which of the following is true about Java?",
      'options': [
        'Java supports multiple inheritance using classes',
        'Java is platform-dependent',
        'Java uses garbage collection for memory management',
        'Java does not support OOP concepts'
      ],
      'correctAnswer': 2,
    },
    {
      'question': "Which of these is used to handle exceptions in Java?",
      'options': ['catch', 'try', 'throw', 'All of the above'],
      'correctAnswer': 3,
    },
  ];

  int currentQuestionIndex = 0;
  int selectedAnswerIndex = -1;
  bool isQuestionPage = true;
  int score = 0;

 
  MaterialStateProperty<Color?> checkAnswer(int answerIndex) {
    if (selectedAnswerIndex != -1) {
      if (answerIndex ==
          allQuestions[currentQuestionIndex]['correctAnswer']) {
        return MaterialStateProperty.all(Colors.green);
      } else if (selectedAnswerIndex == answerIndex) {
        return MaterialStateProperty.all(Colors.red);
      }
    }
    return MaterialStateProperty.all(null);
  }

  @override
  Widget build(BuildContext context) {
    return quizAppPage();
  }

  Scaffold quizAppPage() {
    if (isQuestionPage == true) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "QuizApp",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Colors.orange,
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              "Question : ${currentQuestionIndex + 1}/${allQuestions.length}",
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                allQuestions[currentQuestionIndex]['question'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.purple,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Option buttons
            for (int i = 0;
                i < allQuestions[currentQuestionIndex]['options'].length;
                i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: checkAnswer(i)),
                    onPressed: () {
                      if (selectedAnswerIndex == -1) {
                        selectedAnswerIndex = i;

                        // Score logic
                        if (i ==
                            allQuestions[currentQuestionIndex]
                                ['correctAnswer']) {
                          score++;
                        }
                        setState(() {});
                      }
                    },
                    child: Text(
                      allQuestions[currentQuestionIndex]['options'][i],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
          ],
        ),

        // Next button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (selectedAnswerIndex != -1) {
              if (currentQuestionIndex < allQuestions.length - 1) {
                currentQuestionIndex++;
                selectedAnswerIndex = -1;
              } else {
                isQuestionPage = false;
              }
              setState(() {});
            }
          },
          backgroundColor: Colors.blue,
          child: const Text(
            "Next",
            style: TextStyle(fontSize: 15, color: Colors.orange),
          ),
        ),
      );
    } else {
      // Result page
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text("Result Screen", style: TextStyle(fontSize: 30)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://c8.alamy.com/comp/T17XE1/background-with-realistic-vector-3d-blank-golden-shiny-champion-cup-championship-trophy-sport-tournament-award-gold-winner-cup-and-victory-concept-T17XE1.jpg",
                width: 300,
                height: 300,
              ),
              const SizedBox(height: 30),
              const Text(
                "Congratulations",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 15),
              Text(
                "Score: $score/${allQuestions.length}",
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      );
    }
  }
}
