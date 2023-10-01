import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobeasy_test_task/firestore/fb_firebase_controller.dart';
import 'package:mobeasy_test_task/leaderboard.dart';
import 'package:mobeasy_test_task/model/questions.dart';
import 'package:mobeasy_test_task/model/user_answer.dart';
import 'package:mobeasy_test_task/services/auth_service.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  String? _answer;
  late String answer1;
  late String answer2;
  late String answer3;
  int _questionNum = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () => AuthService().signInWithGoogle(),
            icon: Image.asset('images/google logo.png'),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Question1>>(
        stream: FbFireStoreController().read(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  const Text(
                    'Question:',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${snapshot.data!.docs[_questionNum].data().question11}=',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Answers:',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RadioListTile(
                    title: Text(
                      snapshot.data!.docs[0].data().answer,
                    ),
                    value: snapshot.data!.docs[0].data().answer,
                    groupValue: _answer,
                    onChanged: (value) {
                      setState(() {
                        _answer = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text(
                      snapshot.data!.docs[1].data().answer,
                    ),
                    value: snapshot.data!.docs[1].data().answer,
                    groupValue: _answer,
                    onChanged: (value) {
                      setState(() {
                        _answer = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text(
                      snapshot.data!.docs[2].data().answer,
                    ),
                    value: snapshot.data!.docs[2].data().answer,
                    groupValue: _answer,
                    onChanged: (value) {
                      setState(() {
                        _answer = value;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(
                            () {
                              if (_questionNum >= 0 &&
                                  _questionNum <= 2 &&
                                  _answer != null) {
                                if (_questionNum == 0) {
                                  answer1 = _answer!;
                                }
                                if (_questionNum == 1) {
                                  answer2 = _answer!;
                                }
                                if (_questionNum == 2) {
                                  answer3 = _answer!;
                                }
                                if (_questionNum == 2) {
                                  _save();
                                  _questionNum -= 3;
                                }
                                _questionNum++;
                                _answer = null;
                              }
                            },
                          );
                        },
                        child: Text(
                          _questionNum == 2 ? 'restart ' : 'Next Question ',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Visibility(
                        visible: _questionNum == 2,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                _save();
                              },
                            );
                          },
                          child: const Text(
                            'save ',
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: const [
                      LeaderBoard(),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("no data"));
          }
        },
      ),
    );
  }

  void _save() async {
    UserAnswer useranswernote = UserAnswer();
    String? userEmail = AuthService().getUserEmail();
    if (userEmail != null) {
      useranswernote.user = userEmail;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          content: Text(
            'please sign in by your Google Account from the appbar',
          ),
        ),
      );
    }
    useranswernote.answer1 = answer1;
    useranswernote.answer2 = answer2;
    useranswernote.answer3 = answer3;
    FbFireStoreController().create(useranswernote);
  }
}
