import 'package:beanmind_flutter/quiz_content.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF16B6DF),
        title: Row(
          children: [
            const SizedBox(width: 10),
            const Text(
              'BeanMind',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              width: 10,
            ),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all<Color>(Color(0xFF429CC0)),
                padding:
                    WidgetStateProperty.all<EdgeInsets>(EdgeInsets.all(12)),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 16,
                  ),
                  Text(
                    'Back',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {}),
            IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () {}),
          ],
        ),
        actions: const [
          // Add any additional actions here
        ],
      ),
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            color: const Color(0xFFF0FDF3),
            child: Column(
              children: [
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'User Proficiency',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: List.generate(10, (index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (index < 10 && index > 1)
                                  Container(
                                    width: 2,
                                    height: 10,
                                    color: Colors.grey,
                                  ),
                                Icon(
                                  Icons.check_circle,
                                  color: index.isEven ? Colors.green : Colors.blue,
                                ),
                                if (index < 9)
                                  Container(
                                    width: 2,
                                    height: 10,
                                    color: Colors.grey,
                                  ),
                              ],
                            ),
                            title: Text(
                              'Question ${index + 1}',
                              style: const TextStyle(color: Colors.black),
                            ),
                            trailing: const Text(
                              '+1',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onTap: () {
                              // Update the state of the app
                              // ...
                            },
                          ),
                          if (index < 9)
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                              indent: 16.0, // Indent so it lines up with the text
                            ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: QuizContent(),
          ),
        ],
      ),
    );
  }
}
