import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobeasy_test_task/firestore/fb_firebase_controller.dart';
import 'package:mobeasy_test_task/model/user_answer.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<UserAnswer>>(
      stream: FbFireStoreController().readUserAnswer(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(snapshot.data!.docs[index].data().user),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('1+1 ='),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            snapshot.data!.docs[index].data().answer1 == '2'
                                ? '/'
                                : 'x',
                            style: TextStyle(
                              color:
                                  snapshot.data!.docs[index].data().answer1 ==
                                          '2'
                                      ? Colors.green
                                      : Colors.red,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('2+2 ='),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            snapshot.data!.docs[index].data().answer2 == '4'
                                ? '/'
                                : 'x',
                            style: TextStyle(
                              color:
                                  snapshot.data!.docs[index].data().answer2 ==
                                          '4'
                                      ? Colors.green
                                      : Colors.red,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('3+3 ='),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            snapshot.data!.docs[index].data().answer3 == '6'
                                ? '/'
                                : 'x',
                            style: TextStyle(
                              color:
                                  snapshot.data!.docs[index].data().answer3 ==
                                          '6'
                                      ? Colors.green
                                      : Colors.red,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: Text("no data"));
        }
      },
    );
  }
}
