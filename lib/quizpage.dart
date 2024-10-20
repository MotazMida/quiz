import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // Variables to track the selected answer for each question
  String selectedAnswer1 = '';
  String selectedAnswer2 = '';
  String selectedAnswer3 = '';

  // Correct answers for each question
  final String correctAnswer1 = '15';
  final String correctAnswer2 = 'Benzema';
  final String correctAnswer3 = 'C. Ronaldo';

  // Variable to track score
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Center(
          child: Text('Quiz Time',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'images/quizz.jpeg',
                  width: 320,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 30),

            // First question
            Text(
              '1. How many UCL cups does Real Madrid have?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOptionButton('8', selectedAnswer1, correctAnswer1, 1),
                _buildOptionButton('10', selectedAnswer1, correctAnswer1, 1),
                _buildOptionButton('15', selectedAnswer1, correctAnswer1, 1),
              ],
            ),
            SizedBox(height: 30), // Space between questions

            // Second question
            Text(
              '2. Who scored against Liverpool in the 2022 UCL final?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOptionButton(
                    'Rodrygo', selectedAnswer2, correctAnswer2, 2),
                _buildOptionButton(
                    'Benzema', selectedAnswer2, correctAnswer2, 2),
                _buildOptionButton(
                    'Toni Kroos', selectedAnswer2, correctAnswer2, 2),
              ],
            ),
            SizedBox(height: 30), // Space between questions

            // Third question
            Text(
              '3. Who is the GOAT of football?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOptionButton(
                    'M. Salah', selectedAnswer3, correctAnswer3, 3),
                _buildOptionButton(
                    'C. Ronaldo', selectedAnswer3, correctAnswer3, 3),
                _buildOptionButton(
                    'K. Mbappe', selectedAnswer3, correctAnswer3, 3),
              ],
            ),
            SizedBox(height: 30), // Space between questions

            Center(
              child: ElevatedButton(
                onPressed: _isQuizComplete()
                    ? () {
                        // Navigate to ResultPage with score
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultPage(score: score),
                          ),
                        );
                      }
                    : null, // Disable button if quiz not complete
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: Text(
                  'Submit Quiz',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(),
    );
  }

  // Method to build option buttons for questions
  Widget _buildOptionButton(String text, String selectedAnswer,
      String correctAnswer, int questionNumber) {
    Color buttonColor = Colors.teal[600]!; // Default button color

    if (selectedAnswer.isNotEmpty) {
      if (selectedAnswer == text) {
        buttonColor =
            selectedAnswer == correctAnswer ? Colors.green : Colors.red;
      }
    }

    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (questionNumber == 1) {
            selectedAnswer1 = text;
            if (text == correctAnswer1) {
              score++;
            }
          } else if (questionNumber == 2) {
            selectedAnswer2 = text;
            if (text == correctAnswer2) {
              score++;
            }
          } else if (questionNumber == 3) {
            selectedAnswer3 = text;
            if (text == correctAnswer3) {
              score++;
            }
          }
        });
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  // Check if all questions are answered
  bool _isQuizComplete() {
    return selectedAnswer1.isNotEmpty &&
        selectedAnswer2.isNotEmpty &&
        selectedAnswer3.isNotEmpty;
  }
}

class ResultPage extends StatelessWidget {
  final int score;

  const ResultPage({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Center(
          child: Text(
            'Quiz Results',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '$score/3',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the quiz page
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: Text(
                'Try Again',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
