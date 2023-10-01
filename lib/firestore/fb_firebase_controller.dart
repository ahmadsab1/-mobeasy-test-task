import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobeasy_test_task/model/questions.dart';
import 'package:mobeasy_test_task/model/user_answer.dart';

class FbFireStoreController {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;


  Future<bool> create(UserAnswer userAnswer) {
    return _instance
        .collection('UserAnswer')
        .add(userAnswer.toMap())
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }


  Stream<QuerySnapshot<Question1>> read() async* {
    yield* _instance
        .collection('Question')
        .withConverter(
            fromFirestore: (snapshot, options) {
              final data = snapshot.data();
              if (data != null) {
                return Question1.fromMap(data);
              } else {
                throw Exception('Failed to parse Question from Firestore');
              }
            },
            toFirestore: (value, options) => value.toMap())
        .snapshots();
  }

  Stream<QuerySnapshot<UserAnswer>> readUserAnswer() async* {
    yield* _instance
        .collection('UserAnswer')
        .withConverter(
        fromFirestore: (snapshot, options) {
          final data = snapshot.data();
          if (data != null) {
            return UserAnswer.fromMap(data);
          } else {
            throw Exception('Failed to parse UserAnswer from Firestore');
          }
        },
        toFirestore: (value, options) => value.toMap())
        .snapshots();
  }
}

